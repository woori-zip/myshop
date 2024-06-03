package kr.co.myshop.cart;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CartDAO {

    public CartDAO() {
        System.out.println("-----CartDAO()객체생성됨");
    }//end
    
    @Autowired
    SqlSession sqlSession;
    
    
    public int cartInsert(CartDTO cartDto){        
        return sqlSession.insert("cart.insert", cartDto);
    }//insert() end
    
    
    public List<CartDTO> cartList(String id){
        return sqlSession.selectList("cart.list", id);
    }//list() end
    
    
    public int cartDelete(HashMap<String, Object> map){
        return sqlSession.delete("cart.delete", map);
    }//delete() end
    
    
    public List<HashMap<String, Object>> cartList2(String id){
        return sqlSession.selectList("cart.list2", id);
    }//list() end
    
    
}//class end
