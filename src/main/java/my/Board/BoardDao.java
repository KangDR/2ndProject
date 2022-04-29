package my.Board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class BoardDao {
	Connection conn=null;
	PreparedStatement ps=null;
	ResultSet rs=null;
	private BoardDao() {
		Context initContext;
		try {
			initContext = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/OracleDB");
			conn = ds.getConnection();
		} catch (NamingException e) {
			e.printStackTrace();
		}  catch (SQLException e) {
			e.printStackTrace();
		}
	}
	private static BoardDao instance;
	public static BoardDao getInstance() {
		if(instance==null) {
			instance=new BoardDao();
		}
		return instance;
	}
	public int getArticleCount() {
		int count=0;
		String cnt=null;
		String sql="select count(*) as cnt from board";
		try {
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			if(rs.next()) {
				cnt=rs.getString("cnt");
				count=Integer.parseInt(cnt);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) {
				rs.close();}
				if(ps!=null) {
				ps.close();}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return count;
	}
	public ArrayList<BoardBean> getArticles(int start,int end){
		String sql = "select num, writer, email, subject, passwd, reg_date, readcount, ref, re_step, re_level, content, ip " ;		        
		sql += "from (select rownum as rank, num, writer, email, subject, passwd, reg_date, readcount, ref, re_step, re_level, content, ip ";
		sql += "from (select num, writer, email, subject, passwd, reg_date, readcount, ref, re_step, re_level, content, ip ";
		sql += "from board  ";
		sql += "order by ref desc, re_step asc )) ";
		sql += "where rank between ? and ? ";
		ArrayList<BoardBean> list=new ArrayList<BoardBean>();
		try {
			ps=conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, end);
			rs=ps.executeQuery();
			
			while(rs.next()) {
				BoardBean bean=new BoardBean();
				int num=rs.getInt("num");
				String writer=rs.getString("writer");
				String email=rs.getString("email");
				String subject=rs.getString("subject");
				String passwd=rs.getString("passwd");
				Timestamp reg_date=rs.getTimestamp("reg_date");
				int readcount=rs.getInt("readcount");
				int ref=rs.getInt("ref");
				int re_step=rs.getInt("re_step");
				int re_level=rs.getInt("re_level");
				String content=rs.getString("content");
				String ip=rs.getString("ip");
				bean.setNum(num);
				bean.setWriter(writer);
				bean.setEmail(email);
				bean.setSubject(subject);
				bean.setPasswd(passwd);
				bean.setReg_date(reg_date);
				bean.setReadcount(readcount);
				bean.setRef(ref);
				bean.setRe_step(re_step);
				bean.setRe_level(re_level);
				bean.setContent(content);
				bean.setIp(ip);
				list.add(bean);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) {
				rs.close();}
				if(ps!=null) {
				ps.close();}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	public BoardBean getArticle(int number) {
		BoardBean bean=new BoardBean();
		String sqlupdate="update board set readcount=readcount+1 where num=?";
		
		String sql="select * from board where num=?";
		try {
			ps=conn.prepareStatement(sqlupdate);
			ps.setInt(1,number);
			ps.executeUpdate();
			ps=conn.prepareStatement(sql);
			ps.setInt(1,number);
			rs=ps.executeQuery();
			if(rs.next()) {
				int num=rs.getInt("num");
				String writer=rs.getString("writer");
				String email=rs.getString("email");
				String subject=rs.getString("subject");
				String passwd=rs.getString("passwd");
				Timestamp reg_date=rs.getTimestamp("reg_date");
				int readcount=rs.getInt("readcount");
				int ref=rs.getInt("ref");
				int re_step=rs.getInt("re_step");
				int re_level=rs.getInt("re_level");
				String content=rs.getString("content");
				String ip=rs.getString("ip");
				bean.setNum(num);
				bean.setWriter(writer);
				bean.setEmail(email);
				bean.setSubject(subject);
				bean.setPasswd(passwd);
				bean.setReg_date(reg_date);
				bean.setReadcount(readcount);
				bean.setRef(ref);
				bean.setRe_step(re_step);
				bean.setRe_level(re_level);
				bean.setContent(content);
				bean.setIp(ip);
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
		return bean;
	}public int insertArticle(BoardBean bean) {
		int cnt=-1;
		String sql="insert into board(num,writer,email,subject,passwd,reg_date,readcount,ref,re_step,re_level,content,ip) values(board_seq.nextval,?,?,?,?,?,?,board_seq.currval,?,?,?,?)";
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, bean.getWriter());
			ps.setString(2, bean.getEmail());
			ps.setString(3, bean.getSubject());
			ps.setString(4, bean.getPasswd());
			ps.setTimestamp(5, bean.getReg_date());
			ps.setInt(6,bean.getReadcount());
			ps.setInt(7, 0);
			ps.setInt(8, 0);
			ps.setString(9, bean.getContent());
			ps.setString(10, bean.getIp());
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
	public int replyArticle(BoardBean bb){ // 답글 쓰기
		// 이름,제목,email,내용,비번,ref,re_step,re_level 8가지
		
		String sql2 = "update board set re_step=re_step+1 where ref=? and re_step>?";
		String sql = "insert into board(num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip)"
				+ " values(board_seq.nextval,?,?,?,?,?,?,?,?,?,?)";
		
		int cnt = -1;
		
		try {
			ps = conn.prepareStatement(sql2);
			ps.setInt(1,bb.getRef());
			ps.setInt(2,bb.getRe_step());
			ps.executeUpdate();
			
			ps = conn.prepareStatement(sql);
			ps.setString(1,bb.getWriter());
			ps.setString(2,bb.getEmail());
			ps.setString(3,bb.getSubject());
			ps.setString(4,bb.getPasswd());
			ps.setTimestamp(5,bb.getReg_date());
			ps.setInt(6,bb.getRef());
			ps.setInt(7,bb.getRe_step()+1);
			ps.setInt(8,bb.getRe_level()+1);
			ps.setString(9,bb.getContent());
			ps.setString(10,bb.getIp());
			cnt = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(ps != null)
					ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return cnt;
		
	}//replyArticle
	
	public BoardBean oneSelect(int number) {
		BoardBean bean=new BoardBean();
		String sql="select * from board where num=?";
		try {
			ps=conn.prepareStatement(sql);
			ps.setInt(1,number);
			rs=ps.executeQuery();
			if(rs.next()) {
				int num=rs.getInt("num");
				String writer=rs.getString("writer");
				String email=rs.getString("email");
				String subject=rs.getString("subject");
				String passwd=rs.getString("passwd");
				Timestamp reg_date=rs.getTimestamp("reg_date");
				int readcount=rs.getInt("readcount");
				int ref=rs.getInt("ref");
				int re_step=rs.getInt("re_step");
				int re_level=rs.getInt("re_level");
				String content=rs.getString("content");
				String ip=rs.getString("ip");
				bean.setNum(num);
				bean.setWriter(writer);
				bean.setEmail(email);
				bean.setSubject(subject);
				bean.setPasswd(passwd);
				bean.setReg_date(reg_date);
				bean.setReadcount(readcount);
				bean.setRef(ref);
				bean.setRe_step(re_step);
				bean.setRe_level(re_level);
				bean.setContent(content);
				bean.setIp(ip);
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
		return bean;
	}
	public int deleteArticle(int num,String passwd) {
		int cnt=-1;
		String sql="select passwd from board where num=?";
		try {
			ps=conn.prepareStatement(sql);
			ps.setInt(1, num);
			rs=ps.executeQuery();
			if(rs.next()) {
				String dbpw=rs.getString("passwd");
				if(passwd.equals(dbpw)){
					String sql2="delete from board where num=?";
					ps=conn.prepareStatement(sql2);
					ps.setInt(1, num);
					cnt=ps.executeUpdate();
				}
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
		return cnt;
	}
	public int updateArticle(BoardBean bb){
		
		int cnt=-1;
		String sql2="select passwd from board where num=?";
		String sql="update board set subject=?,writer=?,email=?,content=? where num=?";
		try {
			ps=conn.prepareStatement(sql2);
			ps.setInt(1, bb.getNum());
			rs=ps.executeQuery();
			if(rs.next()) {
				String dbpw=rs.getString("passwd");
				if(dbpw.equals(bb.getPasswd())) {
					ps=conn.prepareStatement(sql);
					ps.setString(1, bb.getSubject());
					ps.setString(2, bb.getWriter());
					ps.setString(3, bb.getEmail());
					ps.setString(4, bb.getContent());
					ps.setInt(5, bb.getNum());
					cnt=ps.executeUpdate();
				}
				else {
					
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(ps!=null) {
				try {
					ps.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return cnt;
	}
}

