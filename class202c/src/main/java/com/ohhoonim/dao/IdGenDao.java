package com.ohhoonim.dao;

import org.springframework.stereotype.Repository;

@Repository("idGenDao")
public class IdGenDao extends Mapper{
	
	public String getNextId(String tableName){
		
		return selectOne("getNextId", tableName);
		
	}
	
	public int updateNextId(String tableName) {
		return update("updateNextId", tableName);
	}
	
	

}
