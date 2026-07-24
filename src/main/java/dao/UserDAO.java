package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import entity.KhachHang;
import entity.UserSession;
import util.DBContext;

public class UserDAO {

	/**
	 * Tìm người dùng theo ID từ database. Dựa vào prefix của ID để biết cần tìm
	 * trong bảng nào: - NVIT -> NHAN_VIEN_IT (role = ADMIN) - NVBH ->
	 * NHAN_VIEN_BAN_HANG (role = STAFF) - NVK -> NHAN_VIEN_KHO (role = STAFF) - KH
	 * -> KHACH_HANG (role = CUSTOMER)
	 */
	public UserSession login(String id, String password) {
		if (id == null || id.trim().isEmpty() || password == null || password.trim().isEmpty()) {
			return null;
		}

		String cleanId = id.trim();
		String tableName;
		String role;

		if (cleanId.startsWith("NVIT")) {
			tableName = "NHAN_VIEN_IT";
			role = "ADMIN";
		} else if (cleanId.startsWith("NVBH")) {
			tableName = "NHAN_VIEN_BAN_HANG";
			role = "STAFF";
		} else if (cleanId.startsWith("NVK")) {
			tableName = "NHAN_VIEN_KHO";
			role = "STAFF";
		} else if (cleanId.startsWith("KH")) {
			tableName = "KHACH_HANG";
			role = "CUSTOMER";
		} else {
			return null; // ID không hợp lệ
		}

		String sql = "SELECT Id, HoTen FROM " + tableName + " WHERE Id = ? AND MatKhau = ?";

		try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, cleanId);
			ps.setString(2, password);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				String hoTen = rs.getString("HoTen");
				return new UserSession(cleanId, hoTen, role);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return null; // Không tìm thấy trong database
	}

	public KhachHang getCustomerById(String id) {
		String sql = "SELECT * FROM KHACH_HANG WHERE Id = ?";
		try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				KhachHang kh = new KhachHang();
				kh.setId(rs.getString("Id"));
				kh.setHoTen(rs.getString("HoTen"));
				kh.setDienThoai(rs.getString("DienThoai"));
				kh.setDiaChi(rs.getString("DiaChi"));
				kh.setEmail(rs.getString("Email"));
				kh.setNgaySinh(rs.getDate("NgaySinh"));
				kh.setGioiTinh(rs.getString("GioiTinh"));
				kh.setMatKhau(rs.getString("MatKhau"));
				return kh;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public boolean updateCustomer(String id, String hoTen, String dienThoai, String diaChi, String email, java.sql.Date ngaySinh, String gioiTinh, String matKhau) {
		String sql = "UPDATE KHACH_HANG SET HoTen = ?, DienThoai = ?, DiaChi = ?, Email = ?, NgaySinh = ?, GioiTinh = ?, MatKhau = ? WHERE Id = ?";
		try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, hoTen);
			ps.setString(2, dienThoai);
			ps.setString(3, diaChi);
			ps.setString(4, email);
			ps.setDate(5, ngaySinh);
			ps.setString(6, gioiTinh);
			ps.setString(7, matKhau);
			ps.setString(8, id);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	/**
	 * Kiểm tra ID đã tồn tại trong bất kỳ bảng nào chưa.
	 */
	public boolean checkIdExist(String id) {
		if (id == null || id.trim().isEmpty()) {
			return false;
		}
		// Có thể tồn tại ở KHACH_HANG hoặc NV
		String[] tables = { "KHACH_HANG", "NHAN_VIEN_IT", "NHAN_VIEN_BAN_HANG", "NHAN_VIEN_KHO" };

		for (String table : tables) {
			String sql = "SELECT 1 FROM " + table + " WHERE Id = ?";
			try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
				ps.setString(1, id.trim());
				ResultSet rs = ps.executeQuery();
				if (rs.next()) {
					return true;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return false;
	}

	/**
	 * Đăng ký khách hàng mới.
	 */
	public boolean registerCustomer(String id, String hoTen, String dienThoai, String diaChi, String email, java.sql.Date ngaySinh, String gioiTinh, String matKhau) {
		String sql = "INSERT INTO KHACH_HANG (Id, HoTen, DienThoai, DiaChi, Email, NgaySinh, GioiTinh, MatKhau) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, id.trim());
			ps.setString(2, hoTen.trim());
			ps.setString(3, dienThoai.trim());
			ps.setString(4, diaChi.trim());
			ps.setString(5, email != null ? email.trim() : null);
			ps.setDate(6, ngaySinh);
			ps.setString(7, gioiTinh != null ? gioiTinh.trim() : null);
			ps.setString(8, matKhau != null && !matKhau.trim().isEmpty() ? matKhau.trim() : "123");
			int affectedRows = ps.executeUpdate();
			return affectedRows > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public String getPasswordById(String id) {
		String tableName = getTableNameById(id);
		if (tableName == null) return "123";
		String sql = "SELECT MatKhau FROM " + tableName + " WHERE Id = ?";
		try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getString("MatKhau");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return "123";
	}

	public boolean updateGenericUser(String id, String hoTen, String matKhau) {
		String tableName = getTableNameById(id);
		if (tableName == null) return false;
		String sql = "UPDATE " + tableName + " SET HoTen = ?, MatKhau = ? WHERE Id = ?";
		try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, hoTen);
			ps.setString(2, matKhau);
			ps.setString(3, id);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	private String getTableNameById(String id) {
		if (id.startsWith("NVIT")) return "NHAN_VIEN_IT";
		if (id.startsWith("NVBH")) return "NHAN_VIEN_BAN_HANG";
		if (id.startsWith("NVK")) return "NHAN_VIEN_KHO";
		if (id.startsWith("KH")) return "KHACH_HANG";
		return null;
	}
}
