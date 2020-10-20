package com.sp.security.authority;

import java.util.List;
import java.util.Map;

public interface ResourcesService {
	public void insertResources(Resources dto) throws Exception;
	
	public List<Resources> listResources();
	public int dataCountResources1();
	public List<Resources> listResources1(Map<String, Object> map);
	public List<Resources> listResources3(int resource_id);
	
	public Resources readResources(int resource_id);
	
	public void updateResources(Resources dto) throws Exception;
	public void deleteResources(int resource_id) throws Exception;
	
	public void insertResourcesRole(Resources dto) throws Exception;
	
	public int dataCountResourcesRole();
	public List<Resources> listResourcesRole(Map<String, Object> map);
	
	public Resources readResourcesRole(Map<String, Object> map);
	
	public void updateResourcesRole(Resources dto) throws Exception;
	public void deleteResourcesRole(Map<String, Object> map) throws Exception;
}
