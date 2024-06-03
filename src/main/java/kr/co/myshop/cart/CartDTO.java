package kr.co.myshop.cart;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class CartDTO {

    private int cartno;
    private int product_code;
    private int price;
    private int qty;
    private String id;
    private String regdate;
    
}//class end
