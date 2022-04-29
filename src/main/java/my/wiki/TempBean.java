package my.wiki;

import java.util.ArrayList;

public class TempBean {
	private ArrayList<ArticleBean> tlist;
	public TempBean() {
		tlist=new ArrayList<ArticleBean>();
	}
	public void addTemp(String title,String code,String writer,String contents,String timestamp,String img,String type) {
		ArticleBean ab=new ArticleBean(title,code,writer,contents,timestamp,img,type);
		for(int i=0;i<tlist.size();i++) {
		if(tlist.get(i).getTitle().equals(title)) {
			tlist.get(i).setCode(code);
			tlist.get(i).setWriter(writer);
			tlist.get(i).setContents(contents);
			tlist.get(i).setReg_date(timestamp);
			tlist.get(i).setImg(img);
			return;
			}
		}
		tlist.add(ab);
	}
	public ArrayList<ArticleBean> getAllTemp(){
		return tlist;
	}
	public void removeAllproduct() {
		tlist.removeAll(tlist);
	}
}
