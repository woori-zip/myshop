package kr.co.myshop.comment;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/comment")
public class CommentCont {
	
	public CommentCont() {
		System.out.println("----CommentCont() 객체 생성됨");
	}//end
	
	@Autowired
	private CommentDAO commentDao;
	
	@PostMapping("/insert")
	@ResponseBody
	public int pCommentServiceInsert(@RequestParam("product_code") int product_code
			,@RequestParam("content") String content
			, HttpSession session) throws Exception {
		CommentDTO commentDto = new CommentDTO();
		commentDto.setProduct_code(product_code);
		commentDto.setContent(content);
		commentDto.setWname("test");
		
		int cnt = commentDao.commentInsert(commentDto);
		
		return cnt;
	}//pCommentServiceInsert() end

	
	@GetMapping("/list")
	@ResponseBody
	public List<CommentDTO> pCommentServiceList(@RequestParam("product_code") int product_code) throws Exception {
		List<CommentDTO> list=commentDao.commentList(product_code);
		return list;
	}//pCommentServiceList() end
	
	@PostMapping("/delete")
	@ResponseBody
	public int pCommentServiceDelete(@RequestParam("cno") int cno) throws Exception {
		return commentDao.commentDelete(cno);
	}//pCommentServiceDelete() end
	
	@PostMapping("/updateproc")
	@ResponseBody
	public int pCommentServiceUpdateProc(@RequestParam("cno") int cno, @RequestParam("content") String content) {
		CommentDTO commentDto = new CommentDTO();
		commentDto.setCno(cno);
		commentDto.setContent(content);
		
		int cnt = commentDao.commentUpdateProc(commentDto);
		
		return cnt;
	}//pCommentServiceUpdate() end
	
}//class end
