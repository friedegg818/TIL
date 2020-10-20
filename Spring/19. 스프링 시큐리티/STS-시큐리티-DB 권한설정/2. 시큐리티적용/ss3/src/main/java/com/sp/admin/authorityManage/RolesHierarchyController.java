package com.sp.admin.authorityManage;

import java.util.HashMap;
import java.util.Iterator;
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
import com.sp.security.authority.RolesHierarchyService;
import com.sp.security.authority.RolesService;
import com.sp.security.intercept.MyFilterInvocationSecurityMetadataSource;

// 권한 계층구조 컨트롤러
@Controller("authorityManage.rolesHierarchyController")
public class RolesHierarchyController {
	@Autowired
	private RolesHierarchyService service;
	@Autowired
	private RolesService rolesService;	
	@Autowired
	private MyUtil myUtil;
	
	@Autowired
	private MyFilterInvocationSecurityMetadataSource metadataSource;
	
	@RequestMapping(value="/admin/rolesManage/rolesHierarchy")
	public String rolesHierarchy(@RequestParam(value="pageNo", defaultValue="1") int current_page,
			Model model) throws Exception {
		
		int rows = 10;
		int total_page = 0;
		int dataCount = 0;
   	    
		Map<String, Object> map = new HashMap<String, Object>();
		
        dataCount = service.dataCount();
        if(dataCount != 0)
            total_page = myUtil.pageCount(rows, dataCount) ;

        if(total_page < current_page) 
            current_page = total_page;

        int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
        
        List<Map<String, Object>> list = service.listRolesHierarchy(map);

        int listNum, n = 0;
        Iterator<Map<String, Object>> it=list.iterator();
        while(it.hasNext()) {
        	Map<String, Object> data = it.next();
        	n++;
        	listNum = (current_page - 1) * rows + n;
            data.put("listNum", listNum);
        }
        
        String paging = myUtil.pagingMethod(current_page, total_page, "rolesHierarchy");
		
        model.addAttribute("list", list);
        model.addAttribute("pageNo", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
        
		return "admin/menu1/authorityManage/rolesHierarchy";
	}
	
	@RequestMapping(value="/admin/rolesManage/insertRolesHierarchy", method=RequestMethod.GET)
	public String insertRolesHierarchyForm(
			Model model
			) throws Exception {
		
		List<Roles> listRoles=rolesService.listRoles();
		
		model.addAttribute("mode", "created");
		model.addAttribute("listRoles", listRoles);
		
		return "admin/menu1/authorityManage/updateRolesHierarchy";
	}
	
	@RequestMapping(value="/admin/rolesManage/updateRolesHierarchy", method=RequestMethod.GET)
	public String updateRolesHierarchyForm(
			@RequestParam String parent_role,
			@RequestParam String child_role,
			Model model
			) throws Exception {
		
		List<Roles> listRoles=rolesService.listRoles();
		
		model.addAttribute("mode", "update");
		model.addAttribute("parent_role", parent_role);
		model.addAttribute("child_role", child_role);
		model.addAttribute("listRoles", listRoles);
		
		return "admin/menu1/authorityManage/updateRolesHierarchy";
	}
	
	@RequestMapping(value="/admin/rolesManage/updateRolesHierarchy", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateRolesHierarchy(
			@RequestParam String parent_role,
			@RequestParam String child_role,
			@RequestParam(value="parent_OldRole", defaultValue="") String parent_OldRole,
			@RequestParam(value="child_OldRole", defaultValue="") String child_OldRole,
			@RequestParam String mode
			) throws Exception {
		String state="true";
		
		Map<String, Object> map=new HashMap<>();
		map.put("parent_role", parent_role);
		map.put("child_role", child_role);
		map.put("parent_OldRole", parent_OldRole);
		map.put("child_OldRole", child_OldRole);
		
		if(mode.equals("created")) {
			try {
				service.insertRolesHierarchy(map);
			} catch (Exception e) {
				state="insertFail";
			}
		} else {
			try {
				service.updateRolesHierarchy(map);
			} catch (Exception e) {
				state="updateFail";
			}
		}
		
		// 권한계층구조 변경후 권한 설정 다시 읽어오기
		metadataSource.reloadRequestMap();
		
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value="/admin/rolesManage/deleteRolesHierarchy", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteRolesHierarchy(
			@RequestParam String parent_role,
			@RequestParam String child_role
			) throws Exception {
		
		String state="true";
		try {
			Map<String, Object> map=new HashMap<>();
			map.put("parent_role", parent_role);
			map.put("child_role", child_role);
			service.deleteRolesHierarchy(map);
		} catch (Exception e) {
			state="false";
		}
		
		// 권한계층구조 변경후 권한 설정 다시 읽어오기
		metadataSource.reloadRequestMap();
		
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", state);
		return model;
	}
}

