package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import entity.Review;
import util.DBContext;

public class ReviewDAO {

    public List<Review> findByProductId(String productId) {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT R.*, K.HoTen FROM DANH_GIA_SAN_PHAM R JOIN KHACH_HANG K ON R.CustomerId = K.Id WHERE R.ProductId = ? ORDER BY R.NgayDanhGia DESC";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, productId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Review r = new Review();
                r.setId(rs.getInt("Id"));
                r.setProductId(rs.getString("ProductId"));
                r.setCustomerId(rs.getString("CustomerId"));
                r.setCustomerName(rs.getString("HoTen"));
                r.setSoSao(rs.getInt("SoSao"));
                r.setNoiDung(rs.getString("NoiDung"));
                r.setNgayDanhGia(rs.getTimestamp("NgayDanhGia"));
                list.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean insertReview(String productId, String customerId, int soSao, String noiDung) {
        String sql = "INSERT INTO DANH_GIA_SAN_PHAM (ProductId, CustomerId, SoSao, NoiDung, NgayDanhGia) VALUES (?, ?, ?, ?, GETDATE())";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, productId);
            ps.setString(2, customerId);
            ps.setInt(3, soSao);
            ps.setString(4, noiDung);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
