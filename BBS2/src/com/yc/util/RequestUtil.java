package com.yc.util;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public class RequestUtil<T>{
	
	public static <T> T getParameter(Map<String,Object>request,Class<T> c) throws Exception{
		//����c������һ����������������ڴ�request�е����е�ֵ
   	 T obj=c.newInstance();       //User obj=new User()
   	//ȡ��c�����е�set����
   	 List<Method> setMethods=getAllSetMethods(c);
   	 //��setMethods�е�ÿ��������setȥ������������ĸתΪСд���浽һ��������     setUname()->uname
   	 List<String> params=getAllParameters(setMethods);
   	 for(String p:params){
   		 if(request.get(p.toUpperCase())==null){
   			 continue;
   		 }
   		 String value=request.get(p.toUpperCase()).toString();
   		 if(value!=null){
   			 for(Method m:setMethods){
   				 //�ж�����һ��set����Ҫ��������
   				if( m.getName().equalsIgnoreCase("set"+p)){
					//TODO�������ж�m���setXXX(��������)
					//�жϲ���������
					Class typeClass=m.getParameterTypes()[0]; //��Ϊset�����Ǳ�׼��javabean���������Ĳ�������ֻ��һ��
					String typeClassName=typeClass.getName();
					if("int".equals(typeClassName) || "java.lang.Integer".equals(typeClassName)){
						int v=Integer.parseInt(value);
						m.invoke(obj, v);
					}else if("float".equals(typeClassName) || "java.lang.Float".equals(typeClassName)){
						float v=Float.parseFloat(value);
						m.invoke(obj, v);
					}else if("double".equals(typeClassName) || "java.lang.Double".equals(typeClassName)){
						double v=Double.parseDouble(value);
						m.invoke(obj, v);
					}else{
					m.invoke(obj, value);
					}
				}
   			 }
   		 }
   	 }
   	 return obj;
	}
	/**
	 * ��request��ȡ�����еĲ�����������ֵ�浽һ��Object����
	 * @param request
	 * @param c
	 * @return
	 * @throws IllegalAccessException 
	 * @throws InstantiationException 
	 * @throws InvocationTargetException 
	 * @throws IllegalArgumentException 
	 */
     public static <T> T getParameter(HttpServletRequest request,Class<T> c) throws Exception{
    	 //����c������һ����������������ڴ�request�е����е�ֵ
    	 T obj=c.newInstance();       //User obj=new User()
    	//ȡ��c�����е�set����
    	 List<Method> setMethods=getAllSetMethods(c);
    	 //��setMethods�е�ÿ��������setȥ������������ĸתΪСд���浽һ��������     setUname()->uname
    	 List<String> params=getAllParameters(setMethods);
    	 
    	 //��request��ȡ�����еĲ���
    	 for(String p:params){
    		 String value=request.getParameter(p);
    		 if(value!=null){
    			 for(Method m:setMethods){
    				 //�ж�����һ��set����Ҫ��������
    				if( m.getName().equalsIgnoreCase("set"+p)){
    					//TODO�������ж�m���setXXX(��������)
    					//�жϲ���������
    					Class typeClass=m.getParameterTypes()[0]; //��Ϊset�����Ǳ�׼��javabean���������Ĳ�������ֻ��һ��
    					String typeClassName=typeClass.getName();
    					if("int".equals(typeClassName) || "java.lang.Integer".equals(typeClassName)){
    						int v=Integer.parseInt(value);
    						m.invoke(obj, v);
    					}else if("float".equals(typeClassName) || "java.lang.Float".equals(typeClassName)){
    						float v=Float.parseFloat(value);
    						m.invoke(obj, v);
    					}else if("double".equals(typeClassName) || "java.lang.Double".equals(typeClassName)){
    						double v=Double.parseDouble(value);
    						m.invoke(obj, v);
    					}else{
    					m.invoke(obj, value);
    					}
    				}
    				 
    			 }
    		 }
    	 }
		return obj;
    	 
     }
     
     private static List<String> getAllParameters(List<Method> setMethods) {
    	 List<String> list=new ArrayList<String>();
		for(Method m:setMethods){
			String pname=m.getName().substring(3, m.getName().length());
			pname=pname.substring(0, 1).toLowerCase()+pname.substring(1);
			list.add(pname);
		}
		return list;
	}

	/**
      * ȡ��һ�������е�set����
      * @param c
      * @return
      */
     
     private static <T> List<Method> getAllSetMethods(Class<T> c){
    	 List<Method> setMethods=new ArrayList<Method>();
    	 if(c!=null){
    		 Method[] ms=c.getMethods();  //ȡ��user�������з���������ֻҪset
    		 if(ms!=null){
    			 for(Method m:ms){
    				 if(m.getName().startsWith("set")){ //�����������set��ͷ���򱣴浽setMethods��
    					 setMethods.add(m);
    				 }
    			 }
    		 }
    	 }
    	
		return setMethods;
    	 
     }     
     
     
     /**
      * ȡ��һ�������е�get����
      * @param c
      * @return
      */
     
     private static <T> List<Method> getAllGetMethods(Class<T> c){
    	 List<Method> getMethods=new ArrayList<Method>();
    	 if(c!=null){
    		 Method[] ms=c.getMethods();  //ȡ��user�������з���������ֻҪset
    		 if(ms!=null){
    			 for(Method m:ms){
    				 if(m.getName().startsWith("get")){ //�����������set��ͷ���򱣴浽setMethods��
    					 getMethods.add(m);
    				 }
    			 }
    		 }
    	 }
    	
		return getMethods;
    	 
     }     
}
