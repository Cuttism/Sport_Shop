package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import entity.DonHangInfoDTO;
import util.DBContext;

public class DonHangDAO {

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
