package entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class KhachHang {
    private String id;
    private String hoTen;
    private String dienThoai;
    private String diaChi;
    private String email;
    private java.sql.Date ngaySinh;
    private String gioiTinh;
    private String matKhau;
}
