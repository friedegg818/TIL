package com.sp.security.authority;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("authority.rolesHierarchyService")
public class RolesHierarchyServiceImpl implements RolesHierarchyService {
	@Autowired
	private CommonDAO  dao;
	
	@Override
	public void insertRolesHierarchy(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("rolesHierarchy.insertRolesHierarchy", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int dataCount() {
		int result=0;
		try {
			result=dao.selectOne("rolesHierarchy.dataCount");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Map<String, Object>> listRolesHierarchy(Map<String, Object> map) {
		List<Map<String, Object>> list=null;
		try {
			list=dao.selectList("rolesHierarchy.listRolesHierarchy", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void updateRolesHierarchy(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("rolesHierarchy.updateRolesHierarchy", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteRolesHierarchy(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("rolesHierarchy.deleteRolesHierarchy", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
