package com.yc.bean;
//数据bean
import java.io.Serializable;

public class Board implements Serializable{
     private Integer boardid;
     private String boardname;
     private Integer parentid;
     private Integer total;
     
     //这个板块对应的是最近的帖子
     private Topic topic;

	public Integer getBoardid() {
		return boardid;
	}

	public void setBoardid(Integer boardid) {
		this.boardid = boardid;
	}

	public String getBoardname() {
		return boardname;
	}

	public void setBoardname(String boardname) {
		this.boardname = boardname;
	}

	public Integer getParentid() {
		return parentid;
	}

	public void setParentid(Integer parentid) {
		this.parentid = parentid;
	}

	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	public Topic getTopic() {
		return topic;
	}

	public void setTopic(Topic topic) {
		this.topic = topic;
	}

	public Board(Integer boardid, String boardname, Integer parentid, Integer total, Topic topic) {
		super();
		this.boardid = boardid;
		this.boardname = boardname;
		this.parentid = parentid;
		this.total = total;
		this.topic = topic;
	}

	public Board() {
		super();
	}

	@Override
	public String toString() {
		return "Board [boardid=" + boardid + ", boardname=" + boardname + ", parentid=" + parentid + ", total=" + total
				+ ", topic=" + topic + "]\n";
	}
     
     
}
