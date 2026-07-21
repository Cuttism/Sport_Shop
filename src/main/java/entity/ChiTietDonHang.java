package entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChiTietDonHang {
    private String id;
    private String orderId;
    private String productId;
    private int soLuong;
    private double dongGia;
}
