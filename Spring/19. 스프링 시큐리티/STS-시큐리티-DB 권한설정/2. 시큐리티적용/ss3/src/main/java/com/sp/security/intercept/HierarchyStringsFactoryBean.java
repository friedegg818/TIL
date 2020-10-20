package com.sp.security.intercept;

import org.springframework.beans.factory.FactoryBean;

/*
   - DB기반의 롤 계층정보를 지원하는 비즈니스 구현 클래스
      DB 기반의 Role 계층 관계 정보를 얻어 이를 참조하는 Bean 의 초기화 데이터로 제공
*/

public class HierarchyStringsFactoryBean implements FactoryBean<String> {
	private SecuredObjectService securedObjectService;
	private String hierarchyStrings;
	
	public void setSecuredObjectService(SecuredObjectService securedObjectService) {
        this.securedObjectService = securedObjectService;
    }
	
	public void init() throws Exception {
		hierarchyStrings = securedObjectService.getHierarchicalRoles();
    }
	
	@Override
	public String getObject() throws Exception {
		if (hierarchyStrings == null) { 
            init(); 
        } 
        return hierarchyStrings;
	}

	@Override
	public Class<?> getObjectType() {
		return String.class;
	}

	@Override
	public boolean isSingleton() {
		return true;
	}

}
