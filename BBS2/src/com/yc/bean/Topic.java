package com.yc.bean;

import java.io.Serializable;

public class Topic implements Serializable{
	private int rn;
    private Integer topicid;
    private String title;
    private String content;
    private String publishtime;
    private String modifytime;
    private int id;
    private String uname;
    private int boardid;
    private int num;
    
    
    
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Integer getTopicid() {
		return topicid;
	}
	public void setTopicid(Integer topicid) {
		this.topicid = topicid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getModifytime() {
		return modifytime;
	}
	public void setModifytime(String modifytime) {
		this.modifytime = modifytime;
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public Topic(Integer topicid, String title, String modifytime, String uname) {
		super();
		this.topicid = topicid;
		this.title = title;
		this.modifytime = modifytime;
		this.uname = uname;
	}
	public Topic() {
		super();
	}
	
	
	public int getRn() {
		return rn;
	}
	public void setRn(int rn) {
		this.rn = rn;
	}
	public String getPublishtime() {
		return publishtime;
	}
	public void setPublishtime(String publishtime) {
		this.publishtime = publishtime;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getBoardid() {
		return boardid;
	}
	public void setBoardid(int boardid) {
		this.boardid = boardid;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	@Override
	public String toString() {
		return "Topic [rn=" + rn + ", topicid=" + topicid + ", title=" + title + ", content=" + content
				+ ", publishtime=" + publishtime + ", modifytime=" + modifytime + ", id=" + id + ", uname=" + uname
				+ ", boardid=" + boardid + ", num=" + num + "]";
	}
	
	
	
    
    
    
}
