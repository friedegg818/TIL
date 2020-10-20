package com.sp.security.intercept;

import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.web.FilterInvocation;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;
import org.springframework.security.web.util.matcher.RequestMatcher;

/*
 *  - MetadataSource 처리
 *    대상 정보를 <intercept-url> 태그가 아닌 DB에서 읽은 값으로 구성하고 판단 주체를 
 *    보터(Voter)가 DB에서 읽은 값으로 구성된 대상 정보로 판단하기 위해 커스터마이징한 클래스
 *    
 *  - FilterInvocationSecurityMetadataSource
 *    : url이나 method를 이용한 접근권한이 어떻게 되는지 확인
 *    : FilterInvocationSecurityMetadataSource에서 얻어온 ROLE들과 사용자가 갖은 ROLE을 이용해서
 *      AccessVote를 진행
 */
public class MyFilterInvocationSecurityMetadataSource implements FilterInvocationSecurityMetadataSource {
	private static final Logger logger = LoggerFactory.getLogger(MyFilterInvocationSecurityMetadataSource.class);
	private final Map<RequestMatcher, Collection<ConfigAttribute>> requestMap;
	private SecuredObjectService securedObjectService;
	
	public MyFilterInvocationSecurityMetadataSource(Map<RequestMatcher, Collection<ConfigAttribute>> requestMap) {
		this.requestMap = requestMap;
	}
	
	public void setSecuredObjectService(SecuredObjectService securedObjectService) {
        this.securedObjectService = securedObjectService;
    }
	
	@Override
	public Collection<ConfigAttribute> getAttributes(Object object) throws IllegalArgumentException {
		HttpServletRequest request = ((FilterInvocation)object).getRequest();

        Collection<ConfigAttribute> result = null;
        for(Map.Entry<RequestMatcher, Collection<ConfigAttribute>> entry : requestMap.entrySet()){
            if(entry.getKey().matches(request)){
                result = entry.getValue();
                break;
            }
        }

        return result;
	}

	@Override
	public Collection<ConfigAttribute> getAllConfigAttributes() {
		Set<ConfigAttribute> allAttributes = new HashSet<ConfigAttribute>();

        for(Map.Entry<RequestMatcher, Collection<ConfigAttribute>> entry : requestMap.entrySet()){
            allAttributes.addAll(entry.getValue());
        }

        return allAttributes;
	}

	@Override
	public boolean supports(Class<?> clazz) {
		return FilterInvocation.class.isAssignableFrom(clazz);
	}
	
	public void reloadRequestMap() throws Exception {
		LinkedHashMap<RequestMatcher, List<ConfigAttribute>> reloadedMap = securedObjectService.getRolesAndUrl();
        Iterator<Entry<RequestMatcher, List<ConfigAttribute>>> iterator = reloadedMap.entrySet().iterator();

        // 이전 데이터 삭제
        requestMap.clear();

        while (iterator.hasNext()) {
            Entry<RequestMatcher, List<ConfigAttribute>> entry = iterator.next();
            requestMap.put(entry.getKey(), entry.getValue());
        }

        if (logger.isInfoEnabled()) {
            logger.info("Secured Url Resources - Role Mappings reloaded at Runtime!");
        }
    }
}
