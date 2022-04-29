package my.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class MembersDao {
	Connection conn=null;
	PreparedStatement ps=null;
	ResultSet rs=null;
	private MembersDao() {
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
	private static MembersDao instance;
	public static MembersDao getInstance() {
		if(instance==null) {
			instance=new MembersDao();
		}
		return instance;
	}
	public boolean idCheck(String id) {
		boolean flag=false;
		String sql="select * from members where id=?";
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1,id);
			rs=ps.executeQuery();
			if(rs.next()) {
				flag=true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null)
				rs.close();
				if(ps!=null)
				ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}	
		}
		return flag;
	}
	public int insertMember(MemberBean mb) {
		int cnt=-1;
		String sql="insert into members values(memseq.nextval,?,?,?,?,?,?,?)";
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, mb.getId());
			ps.setString(2, mb.getPassword());
			ps.setString(3, mb.getName());
			ps.setString(4, mb.getEmail());
			ps.setString(5, mb.getPhone1());
			ps.setString(6, mb.getPhone2());
			ps.setString(7, mb.getPhone3());
			cnt=ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null)
				ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}	
		}
		return cnt;
	}
	public MemberBean getMemberInfo(String id,String pw) {
		String sql="select * from members where id=? and password=?";
		MemberBean mb=null;
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, pw);
			rs=ps.executeQuery();
			if(rs.next()) {
				int no=rs.getInt("no");
				String mid=rs.getString("id");
				String password=rs.getString("password");
				String name=rs.getString("name");
				String email=rs.getString("email");
				String phone1=rs.getString("phone1");
				String phone2=rs.getString("phone2");
				String phone3=rs.getString("phone3");
				
				mb=new MemberBean();
				mb.setNo(no);
				mb.setId(mid);
				mb.setPassword(password);
				mb.setName(name);
				mb.setEmail(email);
				mb.setPhone1(phone1);
				mb.setPhone2(phone2);
				mb.setPhone3(phone3);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null)
				rs.close();
				if(ps!=null)
				ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}	
		}
		return mb;
	}
	public String findId(String name,String email) {
		String sql="select * from members where name=? and email=?";
		String id=null;
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, name);
			ps.setString(2, email);
			rs=ps.executeQuery();
			if(rs.next()) {
				id=rs.getString("id");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null)
				rs.close();
				if(ps!=null)
				ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}	
		}
		return id;
	}
	public String findPw(String id,String name,String email) {
		String sql="select * from members where id=? and name=? and email=?";
		String pw=null;
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, name);
			ps.setString(3, email);
			rs=ps.executeQuery();
			if(rs.next()) {
				pw=rs.getString("password");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null)
				rs.close();
				if(ps!=null)
				ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}	
		}
		return pw;
	}
	public MemberBean searchId(String id) {
		String sql="select * from members where id=?";
		MemberBean mb=null;
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);
			rs=ps.executeQuery();
			if(rs.next()) {
				int no=rs.getInt("no");
				String mid=rs.getString("id");
				String password=rs.getString("password");
				String name=rs.getString("name");
				String email=rs.getString("email");
				String phone1=rs.getString("phone1");
				String phone2=rs.getString("phone2");
				String phone3=rs.getString("phone3");
				
				mb=new MemberBean();
				mb.setNo(no);
				mb.setId(mid);
				mb.setPassword(password);
				mb.setName(name);
				mb.setEmail(email);
				mb.setPhone1(phone1);
				mb.setPhone2(phone2);
				mb.setPhone3(phone3);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null)
				rs.close();
				if(ps!=null)
				ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}	
		}
		return mb;
	}
}
