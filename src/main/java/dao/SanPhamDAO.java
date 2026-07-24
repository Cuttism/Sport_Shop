package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import entity.SanPham;
import util.DBContext;

public class SanPhamDAO {

    public SanPham findById(String id) {
        String sql = "SELECT * FROM SAN_PHAM WHERE Id = ?";
        try (Connection conn = new DBContext().getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    SanPham sp = new SanPham();
                    sp.setId(rs.getString("Id"));
                    sp.setTenSanPham(rs.getString("TenSanPham"));
                    sp.setSoLuongTon(rs.getInt("SoLuongTon"));
                    sp.setGia(rs.getDouble("Gia"));
                    return sp;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<SanPham> searchByName(String keyword) {
        List<SanPham> list = new ArrayList<>();
        String sql = "SELECT * FROM SAN_PHAM WHERE TenSanPham LIKE ?";
        try (Connection conn = new DBContext().getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SanPham sp = new SanPham();
                    sp.setId(rs.getString("Id"));
                    sp.setTenSanPham(rs.getString("TenSanPham"));
                    sp.setSoLuongTon(rs.getInt("SoLuongTon"));
                    sp.setGia(rs.getDouble("Gia"));
                    list.add(sp);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<SanPham> findAll() {
        List<SanPham> list = new ArrayList<>();
        String sql = "SELECT * FROM SAN_PHAM";
        try (Connection conn = new DBContext().getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                SanPham sp = new SanPham();
                sp.setId(rs.getString("Id"));
                sp.setTenSanPham(rs.getString("TenSanPham"));
                sp.setSoLuongTon(rs.getInt("SoLuongTon"));
                sp.setGia(rs.getDouble("Gia"));
                list.add(sp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public boolean insert(SanPham sp) {
        String sql = "INSERT INTO SAN_PHAM (Id, TenSanPham, SoLuongTon, Gia) VALUES (?, ?, ?, ?)";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, sp.getId());
            ps.setString(2, sp.getTenSanPham());
            ps.setInt(3, sp.getSoLuongTon());
            ps.setDouble(4, sp.getGia());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean update(SanPham sp) {
        String sql = "UPDATE SAN_PHAM SET TenSanPham = ?, SoLuongTon = ?, Gia = ? WHERE Id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, sp.getTenSanPham());
            ps.setInt(2, sp.getSoLuongTon());
            ps.setDouble(3, sp.getGia());
            ps.setString(4, sp.getId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean delete(String id) {
        String sql = "DELETE FROM SAN_PHAM WHERE Id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
