package com.sp.security.intercept;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.web.util.matcher.RequestMatcher;

public interface SecuredObjectService {
	public LinkedHashMap<RequestMatcher, List<ConfigAttribute>> getRolesAndUrl() throws Exception;
	public LinkedHashMap<String, List<ConfigAttribute>> getRolesAndMethod() throws Exception;
	public LinkedHashMap<String, List<ConfigAttribute>> getRolesAndPointcut() throws Exception;
	public String getHierarchicalRoles() throws Exception;
}
