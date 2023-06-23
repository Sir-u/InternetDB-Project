package com.web_project.member;

import com.web_project.announce.AnnounceBean;
import com.web_project.db.DBConnection;
import com.web_project.db_env.PasswdGenerator;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ManagerMemberDAO {
	private Connection connection = null;
    
    //db연결
    public ManagerMemberDAO() {
    	connection = DBConnection.getConnection();
    }
    
    public List<MemberListBean> getAllMembers() {
        List<MemberListBean> members = new ArrayList<>();
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            String sql = "SELECT stdnum, usrname, gender, birthday, age FROM member";
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                MemberListBean member = new MemberListBean();
                member.setStdnum(resultSet.getInt("stdnum"));
                member.setUsrname(resultSet.getString("usrname"));
                member.setGender(resultSet.getString("gender"));
                member.setBirthday(resultSet.getString("birthday"));
                member.setAge(resultSet.getInt("age"));
                members.add(member);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (statement != null) {
                    statement.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return members;
    }
    
    public List<AnnounceBean> getBoardsByStdnum(int stdnum) {
    	PreparedStatement stmt = null;
    	ResultSet rs = null;
        List<AnnounceBean> boards = new ArrayList<>();
        String sql = "SELECT * FROM board WHERE stdnum = ?";

        try{
        	stmt = connection.prepareStatement(sql);
        	stmt.setInt(1, stdnum);
        	rs = stmt.executeQuery();
            while (rs.next()) {
                AnnounceBean board = new AnnounceBean();
                board.setNum(rs.getInt("num"));
                board.setStdnum(rs.getInt("stdnum"));
                board.setPassword(rs.getString("password"));
                board.setUsrname(rs.getString("usrname"));
                board.setTitle(rs.getString("title"));
                board.setMemo(rs.getString("memo"));
                board.setTime(rs.getTimestamp("time"));
                board.setHit(rs.getInt("hit"));
                boards.add(board);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return boards;
    }
    
    public List<AnnounceBean> getTopThreeBoards() {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<AnnounceBean> boards = new ArrayList<>();
        String sql = "SELECT num, stdnum, usrname, password, title, memo, time, hit FROM (select * from board ORDER BY num DESC) where rownum <= 3";

        try {
            stmt = connection.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                AnnounceBean board = new AnnounceBean();
                board.setNum(rs.getInt("num"));
                board.setStdnum(rs.getInt("stdnum"));
                board.setUsrname(rs.getString("usrname"));
                board.setPassword(rs.getString("password"));
                board.setTitle(rs.getString("title"));
                board.setMemo(rs.getString("memo"));
                board.setTime(rs.getTimestamp("time"));
                board.setHit(rs.getInt("hit"));
                boards.add(board);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return boards;
    }
    
}
