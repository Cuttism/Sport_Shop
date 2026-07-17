package entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DonHang {
    private String id;
    private String customerId;
    private String salesStaffId;
    private String warehouseStaffId;
    private String trangThai;
    private double tongTien;
}
