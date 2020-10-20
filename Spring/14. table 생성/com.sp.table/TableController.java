package com.sp.table;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller("table.tableController")
public class TableController {
	@Autowired
	TableService service;
	
	@RequestMapping(value="/table/main")
	public String main(Model model) throws Exception {
		List<Map<String, String>> list = service.listBoardTable();
		
		model.addAttribute("list", list);
		
		return "table/main";
	}
	
	@RequestMapping(value="/table/add", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> createTable(
			@RequestParam String tableName 
			) throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();
		
		String state = "true";
		
		try {
			tableName = "sp_" + tableName;
			Map<String, Object> map = new HashMap<>();
			map.put("tableName", tableName);
			service.createBoardTable(map);
		} catch (Exception e) {
			state = "false";
		}
		
		model.put("state", state);
		
		return model;
	}
	
	@RequestMapping(value="/table/drop", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> dropTable(
			@RequestParam Map<String, Object> map
			) throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();
		
		String state = "true";
		
		try {
			service.dropBoardTable(map);
		} catch (Exception e) {
			state = "false";
		}
		
		model.put("state", state);
		
		return model;
	}
}
