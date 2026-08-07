package entity;

public class OrderDetailDTO {
    private String productId;
    private String tenSanPham;
    private int soLuong;
    private double dongGia;

    public OrderDetailDTO(String productId, String tenSanPham, int soLuong, double dongGia) {
        this.productId = productId;
        this.tenSanPham = tenSanPham;
        this.soLuong = soLuong;
        this.dongGia = dongGia;
    }

    public String getProductId() { return productId; }
    public String getTenSanPham() { return tenSanPham; }
    public int getSoLuong() { return soLuong; }
    public double getDongGia() { return dongGia; }
    public double getThanhTien() { return soLuong * dongGia; }
}
