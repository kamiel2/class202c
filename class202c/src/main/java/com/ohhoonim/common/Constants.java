package com.ohhoonim.common;

import javax.servlet.http.HttpSession;

public class Constants {
	
	public static String KEY_PTNR_ID = "ptnrId";
	
	public static String getPtnrId(HttpSession session) {
		Object ptnrIdObj = session.getAttribute(KEY_PTNR_ID);
		String ptnrId = ""; 
		if (ptnrIdObj != null) {
			ptnrId = (String)ptnrIdObj;
		}
//		return ptnrId;
		// TODO 테스트용 파트너 아이디. 로그인 기능 완성 후 변경해줘야함.
		return "212355";
	}
}
