package my.wiki;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.oreilly.servlet.MultipartRequest;

public class ArticleDao {
	Connection conn=null;
	PreparedStatement ps=null;
	ResultSet rs=null;
	private ArticleDao() {
		Context initContext;
		try {
			initContext = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/OracleDB");
			conn = ds.getConnection();
		} catch (NamingException e) {
			e.printStackTrace();
		}  catch (SQLException e) {
			e.printStackTrace();}
	}
	private static ArticleDao instance;
	public static ArticleDao getInstance() {
		if(instance==null) {
			instance=new ArticleDao();
		}
		return instance;
	}
	public int insertData(MultipartRequest mr,String img) {
		int cnt=-1;
		String sql="insert into article(no,code,title,writer,contents,version,img) values(artseq.nextval,?,?,?,?,0,?)";
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, mr.getParameter("code"));
			ps.setString(2, mr.getParameter("title"));
			ps.setString(3, mr.getParameter("writer"));
			ps.setString(4, mr.getParameter("contents"));
			if(mr.getFilesystemName("img")!=null) {
			ps.setString(5, mr.getFilesystemName("img"));
			}
			else {
				if(img=="null") {
					img=null;
				}
			ps.setString(5, img);
			}
			cnt=ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null) {
				ps.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;
	}
	public ArrayList<ArticleBean> searchData(String search,String version) {
		String sql="select * from article where title=? and version=?";
		ArrayList<ArticleBean> list=new ArrayList<ArticleBean>();
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, search);
			ps.setString(2, version);
			rs=ps.executeQuery();
			if(rs.next()) {
				int no=rs.getInt("no");
				String code=rs.getString("code");
				String title=rs.getString("title");
				String writer=rs.getString("writer");
				String reg_date=rs.getString("reg_date");
				String contents=rs.getString("contents");
				String img=rs.getString("img");
				
				ArticleBean ab=new ArticleBean();
				ab.setNo(no);
				ab.setCode(code);
				ab.setTitle(title);
				ab.setWriter(writer);
				ab.setReg_date(reg_date);
				ab.setContents(contents);
				ab.setImg(img);
				list.add(ab);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null) {
				ps.close();
				}
				if(rs!=null) {
				rs.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	public ArrayList<ArticleBean> recentChanged() {
		String sql="select * from (select * from article natural join category where version=0 order by no desc) where rownum<=10";
		ArrayList<ArticleBean> list=new ArrayList<ArticleBean>();
		try {
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			while(rs.next()) {
				int no=rs.getInt("no");
				String code=rs.getString("code");
				String title=rs.getString("title");
				String writer=rs.getString("writer");
				String reg_date=rs.getString("reg_date");
				String contents=rs.getString("contents");
				String img=rs.getString("img");
				String cname=rs.getString("cname");
				
				ArticleBean ab=new ArticleBean();
				ab.setNo(no);
				ab.setCode(code);
				ab.setTitle(title);
				ab.setWriter(writer);
				ab.setReg_date(reg_date);
				ab.setContents(contents);
				ab.setImg(img);
				ab.setCname(cname);
				list.add(ab);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null) {
				ps.close();
				}
				if(rs!=null) {
				rs.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	public boolean titleCheck(String title) {
		boolean flag=false;
		String sql="select * from article where title=?";
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, title);
			rs=ps.executeQuery();
			if(rs.next()) {
				flag=true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null) {
				ps.close();
				}
				if(rs!=null) {
				rs.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} return flag;
	}
	public int updateData(MultipartRequest mr,String oldImg) {
		int cnt=-1;
		String sql1="update article set version=version+1 where title=?";
		oldImg=mr.getParameter("oldImg");
		try {
			ps=conn.prepareStatement(sql1);
			ps.setString(1,mr.getParameter("title"));
			cnt=ps.executeUpdate();
			String sql2="insert into article(no,code,title,writer,contents,version,img) values(artseq.nextval,?,?,?,?,0,?)";
			ps=conn.prepareStatement(sql2);
			ps.setString(1, mr.getParameter("code"));
			ps.setString(2, mr.getParameter("title"));
			ps.setString(3, mr.getParameter("writer"));
			ps.setString(4, mr.getParameter("contents"));
			if(mr.getOriginalFileName("newImg")!=null) {
				ps.setString(5, mr.getOriginalFileName("newImg"));}
			else {
				if(mr.getParameter("oldImg").equals("null")) {
					oldImg=null;
				}
			ps.setString(5, oldImg);
			}
			cnt=ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null) {
				ps.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;
	}
	public int deleteArticle(String title) {
		int cnt=-1;
		String sql="delete from article where title=?";
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, title);
			cnt=ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null) {
				ps.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;
	}
	public ArrayList<ArticleBean> getHistory(String search){
		ArrayList<ArticleBean> list=new ArrayList<ArticleBean>();
		String sql="select * from article where title=? order by version";
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, search);
			rs=ps.executeQuery();
			while(rs.next()) {
				int no=rs.getInt("no");
				String code=rs.getString("code");
				String title=rs.getString("title");
				String writer=rs.getString("writer");
				String reg_date=rs.getString("reg_date");
				String contents=rs.getString("contents");
				String img=rs.getString("img");
				int version=rs.getInt("version");
				
				ArticleBean ab=new ArticleBean();
				ab.setNo(no);
				ab.setCode(code);
				ab.setTitle(title);
				ab.setWriter(writer);
				ab.setReg_date(reg_date);
				ab.setContents(contents);
				ab.setImg(img);
				ab.setVersion(version);
				list.add(ab);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null) {
				ps.close();
				}
				if(rs!=null) {
				rs.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	public int countArticle() {
		String sql="select count(*) as cnt from article where version=0";
		int cnt=-1;
		try {
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			if(rs.next()) {
				cnt=rs.getInt("cnt");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(ps!=null) {
				ps.close();
				}
				if(rs!=null) {
				rs.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} return cnt;
	}
	public ArrayList<ArticleBean> selectByCode(String search){
		ArrayList<ArticleBean> list=new ArrayList<ArticleBean>();
		String sql="select * from article where code=? and version=0";
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, search);
			rs=ps.executeQuery();
			while(rs.next()) {
				int no=rs.getInt("no");
				String code=rs.getString("code");
				String title=rs.getString("title");
				String writer=rs.getString("writer");
				String reg_date=rs.getString("reg_date");
				String contents=rs.getString("contents");
				String img=rs.getString("img");
				int version=rs.getInt("version");
				
				ArticleBean ab=new ArticleBean();
				ab.setNo(no);
				ab.setCode(code);
				ab.setTitle(title);
				ab.setWriter(writer);
				ab.setReg_date(reg_date);
				ab.setContents(contents);
				ab.setImg(img);
				ab.setVersion(version);
				list.add(ab);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null) {
				ps.close();
				}
				if(rs!=null) {
				rs.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} return list;
	}
	public ArrayList<ArticleBean> randomData() {
		String sql="select * from (select * from article where version=0 order by DBMS_RANDOM.RANDOM) where rownum = 1";
		ArrayList<ArticleBean> list=new ArrayList<ArticleBean>();
		try {
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			if(rs.next()) {
				int no=rs.getInt("no");
				String code=rs.getString("code");
				String title=rs.getString("title");
				String writer=rs.getString("writer");
				String reg_date=rs.getString("reg_date");
				String contents=rs.getString("contents");
				String img=rs.getString("img");
				
				ArticleBean ab=new ArticleBean();
				ab.setNo(no);
				ab.setCode(code);
				ab.setTitle(title);
				ab.setWriter(writer);
				ab.setReg_date(reg_date);
				ab.setContents(contents);
				ab.setImg(img);
				list.add(ab);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null) {
				ps.close();
				}
				if(rs!=null) {
				rs.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	public ArrayList<ArticleBean> searchWriter(String member) {
		String sql="select * from article where writer like '%"+member+"%'";
		ArrayList<ArticleBean> list=new ArrayList<ArticleBean>();
		try {
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			while(rs.next()) {
				int no=rs.getInt("no");
				String code=rs.getString("code");
				String title=rs.getString("title");
				String writer=rs.getString("writer");
				String reg_date=rs.getString("reg_date");
				String contents=rs.getString("contents");
				String img=rs.getString("img");
				int version=rs.getInt("version");
				
				ArticleBean ab=new ArticleBean();
				ab.setNo(no);
				ab.setCode(code);
				ab.setTitle(title);
				ab.setWriter(writer);
				ab.setReg_date(reg_date);
				ab.setContents(contents);
				ab.setImg(img);
				ab.setVersion(version);
				list.add(ab);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null) {
				ps.close();
				}
				if(rs!=null) {
				rs.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	public ArrayList<String> autoComplete(String search) {
		String sql="select * from article where title like '"+search+"%' and version=0 order by title asc";
		ArrayList<String> list=new ArrayList<String>();
		try {
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			while(rs.next()) {
				String title=rs.getString("title");
				list.add(title);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null) {
				ps.close();
				}
				if(rs!=null) {
				rs.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
}
