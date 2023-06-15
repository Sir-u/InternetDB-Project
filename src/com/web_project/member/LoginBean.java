package com.web_project.member;

public class LoginBean {
	private int stdnum;
	private String passwd;
	
	public int getStdnum() {
		return stdnum;
	}
	public void setStdnum(int stdnum) {
		this.stdnum = stdnum;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	@Override
	public String toString() {
		return "LoginBean [stdnum=" + stdnum + ", passwd=" + passwd + "]";
	}
	
	
}
