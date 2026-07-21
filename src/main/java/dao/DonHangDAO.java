package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import entity.CartItem;
import entity.DonHang;
import entity.DonHangInfoDTO;
import util.DBContext;

public class DonHangDAO {

    public boolean insertOrder(DonHang dh, List<CartItem> cart) {
        String sqlOrder = "INSERT INTO DON_HANG (Id, CustomerId, SalesStaffId, WarehouseStaffId, TrangThai, TongTien) VALUES (?, ?, ?, ?, ?, ?)";
        String sqlDetail = "INSERT INTO CHI_TIET_DON_HANG (Id, OrderId, ProductId, SoLuong, DongGia) VALUES (?, ?, ?, ?, ?)";
        
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            conn.setAutoCommit(false); // Bật transaction
            
            // Insert bảng DON_HANG
            try (PreparedStatement psOrder = conn.prepareStatement(sqlOrder)) {
                psOrder.setString(1, dh.getId());
                psOrder.setString(2, dh.getCustomerId());
                psOrder.setString(3, dh.getSalesStaffId());
                psOrder.setString(4, dh.getWarehouseStaffId());
                psOrder.setString(5, dh.getTrangThai());
                psOrder.setDouble(6, dh.getTongTien());
                psOrder.executeUpdate();
            }
            
            // Insert bảng CHI_TIET_DON_HANG
            try (PreparedStatement psDetail = conn.prepareStatement(sqlDetail)) {
                int count = 1;
                for (CartItem item : cart) {
                    // ID chi tiết đơn ngẫu nhiên dựa theo OrderId để không trùng
                    String detailId = "CT_" + dh.getId() + "_" + count++;
                    psDetail.setString(1, detailId);
                    psDetail.setString(2, dh.getId());
                    psDetail.setString(3, item.getProduct().getId());
                    psDetail.setInt(4, item.getQuantity());
                    psDetail.setDouble(5, item.getProduct().getGia());
                    psDetail.addBatch();
                }
                psDetail.executeBatch();
            }
            
            conn.commit();
            return true;
        } catch (Exception e) {
            try { if (conn != null) conn.rollback(); } catch (Exception ex) {}
            e.printStackTrace();
            return false;
        } finally {
            try { if (conn != null) { conn.setAutoCommit(true); conn.close(); } } catch (Exception ex) {}
        }
    }

    public List<DonHangInfoDTO> getDonHangInfo() {
        List<DonHangInfoDTO> list = new ArrayList<>();
        String sql = "SELECT \n" +
                     "    DH.Id AS [Mã Đơn Hàng],\n" +
                     "    KH.HoTen AS [Tên Khách Hàng],\n" +
                     "    NVBH.HoTen AS [Nhân Viên Bán Hàng],\n" +
                     "    NVK.HoTen AS [Nhân Viên Kho Xuất],\n" +
                     "    DH.TongTien AS [Tổng Tiền Hóa Đơn],\n" +
                     "    DH.TrangThai AS [Trạng Thái]\n" +
                     "FROM DON_HANG DH\n" +
                     "JOIN KHACH_HANG KH ON DH.CustomerId = KH.Id\n" +
                     "JOIN NHAN_VIEN_BAN_HANG NVBH ON DH.SalesStaffId = NVBH.Id\n" +
                     "JOIN NHAN_VIEN_KHO NVK ON DH.WarehouseStaffId = NVK.Id";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                DonHangInfoDTO dto = new DonHangInfoDTO(
                        rs.getString("Mã Đơn Hàng"),
                        rs.getString("Tên Khách Hàng"),
                        rs.getString("Nhân Viên Bán Hàng"),
                        rs.getString("Nhân Viên Kho Xuất"),
                        rs.getDouble("Tổng Tiền Hóa Đơn"),
                        rs.getString("Trạng Thái")
                );
                list.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
