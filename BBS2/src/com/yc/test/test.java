package com.yc.test;

import java.util.List;

import com.yc.bean.User;
import com.yc.dao.DBHelper;

public class test {
      public static void main(String[] args) throws Exception {
		String sql="select * from tbl_user";
		DBHelper db=new DBHelper<>();
		List<User> list=db.findObject(sql, null, User.class);
		for(User u:list){
			System.out.println(u);
		}
	}
}
