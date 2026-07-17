package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import entity.UserSession;
import util.DBContext;

public class UserDAO {

	/**
	 * Tìm người dùng theo ID từ database. Dựa vào prefix của ID để biết cần tìm
	 * trong bảng nào: - NVIT -> NHAN_VIEN_IT (role = ADMIN) - NVBH ->
	 * NHAN_VIEN_BAN_HANG (role = STAFF) - NVK -> NHAN_VIEN_KHO (role = STAFF) - KH
	 * -> KHACH_HANG (role = CUSTOMER)
	 */
	public UserSession findById(String id) {
		if (id == null || id.trim().isEmpty()) {
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

		String sql = "SELECT Id, HoTen FROM " + tableName + " WHERE Id = ?";

		try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, cleanId);
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

	/**
	 * Kiểm tra ID đã tồn tại trong bất kỳ bảng nào chưa.
	 */
	public boolean checkIdExist(String id) {
		if (id == null || id.trim().isEmpty()) {
			return false;
		}
		// Có thể tồn tại ở KHACH_HANG hoặc NV
		String[] tables = {"KHACH_HANG", "NHAN_VIEN_IT", "NHAN_VIEN_BAN_HANG", "NHAN_VIEN_KHO"};
		
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
	public boolean registerCustomer(String id, String hoTen, String dienThoai, String diaChi) {
		String sql = "INSERT INTO KHACH_HANG (Id, HoTen, DienThoai, DiaChi) VALUES (?, ?, ?, ?)";
		try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, id.trim());
			ps.setString(2, hoTen.trim());
			ps.setString(3, dienThoai.trim());
			ps.setString(4, diaChi.trim());
			int affectedRows = ps.executeUpdate();
			return affectedRows > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
}
