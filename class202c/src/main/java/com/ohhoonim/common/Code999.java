package com.ohhoonim.common;

public class Code999 {
	
	public static String ORDR_CONDITION_AWAITING_CONFIRM = "1101"; 
	public static String ORDR_CONDITION_CANCEL_BYCLIENT = "1201"; 
	public static String ORDR_CONDITION_CANCEL_BYADMIN = "1202"; 
	public static String ORDR_CONDITION_AWAITING_SHIPMENT = "1301"; 
	public static String ORDR_CONDITION_ON_SHIPMENT = "1302"; 
	public static String ORDR_CONDITION_COMPLETED_SHIPMENT = "1303"; 	

	public static String PURCHASE_CONDITION_INCOMING = "2312"; // 입고 중
	public static String PURCHASE_CONDITION_COMPLETE = "2313"; // 입고 완료
	public static String PURCHASE_CONDITION_AWAITING_CONFIRM = "2311"; // 입고 승인 대기중
	public static String PURCHASE_CONDITION_CANCEL = "2211"; // 발주 취소
	
	public static String INCOMING_SAME_VALUE = "2401"; // 입고가 같은 값입니다.
	public static String INCOMING_OVER_VALUE = "2402"; // 입고합이 발주량을 초과합니다!
	public static String INCOMING_DONE_ALRADY = "2403"; // 입고 중
	
	public static String CATEGORY_1ST = "5100"; // 대분류
	public static String CATEGORY_2ND = "5200"; // 중분류
	public static String CATEGORY_3RD = "5300"; // 소분류
	
	public static String STOCK_CONDITION_SAFE = "3003"; // 재고상태

	public static String PRODUCT_INSERT_COMPLETE = "3101"; // PRODUCT 추가 완료
	public static String PRODUCT_INSERT_NO_PTNRID = "3103"; // PTNRID 없음
	public static String PRODUCT_INSERT_PRODUCTID_ERROR = "3102"; // 생성된 PID 에러


}
