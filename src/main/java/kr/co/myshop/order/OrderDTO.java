package kr.co.myshop.order;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class OrderDTO {

	private String orderno;  
	private String id;  
	private int totalamount;             
	private String payment;   
	private String deliverynm; 
	private String deliveryaddr;
	private String deliverymsg;  
	private String ordercheck;   
	private String orderdate;
	
	
}
