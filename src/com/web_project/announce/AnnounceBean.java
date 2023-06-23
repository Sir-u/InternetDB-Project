package com.web_project.announce;

import java.sql.Timestamp;

public class AnnounceBean {
	private int num;
	private int stdnum;
	private String usrname;
	private String password;
	private String title;
	private String memo;
	private Timestamp time;
	private int hit;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getStdnum() {
		return stdnum;
	}
	public void setStdnum(int stdnum) {
		this.stdnum = stdnum;
	}
	public String getUsrname() {
		return usrname;
	}
	public void setUsrname(String usrname) {
		this.usrname = usrname;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public Timestamp getTime() {
		return time;
	}
	public void setTime(Timestamp time) {
		this.time = time;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	@Override
	public String toString() {
		return "AnnounceBean [num=" + num + ", stdnum=" + stdnum + ", usrname=" + usrname + ", password=" + password
				+ ", title=" + title + ", memo=" + memo + ", time=" + time + ", hit=" + hit + "]";
	}
	
	
}
