package entity;

import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Review {
    private int id;
    private String productId;
    private String customerId;
    private String customerName; // Để tiện hiển thị lên UI
    private int soSao;
    private String noiDung;
    private Date ngayDanhGia;
}
