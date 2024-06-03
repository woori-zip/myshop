package kr.co.myshop.product;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class ProductDTO {

	private int product_code;
	private String product_name;
	private String description;
	private int price;
	private String filename;
	private long filesize;
	private String regdate;
	
}//class end
