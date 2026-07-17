package entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SanPham {
    private String id;
    private String tenSanPham;
    private int soLuongTon;
    private double gia;
}
