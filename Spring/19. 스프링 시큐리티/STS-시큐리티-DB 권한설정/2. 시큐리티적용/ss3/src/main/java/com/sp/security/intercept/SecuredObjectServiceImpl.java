package com.sp.security.intercept;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Set;

import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.security.web.util.matcher.RequestMatcher;

/*
 * - 보호객체 관리를 지원하는 구현 클래스
 *   Spring Security의 초기 데이터를 DB로 부터 조회하여
 *   보호된 자원 접근 권한을 지원, 제어 할 수 있도록 구현한 클래스
 */
public class SecuredObjectServiceImpl implements SecuredObjectService{
	private SecuredObjectDAO securedObjectDao;
	
	public SecuredObjectDAO getSecuredObjectDao() {
		return securedObjectDao;
	}

	public void setSecuredObjectDao(SecuredObjectDAO securedObjectDao) {
		this.securedObjectDao = securedObjectDao;
	}

	// 롤에 대한 URL의 매핑 정보를 얻어온다.
	@Override
	public LinkedHashMap<RequestMatcher, List<ConfigAttribute>> getRolesAndUrl() throws Exception {
		LinkedHashMap<RequestMatcher, List<ConfigAttribute>> ret = new LinkedHashMap<RequestMatcher, List<ConfigAttribute>>();
        LinkedHashMap<Object, List<ConfigAttribute>> data = securedObjectDao.getRolesAndUrl();
        Set<Object> keys = data.keySet();

        for(Object key : keys){
            ret.put((AntPathRequestMatcher)key, data.get(key));
        }

        return ret;
	}

	// 롤에 대한 메소드의 매핑 정보를 얻어온다.
	@Override
	public LinkedHashMap<String, List<ConfigAttribute>> getRolesAndMethod() throws Exception {
		LinkedHashMap<String, List<ConfigAttribute>> ret = new LinkedHashMap<String, List<ConfigAttribute>>();
        LinkedHashMap<Object, List<ConfigAttribute>> data = securedObjectDao.getRolesAndMethod();
        Set<Object> keys = data.keySet();

        for(Object key : keys){
            ret.put((String)key, data.get(key));
        }

        return ret;
	}

	// 롤에 대한 AOP pointcut 메핑 정보를 얻어온다.
	@Override
	public LinkedHashMap<String, List<ConfigAttribute>> getRolesAndPointcut() throws Exception {
		LinkedHashMap<String, List<ConfigAttribute>> ret = new LinkedHashMap<String, List<ConfigAttribute>>();
        LinkedHashMap<Object, List<ConfigAttribute>> data = securedObjectDao.getRolesAndPointcut();
        Set<Object> keys = data.keySet();

        for(Object key : keys){
            ret.put((String)key, data.get(key));
        }

        return ret;
	}

	// 롤의 계층적 구조를 얻어온다.
	@Override
	public String getHierarchicalRoles() throws Exception {
		return securedObjectDao.getHierarchicalRoles();
	}

}
