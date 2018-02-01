package com.ohhoonim.common.util;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import org.apache.log4j.Logger;
public class Utils {
	private static final Logger LOGGER = Logger.getLogger(Utils.class);
	
	// 빈 값을 받을 때 null 을 "" 로 변환
	public static String toEmptyBlank(String nullStr){
		return nullStr == null ? "" : nullStr.trim();	
	}
	public static Object toEmptyBlank(Object nullStr){
		return nullStr == null ? "" : nullStr.toString().trim();	
	}
	
	//공백 제거 with null chk
	public static String toEmptyBlankNoSpace(String nullStr){
		return nullStr == null ? "" : nullStr.replaceAll("(^\\p{Z}+|\\p{Z}+$)", "");
	}
	//Object toString().trim() 달아놨다. 문제생길경우 지워야함
	
	public static String customToEmptyBlank(String nullStr, String modifiedStr){
		return nullStr == null ? modifiedStr : nullStr;	
	}
	
	public static String webBlankToCustomize(String inputStr, String modifedStr){
		return inputStr == "" ? modifedStr : inputStr;
	}
	
	
	// html환경에서 null일때 스페이스로
	public static String nullSpace(String nullSpa) {
	      return nullSpa == null ? "&nbsp;" : nullSpa;
	   }
	
	// date 형식으로 변환 후 원하는 포맷으로 변경
	public static String dateFommatter(Object dateStr){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.KOREA);
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String modifyDate ="";
		String setDateStr = dateStr != null ? dateStr.toString(): null;
		
		try {
			if (setDateStr == null || setDateStr == ""){
				setDateStr = date.toString();
			}
			
			LOGGER.debug("=======================================================");
			LOGGER.debug("입력받은 날짜 : " + setDateStr);
			LOGGER.debug("=======================================================");
			
			date = sdf.parse(setDateStr);
			LOGGER.debug("=======================================================");
			LOGGER.debug("변환된 날짜 : " + date);
			LOGGER.debug("=======================================================");
			modifyDate= sdf2.format(date);
			
			LOGGER.debug("=======================================================");
			LOGGER.debug("수정된 날짜 : " + modifyDate);
			LOGGER.debug("=======================================================");
			
			
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return modifyDate;
	}
	
	//String date 를 받아서 10자리만 커트
	public static String customDate(String dateStr){
		String customDate = dateStr.substring(0, 10);
		return customDate;
	}
	
	//숫자를 원하는 포맷으로 변경
	public static String customNum(String strNum, String format){
		long strLong = Long.parseLong(strNum);
		BigDecimal intNum = BigDecimal.valueOf(strLong);
		DecimalFormat df = new DecimalFormat(format);
		String customNum = df.format(intNum);
		
		return customNum;
	}
	
	//숫자를 원하는 포맷으로 변경
		public static Object customNum(Object strNum, String format){
				int intNum = Integer.parseInt(strNum.toString());
				DecimalFormat df = new DecimalFormat(format);
				String customNum = df.format(intNum);
				
				return customNum;
			}
			
	
	// 입력받은 문자열이 숫자 형식인지 체크
	public static boolean chkInputOnlyNumber(String input){
		char chrInput = 0;
		boolean result = false;
		
		if (input == ""){
			result = true;
		}else{
			int inputLen = input.length();
			for (int i = 0; i < inputLen; i++ ){
				chrInput = input.charAt(i);
				if(chrInput >= 0x30 && chrInput <= 0x39){
					result = true;
				}else if (chrInput == 32){
					result = true;
				}else if (chrInput == 46){
					result = true;
				}else{
					result = false;
					break;
				}
				
			}
		}
		
		
		
		return result;
	}
	
	// 입력받은 문자열이 영문인지 체크
	public static boolean chkInputOnlyAlphabet(String input){
		char chrInput = 0;
		boolean result = false;
		
		int inputLen = input.length();
		for (int i = 0; i < inputLen; i++ ){
			chrInput = input.charAt(i);
			if(chrInput >= 0x61 && chrInput <= 0x7A){
				result = true;
			}else if(chrInput >= 0x41 && chrInput <= 0x5A){
				result = true;
			}else if(chrInput == 32){
				result = true;
			}
			else{
				result = false;
				break;
			}
		}
		
		return result;
	}
	
	// 입력받은 문자열이 영문소문자인지 체크
	public static boolean chkInputOnlyLowerAlphabet(String input){
		char chrInput = 0;
		boolean result = false;
		
		int inputLen = input.length();
		for (int i = 0; i < inputLen; i++ ){
			chrInput = input.charAt(i);
			if(chrInput >= 0x61 && chrInput <= 0x7A || chrInput == 32){
				result = true;
			}else{
				result = false;
				break;
			}
		}
		
		return result;
	}
	
	// 입력받은 문자열이 영문대문자인지 체크
	public static boolean chkInputOnlyUpperAlphabet(String input){
		char chrInput = 0;
		boolean result = false;
		
		int inputLen = input.length();
		for (int i = 0; i < inputLen; i++ ){
			chrInput = input.charAt(i);
			if(chrInput >= 0x41 && chrInput <= 0x5A || chrInput == 32){
				result = true;
			}else {
				result = false;
				break;
			}
		}
		
		return result;
	}
	
	
	// 입력받은 문자열이 한글인지 체크
	public static boolean chkInputOnlyKorean(String input){
		char chrInput = 0;
		boolean result = false;
		
		int inputLen = input.length();
		for (int i = 0; i < inputLen; i++ ){
			chrInput = input.charAt(i);
			if(chrInput >= 44032 && chrInput <= 55203 || chrInput == 32){
				result = true;
			}else{
				result = false;
				break;
			}
			
		}
		
		return result;
	}
	
	
}