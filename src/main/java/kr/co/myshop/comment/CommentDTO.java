package kr.co.myshop.comment;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class CommentDTO {

	private int cno;
	private int product_code;
	private String content;
	private String wname;
	private String regdate;

}
