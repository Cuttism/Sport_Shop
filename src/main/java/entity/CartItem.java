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
        if (product != null) {
            return product.getGia() * quantity;
        }
        return 0;
    }
}