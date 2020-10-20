package com.sp.table;

import java.util.List;
import java.util.Map;

public interface TableService {
	public void createBoardTable(Map<String, Object> map) throws Exception;  
	public void dropBoardTable(Map<String, Object> map) throws Exception;
	public List<Map<String, String>> listBoardTable();
}
