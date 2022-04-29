package my.Shop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class CategoryDao {
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		private CategoryDao() {
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
	
	private static CategoryDao instance;
	public static CategoryDao getInstance() {
		if(instance==null) {
			instance=new CategoryDao();
		}
		return instance;
	}
	public int insertCategory(String code,String name) {
		int cnt=-1;
		String sql="insert into category values(catseq.nextval,?,?)";
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1,code);
			ps.setString(2,name);
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
	public ArrayList<CategoryBean> getAllCategory(){
		ArrayList<CategoryBean> list=new ArrayList<CategoryBean>();
		String sql="select * from category order by cnum";
		try {
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			while(rs.next()) {
				int cnum=rs.getInt("cnum");
				String code=rs.getString("code");
				String cname=rs.getString("cname");
				
				CategoryBean cb=new CategoryBean();
				cb.setCnum(cnum);
				cb.setCode(code);
				cb.setCname(cname);
				
				list.add(cb);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) {
				rs.close();
				}
				if(ps!=null) {
				ps.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	public int updateData(CategoryBean cb) {
		int cnt=-1;
		String sql="update category set cname=?,code=? where cnum=?";
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1,cb.getCname());
			ps.setString(2,cb.getCode());
			ps.setInt(3, cb.getCnum());
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
	public int deleteData(String cnum) {
		int cnt=-1;
		String sql="delete from category where cnum=?";
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1,cnum);
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
	public int countCategory() {
		String sql="select count(*) as cnt from category";
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
}
