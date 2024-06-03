package kr.co.myshop.product;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import kr.co.myshop.comment.CommentDAO;
import net.utility.Utility;

@Controller
@RequestMapping("/product")
public class ProductCont {
	
	public ProductCont() {
		System.out.println("----ProductCont() 객체 생성됨");
	}//ProductCont() end
	
	@Autowired
	private ProductDAO productDao;
	
	//for getCommentCount
	@Autowired
	private CommentDAO commentDao;
	
	//결과확인
	//-> http://localhost:9095/product/list
	
	@RequestMapping("/list")
	public ModelAndView list() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("product/list");
		 
		//댓글 개수 출력
		 List<Map<String, Object>> productList = productDao.list();
	        for (Map<String, Object> product : productList) {
	            int product_code = Integer.parseInt(String.valueOf(product.get("PRODUCT_CODE")));
	            int commentCount = commentDao.getCommentCount(product_code);
	            product.put("COMMENT_COUNT", commentCount);
	        }
		
	     // comment count가 포함된 productList를 JSP로 전달
        mav.addObject("list", productList);
        return mav;
	}//list() end
	
	@GetMapping("/write")
	public String wirte() {
		return "product/write";
	}//write() end
	
	//public String insert(String product_name, int price, String description, MultipartFile img) {}
	//public Stirng insert(@ModelAttribute ProductDTO productDto) {}
	//@RequestParam MultipartFile img 에러 대처 -> @RequestParam("img") MultipartFile img
	@PostMapping("/insert")
	public String insert(
			@RequestParam Map<String, Object> map
			, @RequestParam("img") MultipartFile img
			, HttpServletRequest req) {
		//매개변수가 Map이면 name이 key로 저장된다
		//예) <input type="text" name="product_name">
		//System.out.println(map);//{product_name=의자, price=38500, description=의자임당}
		//System.out.println(map.get("product_name"));
		//System.out.println(map.get("price"));
		//System.out.println(map.get("description"));
		
		//업로드 파일은 /storage 폴더에 저장
		ServletContext application = req.getServletContext();
		String basePath = application.getRealPath("/storage");
		
		String filename = "-";
		long filesize = 0;
		
		if(img.getSize()>0 && img!=null && !img.isEmpty()) {//파일이 존재한다면
			filesize = img.getSize();
			
			//전송된 파일이 /storage에 존재한다면 rename
			//->spring05_mymelon 프로젝트 참조
			try {
	            String o_poster = img.getOriginalFilename();
	            filename  = o_poster;
	            
	            File file = new File(basePath, o_poster); //파일클래스에 해당파일 담기
	            int i = 1;
	            while(file.exists()) { //파일이 존재한다면
	               int lastDot = o_poster.lastIndexOf(".");
	               filename = o_poster.substring(0, lastDot) + "_" + i + o_poster.substring(lastDot); //sky_1.png
	               file = new File(basePath, filename);
	               i++;
	            }//while end
	            
	            img.transferTo(file); //파일 저장
	            
	         }catch (Exception e) {
	            System.out.println(e);
	         }//try end
		}//if end
		
		map.put("filename", filename);
		map.put("filesize", filesize);
		//System.out.println(map);
		
		productDao.insert(map);
			
		return "redirect:/product/list";
	}//insert() end
	
	@GetMapping("/search")
	public ModelAndView search(@RequestParam(defaultValue = "") String product_name) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("product/list");
		
		//검색 시에도 댓글 개수 출력 유지
		List<Map<String, Object>> productList = productDao.search(product_name);
	    for (Map<String, Object> product : productList) {
	        int product_code = Integer.parseInt(String.valueOf(product.get("PRODUCT_CODE")));
	        int commentCount = commentDao.getCommentCount(product_code);
	        product.put("COMMENT_COUNT", commentCount);
	    }
		
	    mav.addObject("list", productList);  // 수정된 productList 사용
		mav.addObject("product_name", product_name); //검색어
		return mav;
	}//search() end
	
	//http://localhost:9095/product/detail?product_code=21
	//@GetMapping("/detail")
	//public ModelAndView detail(int product_code) {}
	//public ModelAndView detail(@RequestParam("product_code") int product_code) {}
	//public ModelAndView detail(HttpServletRequest req) {int product_code = Integer.parseInt(req.getParameter("product_cod"));
	
	/*
		@RequestParam
		http://localhost:9095/detail?aaa=bbb&ccc=ddd
		-> detail(String aaa, String ccc)
		
		@PathVariable
		http://localhost:9095/datail?bbb/ddd
		-> @GetMapping("/detail/{aaa}/{ccc}")
		
		● 전송방식 get | post | put | delete
		
		● RESTful web service
		  @GetMapping
		  @PostMapping
		  @PutMapping
		  @DeleteMapping
	*/
	
	//2) 요청값(Query Stirng) 전달기호로 / 사용할 경우
	//http://localhost:9095/product/detail/21
	@GetMapping("/detail/{product_code}")
	public ModelAndView detail(@PathVariable int product_code) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("product/detail");
		mav.addObject("product",productDao.detail(product_code));
		return mav;
	}//detail() end
	
	@PostMapping("/update")
	public String update(@RequestParam Map<String, Object> map
						, @RequestParam("img") MultipartFile img
						, HttpServletRequest req) {
		//기존 정보
		int product_code=Integer.parseInt(map.get("product_code").toString());
		Map<String, Object> oldProduct = productDao.detail(product_code);
		
		String filename = "-";
		long filesize = 0;
		
		
		if(img.getSize()>0 && img!=null && !img.isEmpty()) {//파일이 존재한다면
				ServletContext application = req.getServletContext();
				String basePath = application.getRealPath("/storage");
				try {
					filesize = img.getSize();
		            String o_poster = img.getOriginalFilename();
		            filename  = o_poster;
		            File file = new File(basePath, o_poster); //파일클래스에 해당파일 담기
		            
		            int i = 1;
		            while(file.exists()) { //파일이 존재한다면
		               int lastDot = o_poster.lastIndexOf(".");
		               filename = o_poster.substring(0, lastDot) + "_" + i + o_poster.substring(lastDot); 
		               file = new File(basePath, filename);
		               i++;
		            }//while end
		            
		            img.transferTo(file); //파일 저장
		            Utility.deleteFile(basePath, oldProduct.get("FILENAME").toString());//기존 파일 삭제
		         }catch (Exception e) {
		            System.out.println(e);
		         }//try end
		} else {
			//첨부된 파일이 없다면
			filename=oldProduct.get("FILENAME").toString();
			filesize=Long.parseLong(oldProduct.get("FILESIZE").toString());
		}//if end
		
		map.put("filename",filename);
		map.put("filesize",filesize);
		productDao.update(map);
		
		return "redirect:/product/list";
	}// insert() end
	
	@PostMapping("/delete")
	public String delete(HttpServletRequest req) {
		int product_code = Integer.parseInt(req.getParameter("product_code"));
		
		//삭제하고자하는 파일명 가져오기
		String filename = productDao.filename(product_code);
		
		//첨부된 파일 삭제하기
		if(filename != null && !filename.equals("-")) {
			ServletContext application = req.getSession().getServletContext();
			String path = application.getRealPath("/storage"); //실제 물리적 경로
			File file = new File(path + "\\" + filename);
			if(file.exists()) {
				file.delete();
			}//if end
		}//if end
		productDao.delete(product_code); //테이블 행삭제 
		return "redirect:/product/list";
	}//delete() end
}// class end
