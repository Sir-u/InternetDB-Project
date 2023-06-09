package com.web_project.member;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MemberDAO {
    private static final String driver = "oracle.jdbc.driver.OracleDriver";
    private static final String url = "jdbc:oracle:thin:@localhost:1521";
    private static final String user = "internetdb";
    private static final String password = "1234";
    
    static Connection connection = null;
    static PreparedStatement insert = null;
    
    //db연결
    static {
    	try {
            Class.forName(driver);
            connection = DriverManager.getConnection(url, user, password);

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch(SQLException e) {
        	e.printStackTrace();
        }
    }
    
    // 비밀번호 해싱 메서드
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();

            for (byte hashByte : hashBytes) {
                sb.append(Integer.toString((hashByte & 0xff) + 0x100, 16).substring(1));
            }

            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    //회원가입 sql
    public void insertMember(MemberBean member) {
    	try {
            String sql_insert = "INSERT INTO member VALUES (?, ?, ?, ?, ?, ?, ?)";
            insert = connection.prepareStatement(sql_insert);
            
            insert.setInt(1, member.getStdnum());
            insert.setString(2, hashPassword(member.getPasswd())); // 비밀번호 해싱하여 저장
            insert.setString(3, member.getUsrname());
            insert.setString(4, member.getGender());
            insert.setString(5, member.getBirthday());
            insert.setInt(6, member.getAge());
            insert.setString(7, member.getReg_date());

            insert.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (insert != null) {
                    insert.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public int authenticateMember(LoginBean login) {
        try {
            String sql_select = "SELECT passwd FROM member WHERE stdnum = ?";
            PreparedStatement select = connection.prepareStatement(sql_select);
            select.setInt(1, login.getStdnum());

            ResultSet resultSet = select.executeQuery();

            if (resultSet.next()) {
                String hashedPassword = resultSet.getString(1);
                String inputPassword = hashPassword(login.getPasswd());

                if (hashedPassword.equals(inputPassword)) {
                    return 1; // 로그인 성공
                } else {
                    return 0; // 비밀번호 불일치
                }
            }

            return -1; // 아이디가 없음
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -2; // DB 오류
    }

    public int deleteMember(LoginBean login) {
        try {
            String sql_delete = "DELETE FROM member WHERE stdnum = ? AND passwd = ?";
            PreparedStatement delete = connection.prepareStatement(sql_delete);
            delete.setInt(1, login.getStdnum());
            delete.setString(2, hashPassword(login.getPasswd()));

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
        }
        return -2;
    }

}
