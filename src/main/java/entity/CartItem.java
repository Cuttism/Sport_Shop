package entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CartItem {
    private SanPham product;
    private int quantity;
    
    public double getSubtotal() {
        return product != null ? product.getGia() * quantity : 0;
    }
}
