package com.web_project.member;

import com.web_project.db.DBConnection;
import com.web_project.db_env.PasswdGenerator;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ManagerMemberDAO {
	private Connection connection = null;
    
    //db연결
    public ManagerMemberDAO() {
    	connection = DBConnection.getConnection();
    }
    
}
