package com.yc.bean;

import java.io.Serializable;

public class Reply implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
    private Integer rn;
    private Integer replyid;
    private String title;
    private String content;
    private String publishtime;
    private String modifytime;
    private Integer id;
    private String uname;
    private String head;
    private String regtime;
    private Integer topicid;
	public Integer getRn() {
		return rn;
	}
	public void setRn(Integer rn) {
		this.rn = rn;
	}
	public Integer getReplyid() {
		return replyid;
	}
	public void setReplyid(Integer replyid) {
		this.replyid = replyid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPublishtime() {
		return publishtime;
	}
	public void setPublishtime(String publishtime) {
		this.publishtime = publishtime;
	}
	public String getModifytime() {
		return modifytime;
	}
	public void setModifytime(String modifytime) {
		this.modifytime = modifytime;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getHead() {
		return head;
	}
	public void setHead(String head) {
		this.head = head;
	}
	public String getRegtime() {
		return regtime;
	}
	public void setRegtime(String regtime) {
		this.regtime = regtime;
	}
	public Integer getTopicid() {
		return topicid;
	}
	public void setTopicid(Integer topicid) {
		this.topicid = topicid;
	}
	@Override
	public String toString() {
		return "Reply [rn=" + rn + ", replyid=" + replyid + ", title=" + title + ", content=" + content
				+ ", publishtime=" + publishtime + ", modifytime=" + modifytime + ", id=" + id + ", uname=" + uname
				+ ", head=" + head + ", regtime=" + regtime + ", topicid=" + topicid + "]";
	}
	
    
}
