package com.web_project.announce;

import com.web_project.db.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class AnnounceDAO {
    private Connection connection;

    public AnnounceDAO() {
        connection = DBConnection.getConnection();
    }

    public List<AnnounceBean> getAllAnnouncements() {
    	PreparedStatement stmt = null;
    	ResultSet rs = null;
        List<AnnounceBean> announcements = new ArrayList<>();
        String sql = "SELECT num, stdnum, usrname, password, title, memo, time, hit FROM announce ORDER BY num DESC";

        try{
        	stmt = connection.prepareStatement(sql);
        	rs = stmt.executeQuery();
            while (rs.next()) {
                AnnounceBean announce = new AnnounceBean();
                announce.setNum(rs.getInt("num"));
                announce.setStdnum(rs.getInt("stdnum"));
                announce.setUsrname(rs.getString("usrname"));
                announce.setPassword(rs.getString("password"));
                announce.setTitle(rs.getString("title"));
                announce.setMemo(rs.getString("memo"));
                announce.setTime(rs.getTimestamp("time"));
                announce.setHit(rs.getInt("hit"));
                announcements.add(announce);
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

        return announcements;
    }

    public AnnounceBean getAnnouncementByNum(int num) {
        PreparedStatement stmt = null;
        AnnounceBean announce = null;
        ResultSet rs = null;
        String sql = "SELECT num, stdnum, usrname, password, title, memo, time, hit FROM announce WHERE num = ?";

        try {
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, num);
            
            rs = stmt.executeQuery();
            if (rs.next()) {
                announce = new AnnounceBean();
                announce.setNum(rs.getInt("num"));
                announce.setStdnum(rs.getInt("stdnum"));
                announce.setUsrname(rs.getString("usrname"));
                announce.setPassword(rs.getString("password"));
                announce.setTitle(rs.getString("title"));
                announce.setMemo(rs.getString("memo"));
                announce.setTime(rs.getTimestamp("time"));
                announce.setHit(rs.getInt("hit"));
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

        return announce;
    }

    public void createAnnouncement(AnnounceBean announce) {
    	PreparedStatement pstmt = null;
        String sql = "INSERT INTO announce (NUM, stdnum, usrname, password, title, memo, time) " +
                "VALUES (?, ?, ?, ?, ?, ?, SYSDATE)";

        try{
        	pstmt = connection.prepareStatement(sql);
            // 새로운 글의 NUM 값을 조회
            String numSql = "SELECT MAX(NUM) FROM announce";
            Statement numStmt = connection.createStatement();
            ResultSet numRs = numStmt.executeQuery(numSql);
            int num = 1;
            if (numRs.next()) {
                num = numRs.getInt(1) + 1;
            }
            numRs.close();
            numStmt.close();

            pstmt.setInt(1, num);
            pstmt.setInt(2, announce.getStdnum());
            pstmt.setString(3, announce.getUsrname());
            pstmt.setString(4, announce.getPassword());
            pstmt.setString(5, announce.getTitle());
            pstmt.setString(6, announce.getMemo());

            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public void updateAnnouncement(AnnounceBean announce) {
    	PreparedStatement stmt = null;
        String sql = "UPDATE announce SET stdnum = ?, usrname = ?, password = ?, title = ?, memo = ?, time = ?, hit = ? " +
                "WHERE num = ?";

        try  {
        	stmt = connection.prepareStatement(sql);
            stmt.setInt(1, announce.getStdnum());
            stmt.setString(2, announce.getUsrname());
            stmt.setString(3, announce.getPassword());
            stmt.setString(4, announce.getTitle());
            stmt.setString(5, announce.getMemo());
            stmt.setTimestamp(6, announce.getTime());
            stmt.setInt(7, announce.getHit());
            stmt.setInt(8, announce.getNum());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public void deleteAnnouncement(int num) {
    	PreparedStatement stmt = null;
        String sql = "DELETE FROM announce WHERE num = ?";

        try{
        	stmt = connection.prepareStatement(sql);
            stmt.setInt(1, num);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public void increaseHitCount(int num) {
    	PreparedStatement stmt = null;
        String sql = "UPDATE announce SET hit = hit + 1 WHERE num = ?";

        try {
        	stmt = connection.prepareStatement(sql);
            stmt.setInt(1, num);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public void updateAnnouncementNumbers(int idx) {
    	PreparedStatement stmt = null;
        String sql = "UPDATE announce SET num = num - 1 WHERE num > ?";

        try{
        	stmt = connection.prepareStatement(sql);
            stmt.setInt(1, idx);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public List<AnnounceBean> getTopThreeAnnouncements() {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<AnnounceBean> announcements = new ArrayList<>();
        String sql = "SELECT num, stdnum, usrname, password, title, memo, time, hit FROM (select * from announce ORDER BY num DESC) where rownum <= 3";

        try {
            stmt = connection.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                AnnounceBean announce = new AnnounceBean();
                announce.setNum(rs.getInt("num"));
                announce.setStdnum(rs.getInt("stdnum"));
                announce.setUsrname(rs.getString("usrname"));
                announce.setPassword(rs.getString("password"));
                announce.setTitle(rs.getString("title"));
                announce.setMemo(rs.getString("memo"));
                announce.setTime(rs.getTimestamp("time"));
                announce.setHit(rs.getInt("hit"));
                announcements.add(announce);
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

        return announcements;
    }

    
}
