package com.web_project.member;

import com.web_project.db.DBConnection;
import com.web_project.db_env.PasswdGenerator;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MemberDAO {
    private Connection connection = null;
    
    //db연결
    public MemberDAO() {
    	connection = DBConnection.getConnection();
    }
    
    
    //회원가입 sql
    public void insertMember(MemberBean member) {
    	PreparedStatement insert = null;
    	try {
            String sql_insert = "INSERT INTO member VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            insert = connection.prepareStatement(sql_insert);
            
            insert.setInt(1, member.getStdnum());
            insert.setString(2, PasswdGenerator.hashPassword(member.getPasswd())); // 비밀번호 해싱하여 저장
            insert.setString(3, member.getUsrname());
            insert.setString(4, member.getGender());
            insert.setString(5, member.getBirthday());
            insert.setInt(6, member.getAge());
            insert.setString(7, member.getReg_date());
            insert.setInt(8, member.getAuthority_level());

            insert.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (insert != null) {
                    insert.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public int authenticateMember(LoginBean login) {
    	PreparedStatement select = null;
    	ResultSet resultSet = null;
        try {
            String sql_select = "SELECT passwd FROM member WHERE stdnum = ?";
            select = connection.prepareStatement(sql_select);
            select.setInt(1, login.getStdnum());

            resultSet = select.executeQuery();

            if (resultSet.next()) {
                String hashedPassword = resultSet.getString(1);
                String inputPassword = PasswdGenerator.hashPassword(login.getPasswd());

                if (hashedPassword.equals(inputPassword)) {
                    return 1; // 로그인 성공
                } else {
                    return 0; // 비밀번호 불일치
                }
            }

            return -1; // 아이디가 없음
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            try {
            	if(resultSet != null) {
            		resultSet.close();
            	}
                if (select != null) {
                    select.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return -2; // DB 오류
    }

    public int deleteMember(LoginBean login) {
    	PreparedStatement delete = null;
        try {
            String sql_delete = "DELETE FROM member WHERE stdnum = ? AND passwd = ?";
            delete = connection.prepareStatement(sql_delete);
            delete.setInt(1, login.getStdnum());
            delete.setString(2, PasswdGenerator.hashPassword(login.getPasswd()));

            int rowsAffected = delete.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("회원 삭제 성공");
                return 1;
            } else {
                System.out.println("회원 삭제 실패: 아이디와 비밀번호가 일치하지 않음");
                return 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
        	try {
                if (delete != null) {
                    delete.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return -2;
    }
    
    public MemberBean getMemberByStdnum(int stdnum) {
        PreparedStatement select = null;
        ResultSet resultSet = null;
        MemberBean member = null;

        try {
            String sql_select = "SELECT * FROM member WHERE stdnum = ?";
            select = connection.prepareStatement(sql_select);
            select.setInt(1, stdnum);

            resultSet = select.executeQuery();

            if (resultSet.next()) {
                member = new MemberBean();
                member.setStdnum(resultSet.getInt("stdnum"));
                member.setPasswd(resultSet.getString("passwd"));
                member.setUsrname(resultSet.getString("usrname"));
                member.setGender(resultSet.getString("gender"));
                member.setBirthday(resultSet.getString("birthday"));
                member.setAge(resultSet.getInt("age"));
                member.setReg_date(resultSet.getString("reg_date"));
                member.setAuthority_level(resultSet.getInt("authority_level"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (select != null) {
                    select.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return member;
    }
    
    public boolean updateMember(MemberBean member, int stdnum) {
        PreparedStatement update = null;
        try {
            String sql_update = "UPDATE member SET stdnum=?, passwd=?, usrname=?, gender=?, birthday=?, age=?, reg_date=? WHERE stdnum=?";
            update = connection.prepareStatement(sql_update);
            
            System.out.println(member.getStdnum());
            update.setInt(1, member.getStdnum());
            update.setString(2, PasswdGenerator.hashPassword(member.getPasswd())); // 비밀번호 해싱하여 저장
            update.setString(3, member.getUsrname());
            update.setString(4, member.getGender());
            update.setString(5, member.getBirthday());
            update.setInt(6, member.getAge());
            update.setString(7, member.getReg_date());
            System.out.println(stdnum);
            update.setInt(8, stdnum);

            int rowsAffected = update.executeUpdate();

            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (update != null) {
                    update.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return false;
    }



}
