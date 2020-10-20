package com.sp.security.intercept;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.FactoryBean;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.web.util.matcher.RequestMatcher;

/*
 * - Bean의 초기화 데이터 제공 기능을 구현 클래스
 *   DB 기반의 보호자원 맵핑 정보를 얻어 이를 참조하는 Bean 의 초기화 데이터로 제공 
*/

public class UrlResourcesMapFactoryBean implements FactoryBean<LinkedHashMap<RequestMatcher, List<ConfigAttribute>>> {
	private SecuredObjectService securedObjectService;
    private LinkedHashMap<RequestMatcher, List<ConfigAttribute>> requestMap;
    
	public void setSecuredObjectService(SecuredObjectService securedObjectService) {
        this.securedObjectService = securedObjectService;
    }
	
	public void init() throws Exception {
        requestMap = securedObjectService.getRolesAndUrl();
    }
	
	@Override
	public LinkedHashMap<RequestMatcher, List<ConfigAttribute>> getObject() throws Exception {
		if(requestMap == null){
            requestMap = securedObjectService.getRolesAndUrl();
        }
        return requestMap;
	}

	@Override
	public Class<?> getObjectType() {
		return LinkedHashMap.class;
	}

	@Override
	public boolean isSingleton() {
		return true;
	}

}
