package com.sp.security.authority;

import java.util.List;
import java.util.Map;

public interface RolesHierarchyService {
	public void insertRolesHierarchy(Map<String, Object> map) throws Exception;
	
	public int dataCount();
	public List<Map<String, Object>> listRolesHierarchy(Map<String, Object> map);
	
	public void updateRolesHierarchy(Map<String, Object> map) throws Exception;
	public void deleteRolesHierarchy(Map<String, Object> map) throws Exception;
}
