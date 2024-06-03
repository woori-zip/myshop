package kr.co.myshop.order;

import java.math.BigDecimal;
import java.net.Authenticator;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;
import net.utility.MyAuthenticator;
import net.utility.Utility;

@Controller
@RequestMapping("/order")
public class OrderCont {
	public OrderCont() {
		System.out.println("----OrderCont() 객체 생성됨");
	}//end
	
	@Autowired
	OrderDAO orderDao;
	
	@GetMapping("/orderform")
	public String orderFrom() {
		return "/order/orderform";
	}//orderFrom() end
	
	@PostMapping("/insert")
	public ModelAndView orderInsert(@ModelAttribute OrderDTO orderDto, HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/order/msgView");
		
		//사용자가 입력한 정보가 DTO에 저장되었는지 확인
		//System.out.println(orderDto.toString());
		
		//String s_id = session.getAttribute("세션변수명");
		String s_id = "itwill";
		
		//1) 총 결제금액 구하기
		int totalamount = orderDao.totalamount(s_id);
		System.out.println(totalamount);
		
		//2) 주문서 번호 생성하기
		//	 예) 최초주문 202405281
		//		 있으면  202405282
		
		//오늘날짜 및 현재시각을 문자열 "년월일시분초"로 구성해서 반환
		SimpleDateFormat sd = new SimpleDateFormat("yyyyMMddHHmmss");
		//SimpleDateFormat sd = new SimpleDateFormat("yyyyMMdd");
		String cdate = sd.format(new Date());
		//System.out.println(cdate);
		
		String orderno = orderDao.orderno(cdate);
		if(orderno.equals("1")) {//최초주문
			orderno = cdate + "1"; //"20240528115437"+"1"
		} else {
			long n = Long.parseLong(orderno.substring(14))+1;//맨마지막글자+1
			//int n = Integer.parseInt(orderno.trim().substring(8))+1;//맨마지막글자+1
			orderno = cdate + n;
		}//if end
		System.out.println(orderno);
		
		//3) orderDto에 세션아이디, 총결제금액, 주문서번호 추가로 담기
		orderDto.setId(s_id);
		orderDto.setTotalamount(totalamount);
		orderDto.setOrderno(orderno);
		System.out.println(orderDto.toString());
		
		//4) orderlist 테이블에 3)의 내용으로 행 추가하기
		int cnt = orderDao.orderlistInsert(orderDto);
		if(cnt==1) {
			
			
			//5) cart 테이블에 있는 주문상품내역을 orderdetail 테이블에 옮겨 담기
			HashMap<String, String> map = new HashMap<>();
			map.put("orderno", orderno);
			map.put("s_id", s_id);
			
			int result = orderDao.orderdetailInsert(map);
			if(result != 0) {
				//6) cart 테이블 비우기
				orderDao.cartDelete(s_id);
				
				//7) 주문내역서 메일 보내기
				String content = order_sendMail(orderDto);
				
				mav.addObject("msg1", "<img src='../images/logo_itwill.png'>");
				mav.addObject("msg2", "<p>주문이 완료되었습니다.</p>");
				mav.addObject("msg3", "<p><a href='/product/list'>[계속 쇼핑하기]</a></p>");
				mav.addObject("content", content); //주문서
			}else {
				mav.addObject("msg1", "<img src='../images/fail.png'>");
				mav.addObject("msg2", "<p>주문에 실패하였습니다.</p>");
				mav.addObject("msg3", "<p><a href='javascript:history.back()'>[다시시도]</a></p>");
			}//if end

		} else {
			mav.addObject("msg1", "<img src='../images/fail.png'>");
			mav.addObject("msg2", "<p>주문에 실패하였습니다.</p>");
			mav.addObject("msg3", "<p><a href='javascript:history.back()'>[다시시도]</a></p>");
		}//if end
		
		return mav;
	}//orderInsert() end
	
	public String order_sendMail(OrderDTO orderDto) {
		//주문번호가 일치하는 정보를 orderlist와 orderdetail 테이블에서 가져오기
		
		List<HashMap<String, Object>> orderDesc = orderDao.orderDesc(orderDto.getOrderno());
		
		//데이터를 불러오는지 확인
	    System.out.println("order_sendMail orderDesc: " + orderDesc.toString());
	    
		String content = "";
		//content += "";

		//주문내역서 완성하기
		//-> 동일한 내용이므로 아무거나 가져와도 됨
		//-> 주의: 오라클DB에서 칼럼명은 대문자로 변환
		HashMap<String, Object> orderlist = orderDesc.get(0); 
		String orderno 		= (String)orderlist.get("ORDERNO");		//주문서번호
		String deliverynm 	= (String)orderlist.get("DELIVERYNM");	//수령인
		String deliveryaddr = (String)orderlist.get("DELIVERYADDR");//배송지주소
		String deliverymsg	= Utility.checkNull((String)orderlist.get("DELIVERYMSG"));	//배송메세지
		//String totalamount	= (String)orderlist.get("TOTALAMOUNT");
		String payment 		= (String)orderlist.get("PAYMENT");		//결제수단
		String orderdate 	= (String)orderlist.get("ORDERDATE");	//결제일
		BigDecimal totalamount = (BigDecimal)orderlist.get("TOTALAMOUNT"); // 결제금액
		
		
		content += "<table border='1'>";
		content += "<tr>";
		content += "	<td colspan='2'>";
		content += "		<img src='https://www.itwill.co.kr/css/wvtex/img/wvUser/logo.png'>";
		content += "	</td>";
		content += "</tr>";
		content += "<tr>";
		content += "	<td colspan='2'>[My shop 주문서]</td>";
		content += "</tr>";
		content += "<tr>";
		content += "	<th>주문서번호</th>";
		content += "	<td>"+ orderno +"</td>";
		content += "</tr>";
		content += "<tr>";
		content += "	<th>수령인</th>";
		content += "	<td>"+ deliverynm +"</td>";
		content += "</tr>";
		content += "<tr>";
		content += "	<th>배송지</th>";
		content += "	<td>"+ deliveryaddr +"</td>";
		content += "</tr>";
		content += "<tr>";
		content += "	<th>배송 메세지</th>";
		content += "	<td>"+ deliverymsg +"</td>";
		content += "</tr>";
		content += "<tr>";
		content += "	<th>결제</th>";
		content += "	<td>"+ payment +"</td>";
		content += "</tr>";
		content += "<tr>";
		content += "	<th>결제일</th>";
		content += "	<td>"+ orderdate +"</td>";
		content += "</tr>";
		content += "<tr>";
		content += "	<th>결제금액</th>";
		content += "	<td>"+ totalamount +"</td>";
		content += "</tr>";
		content += "</table>";
	
		content += "<hr>";
		
		content += "<table border='1'>";
		content += "<tr>";
		content += "	<td colspan='4'>주/문/상/품/목/록</td>";
		content += "</tr>";
		content += "<tr>";
		content += "	<td>상품명</td>";
		content += "	<td>단가</td>";
		content += "	<td>수량</td>";
		content += "	<td>가격</td>";
		content += "</tr>";
		
		for(int i=0; i<orderDesc.size(); i++) {
			HashMap<String, Object> hm = orderDesc.get(i);
			content += "<tr>";
			content += "	<td>"+ hm.get("PRODUCT_NAME") +"</td>";
			content += "	<td>"+ hm.get("PRICE") +"</td>";
			content += "	<td>"+ hm.get("QTY") +"</td>";
			content += "	<td>"+ hm.get("AMOUNT") + "</td>";
			content += "</tr>";
		}//for end
		
		content += "<tr>";
		content += "	<td colspan='3'>총금액</td>";
		content += "	<td><span style='color:red; font-weight:bold;'>" + Utility.comma(Integer.parseInt(totalamount.toString())) + "</span>원</td>";
		content += "</tr>";
		content += "</table>";
		try {
			String mailServer = "mw-002.cafe24.com"; //cafe24 메일 서버
            Properties props = new Properties();
            props.put("mail.smtp.host", mailServer);
            props.put("mail.smtp.auth", true);      
            
            MyAuthenticator myAuth = new MyAuthenticator(); //다형성   
            Session sess = Session.getInstance(props, myAuth);
            
            InternetAddress[] address = { new InternetAddress("hero_1219@naver.com") };
            Message msg = new MimeMessage(sess);
            msg.setRecipients(Message.RecipientType.TO, address);
            msg.setFrom(new InternetAddress("webmaster@itwill.co.kr"));
            msg.setSubject("MyWeb 아이디/비번 입니다");
            msg.setContent(content, "text/html; charset=UTF-8");
            msg.setSentDate(new Date());
            Transport.send(msg);
		} catch (Exception e) {
			System.out.println("주문확인 메일 발송 실패 : "+e);
		}
		
		return content;
	}//order_sendMail() end
}//class end
