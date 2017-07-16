package com.yc.biz;

import java.util.ArrayList;
import java.util.List;

import com.yc.bean.User;
import com.yc.dao.DBHelper;
import com.yc.util.Encrypt;

public class UserBiz {
   private DBHelper db=new DBHelper();
   
   public boolean findUserByUname(String uname) throws Exception{
	   String sql=" select * from tbl_user where uname=?";
	   List<Object> params=new ArrayList<>();
	   params.add(uname);
	   List<User> list=db.findObject(sql, params, User.class);
	   if(list!=null  && list.size()>0){
		   return true;
	   }else{
		   return false;
	   }
   }
   
   public User findUserById(int id) throws Exception{
	   String sql="select * from tbl_user where id=?";
	   List<Object> params=new ArrayList<Object>();
	   params.add(id);
	   
	   List<User> list=db.findObject(sql, params, User.class);
	   if(list!=null && list.size()>0){
		   return list.get(0);
	   }else{
		   return null;
	   }

	   
   }
   public User login(User user) throws Exception{
	   String sql="select * from tbl_user where uname=? and upass=?";
	   user.setUpass(Encrypt.md5AndSha(user.getUpass()));
	   List<Object> params=new ArrayList<Object>();
	   params.add(user.getUname());
	   params.add(user.getUpass());
	   
	   List<User> list=db.findObject(sql, params, User.class);
	   System.out.println(list);
	   if(list!=null&& list.size()>0){
		   return list.get(0);
	   }else{
		   return null;
	   }
   }
   
   public void reg(User user) throws Exception{
	   if(user.getUpass().equals(user.getUpass1())){
	   user.setUpass(Encrypt.md5AndSha(user.getUpass()));
	   String sqls="insert into tbl_user (id, uname,upass,head,regtime,gender) values (seq_tbl_user.nextval,?,?,?,sysdate,?)";
	   List<Object> params=new ArrayList<Object>();
	   params.add(user.getUname());
	   params.add(user.getUpass());
	   params.add(user.getHead());
	   params.add(user.getGender());
	  db.doUpdate(sqls, params); 
	   }else{
		   throw new Exception("两次输入的密码不一致");
	   }
   }
}
