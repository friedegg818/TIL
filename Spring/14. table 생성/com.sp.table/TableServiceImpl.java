package com.sp.table;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("service.tableService")
public class TableServiceImpl implements TableService {
	@Autowired
	private CommonDAO dao;

	@Override
	public void createBoardTable(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("table.createBoardTable", map);
			dao.updateData("table.createBoardSeq", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}		
	}

	@Override
	public void dropBoardTable(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("table.dropBoardTable", map);
			dao.updateData("table.dropBoardSeq", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}		
	}

	@Override
	public List<Map<String, String>> listBoardTable() {
		List<Map<String, String>> list = null;
		
		try {
			list = dao.selectList("table.listBoardTable");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
