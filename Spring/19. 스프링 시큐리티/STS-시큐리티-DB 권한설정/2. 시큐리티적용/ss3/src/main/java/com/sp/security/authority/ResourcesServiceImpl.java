package com.sp.security.authority;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("authority.resourcesService")
public class ResourcesServiceImpl implements ResourcesService {
	@Autowired
	private CommonDAO  dao;
	
	@Override
	public void insertResources(Resources dto) throws Exception {
		try {
			dao.insertData("resources.insertResources", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Resources> listResources() {
		List<Resources> list=null;
		try {
			list=dao.selectList("resources.listResources");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public int dataCountResources1() {
		int result=0;
		try {
			result=dao.selectOne("resources.dataCountResources1");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Resources> listResources1(Map<String, Object> map) {
		List<Resources> list=null;
		try {
			list=dao.selectList("resources.listResources1", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Resources> listResources3(int resource_id) {
		List<Resources> list=null;
		try {
			list=dao.selectList("resources.listResources3", resource_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Resources readResources(int resource_id) {
		Resources dto=null;
		try {
			dto=dao.selectOne("resources.readResources", resource_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateResources(Resources dto) throws Exception {
		try {
			dao.updateData("resources.updateResources", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteResources(int resource_id) throws Exception {
		try {
			dao.deleteData("resources.deleteResources", resource_id);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertResourcesRole(Resources dto) throws Exception {
		try {
			dao.insertData("resources.insertResourcesRole", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int dataCountResourcesRole() {
		int result=0;
		try {
			result=dao.selectOne("resources.dataCountResourcesRole");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Resources> listResourcesRole(Map<String, Object> map) {
		List<Resources> list=null;
		try {
			list=dao.selectList("resources.listResourcesRole", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override 
	public Resources readResourcesRole(Map<String, Object> map) {
		Resources dto=null;
		try {
			dto=dao.selectOne("resources.readResourcesRole", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	@Override
	public void updateResourcesRole(Resources dto) throws Exception {
		try {
			dao.updateData("resources.updateResourcesRole", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteResourcesRole(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("resources.deleteResourcesRole", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
