package entity;

import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class HoaDon {
    private String id;
    private String orderId;
    private Date ngayLap;
    private String phuongThucThanhToan;
    private double tongTien;
    private String ghiChu;
}
