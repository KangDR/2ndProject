package my.wiki;

public class ArticleBean {
	private int no;
	private String code;
	private String title;
	private String writer;
	private String reg_date;
	private String contents;
	private int version ;
	private String img;
	private String cname;
	private String type;
	
	public ArticleBean() {
		
	}
	public ArticleBean(String title,String code,String writer,String contents,String timestamp,String img,String type) {
		this.title=title;
		this.code=code;
		this.writer=writer;
		this.img=img;
		this.contents=contents;
		this.reg_date=timestamp;
		this.type=type;
	}
	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public int getVersion() {
		return version;
	}
	public void setVersion(int version) {
		this.version = version;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
}
