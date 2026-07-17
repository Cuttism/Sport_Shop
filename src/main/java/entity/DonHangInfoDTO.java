package entity;

public class DonHangInfoDTO {
    private String id;
    private String tenKhachHang;
    private String tenNhanVienBanHang;
    private String tenNhanVienKho;
    private double tongTien;
    private String trangThai;

    public DonHangInfoDTO(String id, String tenKhachHang, String tenNhanVienBanHang, String tenNhanVienKho, double tongTien, String trangThai) {
        this.id = id;
        this.tenKhachHang = tenKhachHang;
        this.tenNhanVienBanHang = tenNhanVienBanHang;
        this.tenNhanVienKho = tenNhanVienKho;
        this.tongTien = tongTien;
        this.trangThai = trangThai;
    }

    public String getId() { return id; }
    public String getTenKhachHang() { return tenKhachHang; }
    public String getTenNhanVienBanHang() { return tenNhanVienBanHang; }
    public String getTenNhanVienKho() { return tenNhanVienKho; }
    public double getTongTien() { return tongTien; }
    public String getTrangThai() { return trangThai; }
}
