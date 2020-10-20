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
import com.sp.security.authority.Resources;
import com.sp.security.authority.ResourcesService;
import com.sp.security.authority.Roles;
import com.sp.security.authority.RolesService;
import com.sp.security.intercept.MyFilterInvocationSecurityMetadataSource;

// 리소스 및 리소스 권한 컨트롤러
@Controller("authorityManage.resourcesManageController")
public class ResourcesManageController {
	@Autowired
	private ResourcesService service;
	@Autowired
	private RolesService rolesService;
	@Autowired
	private MyUtil myUtil;
	
	@Autowired
	private MyFilterInvocationSecurityMetadataSource metadataSource;
	
	// -- 리소스 패턴 관리 ----------------------------------
	@RequestMapping(value="/admin/resourcesManage/resources")
	public String resourcesManage(@RequestParam(value="pageNo", defaultValue="1") int current_page,
			Model model) throws Exception {
		
		int rows = 10;
		int total_page = 0;
		int dataCount = 0;
   	    
		Map<String, Object> map = new HashMap<String, Object>();
		
        dataCount = service.dataCountResources1();
        if(dataCount != 0)
            total_page = myUtil.pageCount(rows, dataCount) ;

        if(total_page < current_page) 
            current_page = total_page;

        int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
        
        List<Resources> list = service.listResources1(map);

        int listNum, n = 0;
        for(Resources dto : list) {
        	n++;
        	listNum = (current_page - 1) * rows +  n;
            dto.setListNum(listNum);
        }
        
        String paging = myUtil.pagingMethod(current_page, total_page, "resources");
		
        model.addAttribute("list", list);
        model.addAttribute("pageNo", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
        
		return "admin/menu1/authorityManage/resources";
	}
	
	@RequestMapping(value="/admin/resourcesManage/insertResources", method=RequestMethod.GET)
	public String insertResourcesForm(
			Model model
			) throws Exception {
		
		model.addAttribute("mode", "created");
		
		return "admin/menu1/authorityManage/updateResources";
	}
	
	@RequestMapping(value="/admin/resourcesManage/updateResources", method=RequestMethod.GET)
	public String updateResourcesForm(
			@RequestParam int resource_id,
			Model model
			) throws Exception {
		
		Resources dto=service.readResources(resource_id);
		
		model.addAttribute("mode", "update");
		model.addAttribute("dto", dto);
		
		return "admin/menu1/authorityManage/updateResources";
	}
	
	@RequestMapping(value="/admin/resourcesManage/updateResources", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateResources(
			Resources dto,
			@RequestParam String mode
			) throws Exception {
		String state="true";
		
		if(mode.equals("created")) {
			try {
				service.insertResources(dto);
			} catch (Exception e) {
				state="insertFail";
			}
		} else {
			try {
				service.updateResources(dto);
			} catch (Exception e) {
				state="updateFail";
			}
		}
		
		// 리소스 패턴 변경후 권한 설정 다시 읽어오기
		metadataSource.reloadRequestMap();
		
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value="/admin/resourcesManage/deleteResources", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteResources(
			@RequestParam int resource_id
			) throws Exception {
		
		String state="true";
		try {
			service.deleteResources(resource_id);
		} catch (Exception e) {
			state="false";
		}
		
		// 리소스 패턴 변경후 권한 설정 다시 읽어오기
		metadataSource.reloadRequestMap();
		
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", state);
		return model;
	}
	
	// -- 리소스 패턴 권한 설정 ----------------------------------
	@RequestMapping(value="/admin/resourcesManage/provisioning")
	public String provisioningManage(@RequestParam(value="pageNo", defaultValue="1") int current_page,
			Model model) throws Exception {
		
		int rows = 10;
		int total_page = 0;
		int dataCount = 0;
   	    
		Map<String, Object> map = new HashMap<String, Object>();
		
        dataCount = service.dataCountResourcesRole();
        if(dataCount != 0)
            total_page = myUtil.pageCount(rows, dataCount) ;

        if(total_page < current_page) 
            current_page = total_page;

        int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
        
        List<Resources> list = service.listResourcesRole(map);

        int listNum, n = 0;
        for(Resources dto : list) {
        	n++;
        	listNum = (current_page - 1) * rows +  n;
            dto.setListNum(listNum);
        }
        
        String paging = myUtil.pagingMethod(current_page, total_page, "provisioning");
		
        model.addAttribute("list", list);
        model.addAttribute("pageNo", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);
        model.addAttribute("paging", paging);
        
		return "admin/menu1/authorityManage/provisioning";
	}
	
	@RequestMapping(value="/admin/resourcesManage/insertProvisioning", method=RequestMethod.GET)
	public String insertProvisioningForm(
			Model model
			) throws Exception {
		
		List<Resources> listResources=service.listResources();
		List<Roles> listRoles=rolesService.listRoles();
		
		model.addAttribute("mode", "created");
		model.addAttribute("listResources", listResources);
		model.addAttribute("listRoles", listRoles);
		
		return "admin/menu1/authorityManage/updateProvisioning";
	}
	
	@RequestMapping(value="/admin/resourcesManage/updateProvisioning", method=RequestMethod.GET)
	public String updateProvisioningForm(
			@RequestParam int resource_id,
			@RequestParam String authority,
			Model model
			) throws Exception {
		
		Map<String, Object> map=new HashMap<>();
		map.put("resource_id", resource_id);
		map.put("authority", authority);
		
		Resources dto=service.readResourcesRole(map);
		List<Resources> listResources=service.listResources();
		List<Roles> listRoles=rolesService.listRoles();
		
		model.addAttribute("mode", "update");
		model.addAttribute("dto", dto);
		model.addAttribute("listResources", listResources);
		model.addAttribute("listRoles", listRoles);
		
		return "admin/menu1/authorityManage/updateProvisioning";
	}
	
	@RequestMapping(value="/admin/resourcesManage/updateProvisioning", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateProvisioning(
			Resources dto,
			@RequestParam String mode
			) throws Exception {
		String state="true";
		
		if(mode.equals("created")) {
			try {
				service.insertResourcesRole(dto);
			} catch (Exception e) {
				state="insertFail";
			}
		} else {
			try {
				service.updateResourcesRole(dto);
			} catch (Exception e) {
				state="updateFail";
			}
		}
		
		// 리소스 권한 변경후 권한 설정 다시 읽어오기
		metadataSource.reloadRequestMap();
		
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value="/admin/resourcesManage/deleteProvisioning", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteProvisioning(
			@RequestParam int resource_id,
			@RequestParam String authority
			) throws Exception {
		String state="true";
		
		try {
			Map<String, Object> map=new HashMap<>();
			map.put("resource_id", resource_id);
			map.put("authority", authority);
			service.deleteResourcesRole(map);
		} catch (Exception e) {
			state="false";
		}
		
		// 리소스 권한 변경후 권한 설정 다시 읽어오기
		metadataSource.reloadRequestMap();
		
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", state);
		return model;
	}
}

