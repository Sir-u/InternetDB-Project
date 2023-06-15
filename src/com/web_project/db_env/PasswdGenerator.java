package com.web_project.db_env;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class PasswdGenerator {
	public static String hashPassword(String password) {
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

}
