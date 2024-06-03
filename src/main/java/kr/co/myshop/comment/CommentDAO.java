package kr.co.myshop.comment;

import java.math.BigDecimal;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;

@Repository
public class CommentDAO {

	public CommentDAO() {
		System.out.println("----CommentDAO() 객체생성됨");
	}//end
	
	@Autowired
	SqlSession sqlSession;
	
	public int commentInsert(CommentDTO commentDto) {
		return sqlSession.insert("pcomment.insert", commentDto);
	}//commentInsert() end

	public List<CommentDTO> commentList(int product_code) {
		return sqlSession.selectList("pcomment.list", product_code);
	}//commentList() end
	
	public int commentDelete(int cno) throws Exception {
		return sqlSession.delete("pcomment.delete",cno);
	}//commentDelete() end
	
	// 댓글 수를 가져오는 메서드 추가
    public int getCommentCount(int product_code) {
    	BigDecimal count = sqlSession.selectOne("pcomment.count", product_code);
        return count.intValue();
    }//getCommentCount() end

	public int commentUpdateProc(CommentDTO commentDto) {
		return sqlSession.update("pcomment.updateproc", commentDto);
	}//commentUpdateProc() end
    

}//class end
