package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import util.DBContext;

public class AnalyticsDAO {

	/**
	 * Tổng doanh thu từ bảng HOA_DON (chỉ tính hóa đơn đã xuất)
	 */
	public double getTotalRevenue() {
		String sql = "SELECT ISNULL(SUM(TongTien), 0) AS TongDoanhThu FROM HOA_DON";
		try (Connection conn = DBContext.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			if (rs.next()) {
				return rs.getDouble("TongDoanhThu");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

	/**
	 * Tổng số đơn hàng từ bảng DON_HANG
	 */
	public int getTotalOrders() {
		String sql = "SELECT COUNT(*) AS TongDon FROM DON_HANG";
		try (Connection conn = DBContext.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			if (rs.next()) {
				return rs.getInt("TongDon");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

	/**
	 * Tổng số khách hàng từ bảng KHACH_HANG
	 */
	public int getTotalCustomers() {
		String sql = "SELECT COUNT(*) AS TongKH FROM KHACH_HANG";
		try (Connection conn = DBContext.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			if (rs.next()) {
				return rs.getInt("TongKH");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

	/**
	 * Tổng số sản phẩm từ bảng SAN_PHAM
	 */
	public int getTotalProducts() {
		String sql = "SELECT COUNT(*) AS TongSP FROM SAN_PHAM";
		try (Connection conn = DBContext.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			if (rs.next()) {
				return rs.getInt("TongSP");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

	/**
	 * Tổng số hóa đơn đã xuất từ bảng HOA_DON
	 */
	public int getTotalBills() {
		String sql = "SELECT COUNT(*) AS TongHD FROM HOA_DON";
		try (Connection conn = DBContext.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			if (rs.next()) {
				return rs.getInt("TongHD");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

	/**
	 * Số đơn hàng đang chờ xử lý
	 */
	public int getPendingOrders() {
		String sql = "SELECT COUNT(*) AS ChoDon FROM DON_HANG WHERE TrangThai = N'Chờ xử lý'";
		try (Connection conn = DBContext.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			if (rs.next()) {
				return rs.getInt("ChoDon");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}
}
