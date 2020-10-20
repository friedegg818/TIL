package com.sp.admin.authorityManage;

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

import com.sp.common.MyUtil;
import com.sp.security.authority.Roles;
import com.sp.security.authority.RolesService;

// 권한(롤) 컨트롤러
@Controller("authorityManage.rolesManageController")
public class RolesManageController {
	@Autowired
	private RolesService rolesService;
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/admin/rolesManage/roles")
	public String rolesManage(@RequestParam(value="pageNo", defaultValue="1") int current_page,
			Model model) throws Exception {
		
		int rows = 10;
		int total_page = 0;
		int dataCount = 0;
   	    
		Map<String, Object> map = new HashMap<String, Object>();
		
        dataCount = rolesService.dataCount();
        if(dataCount != 0)
            total_page = myUtil.pageCount(rows, dataCount) ;

        if(total_page < current_page) 
            current_page = total_page;

        int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
        
        List<Roles> list = rolesService.listRoles(map);

        int listNum, n = 0;
        for(Roles dto : list) {
        	n++;
        	listNum = (current_page - 1) * rows +  n;
            dto.setListNum(listNum);
        }
        
        String paging = myUtil.pagingMethod(current_page, total_page, "roles");
		
        model.addAttribute("list", list);
        model.addAttribute("pageNo", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
        
		return "admin/menu1/authorityManage/roles";
	}
	
	@RequestMapping(value="/admin/rolesManage/insertRoles", method=RequestMethod.GET)
	public String insertRolesForm(
			Model model
			) throws Exception {
		
		model.addAttribute("mode", "created");
		
		return "admin/menu1/authorityManage/updateRoles";
	}
	
	@RequestMapping(value="/admin/rolesManage/updateRoles", method=RequestMethod.GET)
	public String updateRolesForm(
			@RequestParam String authority,
			Model model
			) throws Exception {
		
		Roles dto=rolesService.readRoles(authority);
		
		model.addAttribute("mode", "update");
		model.addAttribute("dto", dto);
		
		return "admin/menu1/authorityManage/updateRoles";
	}
	
	@RequestMapping(value="/admin/rolesManage/updateRoles", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateRoles(
			Roles dto,
			@RequestParam String mode
			) throws Exception {
		
		String state="true";
		if(mode.equals("created")) {
			try {
				rolesService.insertRoles(dto);
			} catch (Exception e) {
				state="insertFail";
			}
		} else {
			try {
				rolesService.updateRoles(dto);
			} catch (Exception e) {
				state="updateFail";
			}
		}
		
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value="/admin/rolesManage/deleteRoles", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteRoles(
			@RequestParam String authority
			) throws Exception {
		
		String state="true";
		try {
			rolesService.deleteRoles(authority);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", state);
		return model;
	}
}

