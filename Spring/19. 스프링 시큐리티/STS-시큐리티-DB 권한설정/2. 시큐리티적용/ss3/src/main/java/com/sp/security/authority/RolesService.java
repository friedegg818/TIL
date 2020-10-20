package com.sp.security.authority;

import java.util.List;
import java.util.Map;

public interface RolesService {
	public void insertRoles(Roles dto) throws Exception;
	
	public int dataCount();
	public List<Roles> listRoles(Map<String, Object> map);
	public List<Roles> listRoles();
	
	public Roles readRoles(String authority);
	
	public void updateRoles(Roles dto) throws Exception;
	public void deleteRoles(String authority) throws Exception;
}
