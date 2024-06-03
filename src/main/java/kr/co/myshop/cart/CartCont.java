package kr.co.myshop.cart;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/cart")
public class CartCont {

    public CartCont() {
        System.out.println("-----CartCont()객체생성됨");
    }//end
    
    @Autowired
    CartDAO cartDao;
    
    @PostMapping("/insert")
    public String cartInsert(@ModelAttribute CartDTO cartDto, HttpSession session) {
        // 로그인 기능을 구현했다면 session.getAttribute() 활용
        String s_id = (String) session.getAttribute("s_id");
        if (s_id == null) {
            s_id = "itwill"; // 여기서는 임시로 "itwill"
        }
        cartDto.setId(s_id);
        
        cartDao.cartInsert(cartDto);
        
        return "redirect:/cart/list?user_id=" + cartDto.getId(); // 장바구니 목록 페이지 호출
        
    }//cartInsert() end
    
    @RequestMapping("/list")
    public ModelAndView list(HttpSession session) {
        String s_id = (String) session.getAttribute("s_id");
        if (s_id == null) {
            s_id = "itwill"; // 테스트용 임시 아이디 "itwill"
        }
        
        ModelAndView mav = new ModelAndView();
        mav.setViewName("cart/list");
        mav.addObject("list", cartDao.cartList2(s_id)); 
        return mav;        
    }//list() end
    
    @GetMapping("/delete")
    public String delete(HttpServletRequest req, HttpSession session) {
        int cartno = Integer.parseInt(req.getParameter("cartno"));
        
        // DTO를 사용한 경우
        // CartDTO cartDto = new CartDTO();
        // cartDto.setCartno(cartno);
        // cartDto.setId(session.getAttribute("s_id"));        
        // cartDao.cartDelete(cartDto);
        
        // Map를 사용한 경우
        HashMap<String, Object> map = new HashMap<>();
        map.put("no", cartno);
        String s_id = (String) session.getAttribute("s_id");
        if (s_id == null) {
            s_id = "itwill"; // 테스트용 임시 아이디 "itwill"
        }
        map.put("s_id", s_id);
        cartDao.cartDelete(map);
        return "redirect:/cart/list";
    }//delete() end
    
}//class end
