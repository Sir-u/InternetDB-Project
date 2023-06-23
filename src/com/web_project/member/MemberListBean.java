package com.web_project.member;

public class MemberListBean {
	private int stdnum;
	private String usrname;
	private String gender;
	private String birthday;
	private int age;
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
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	@Override
	public String toString() {
		return "MemberListBean [stdnum=" + stdnum + ", usrname=" + usrname + ", gender=" + gender + ", birthday="
				+ birthday + ", age=" + age + "]";
	}
	
}
