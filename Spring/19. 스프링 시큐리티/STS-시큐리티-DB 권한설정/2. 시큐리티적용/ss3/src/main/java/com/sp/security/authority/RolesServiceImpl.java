package com.sp.security.authority;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("authority.rolesService")
public class RolesServiceImpl implements RolesService {
	@Autowired
	private CommonDAO  dao;
	
	@Override
	public void insertRoles(Roles dto) throws Exception {
		try {
			dao.insertData("roles.insertRoles", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int dataCount() {
		int result=0;
		try {
			result=dao.selectOne("roles.dataCount");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Roles> listRoles(Map<String, Object> map) {
		List<Roles> list=null;
		try {
			list=dao.selectList("roles.listRoles1", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Roles> listRoles() {
		List<Roles> list=null;
		try {
			list=dao.selectList("roles.listRoles2");
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public Roles readRoles(String authority) {
		Roles dto = null;
		try {
			dto=dao.selectOne("roles.readRoles", authority);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateRoles(Roles dto) throws Exception {
		try {
			dao.updateData("roles.updateRoles", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteRoles(String authority) throws Exception {
		try {
			dao.deleteData("roles.deleteRoles", authority);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
