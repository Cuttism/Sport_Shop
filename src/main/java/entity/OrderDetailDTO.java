package entity;

public class OrderDetailDTO {
    private String tenSanPham;
    private int soLuong;
    private double dongGia;

    public OrderDetailDTO(String tenSanPham, int soLuong, double dongGia) {
        this.tenSanPham = tenSanPham;
        this.soLuong = soLuong;
        this.dongGia = dongGia;
    }

    public String getTenSanPham() { return tenSanPham; }
    public int getSoLuong() { return soLuong; }
    public double getDongGia() { return dongGia; }
    public double getThanhTien() { return soLuong * dongGia; }
}
