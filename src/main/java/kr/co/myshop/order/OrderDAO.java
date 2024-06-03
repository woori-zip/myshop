package kr.co.myshop.order;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class OrderDAO {
	public OrderDAO() {
		System.out.println("----OrderDAO() 객체 생성됨");
	}

	@Autowired
	SqlSession sqlSession;
	
	public int totalamount(String s_id) {
		return sqlSession.selectOne("order.totalamount",s_id);
	}//totalamount() end
	
	public String orderno(String cdate) {
		return sqlSession.selectOne("order.orderno",cdate);
	}//orderno() end

	public int orderlistInsert(OrderDTO orderdto) {
		return sqlSession.insert("order.orderlistInsert",orderdto);
	}//orderlistInsert() end

	public int orderdetailInsert(HashMap<String, String> map) {
		return sqlSession.insert("order.orderdetailInsert",map);
	}//orderdetailInsert() end

	public int cartDelete(String s_id) {
		return sqlSession.delete("order.cartDelete", s_id);
	}//cartDelete() end
	
	public List<HashMap<String, Object>> orderDesc(String orderno){
		List<HashMap<String, Object>> result = sqlSession.selectList("order.orderDesc", orderno);
		
		//데이터를 불러오는지 확인
		if (result == null || result.isEmpty()) {
	        System.out.println("orderDesc result is empty or null");
	    } else {
	        for (HashMap<String, Object> map : result) {
	            System.out.println("orderDesc result: " + map.toString());
	        }
	    }
		
	    return result;
	}//list() end
}//class end
