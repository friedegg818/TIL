package com.sp.security.intercept;

import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

/*
 * - DB기반의 보호된 자원 관리를 구현한 DAO 클래스
 *   DB 기반의 Secured Object 정보를 제공하기 위한 DAO 로
 *   default 쿼리를 제공하며 사용자 DB 에 맞는 각 유형의 DB 쿼리는 재설정 가능하다.  
 *   namedParameterJdbcTemplate 를 사용하여 DB 조회를 처리한다.
 */
public class SecuredObjectDAO {
	// private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public static final String DEF_ROLES_AND_URL_QUERY =
            "SELECT a.resource_pattern AS url, b.authority AS authority "
                + " FROM secured_resources a "
                + " JOIN secured_resources_role b ON a.resource_id = b.resource_id "
                + " WHERE a.resource_type = 'url' "
                + " ORDER BY a.sort_order ";
	public static final String DEF_ROLES_AND_METHOD_QUERY =
            "SELECT a.resource_pattern AS method, b.authority AS authority "
                + " FROM secured_resources a "
                + " JOIN secured_resources_role b ON a.resource_id = b.resource_id "
                + " WHERE a.resource_type = 'method' "
                + " ORDER BY a.sort_order ";
	public static final String DEF_ROLES_AND_POINTCUT_QUERY =
            "SELECT a.resource_pattern AS pointcut, b.authority AS authority "
                + " FROM secured_resources a "
                + " JOIN secured_resources_role b ON a.resource_id = b.resource_id "
                + " WHERE a.resource_type = 'pointcut' "
                + " ORDER BY a.sort_order ";
	public static final String DEF_HIERARCHICAL_ROLES_QUERY =
	        "SELECT a.child_role child, a.parent_role parent "
                + " FROM roles_hierarchy a "
                + " LEFT JOIN roles_hierarchy b ON a.child_role = b.parent_role ";
	
	private String sqlRolesAndUrl;
    private String sqlRolesAndMethod;
    private String sqlRolesAndPointcut;
    private String sqlHierarchicalRoles;
    
    // JdbcTemplate에서는 sql에 파라미터를 설정할 때 ?를 사용하고
    //     파라미터에 값을 대입할 때 Object 배열을 이용하지만 
    // NamedParameterJdbcTemplate은 파라미터를 설정할대 키이름을 사용하고 값 대입에 Map을 이용한다.
    private NamedParameterJdbcTemplate namedParameterJdbcTemplate;
    
    public SecuredObjectDAO() {
    	this.sqlRolesAndUrl = DEF_ROLES_AND_URL_QUERY;
        this.sqlRolesAndMethod = DEF_ROLES_AND_METHOD_QUERY;
        this.sqlRolesAndPointcut = DEF_ROLES_AND_POINTCUT_QUERY;
        this.sqlHierarchicalRoles = DEF_HIERARCHICAL_ROLES_QUERY;
    }

    public void setDataSource(DataSource dataSource) {
        this.namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
    }

	public String getSqlRolesAndUrl() {
		return sqlRolesAndUrl;
	}

	public void setSqlRolesAndUrl(String sqlRolesAndUrl) {
		this.sqlRolesAndUrl = sqlRolesAndUrl;
	}

	public String getSqlRolesAndMethod() {
		return sqlRolesAndMethod;
	}

	public void setSqlRolesAndMethod(String sqlRolesAndMethod) {
		this.sqlRolesAndMethod = sqlRolesAndMethod;
	}

	public String getSqlRolesAndPointcut() {
		return sqlRolesAndPointcut;
	}

	public void setSqlRolesAndPointcut(String sqlRolesAndPointcut) {
		this.sqlRolesAndPointcut = sqlRolesAndPointcut;
	}

	public String getSqlHierarchicalRoles() {
		return sqlHierarchicalRoles;
	}

	public void setSqlHierarchicalRoles(String sqlHierarchicalRoles) {
		this.sqlHierarchicalRoles = sqlHierarchicalRoles;
	}
    
	private LinkedHashMap<Object, List<ConfigAttribute>> getRolesAndResources(String resourceType) throws Exception {
        LinkedHashMap<Object, List<ConfigAttribute>> resourcesMap = new LinkedHashMap<Object, List<ConfigAttribute>>();

        String sqlRolesAndResources;
        boolean isResourcesUrl = true;
        
        if ("method".equals(resourceType)) {
            sqlRolesAndResources = getSqlRolesAndMethod();
            isResourcesUrl = false;
        } else if ("pointcut".equals(resourceType)) {
            sqlRolesAndResources = getSqlRolesAndPointcut();
            isResourcesUrl = false;
        } else {
            sqlRolesAndResources = getSqlRolesAndUrl();
        }

        List<Map<String, Object>> resultList = this.namedParameterJdbcTemplate.queryForList(sqlRolesAndResources, new HashMap<String, String>());

        Iterator<Map<String, Object>> it = resultList.iterator();
        Map<String, Object> tempMap;
        String preResource = null;
        String presentResourceStr;
        Object presentResource;

        while (it.hasNext()) {
            tempMap = it.next();
            presentResourceStr = (String) tempMap.get(resourceType);
            presentResource = isResourcesUrl ? new AntPathRequestMatcher(presentResourceStr) : presentResourceStr;

            List<ConfigAttribute> configList = new LinkedList<ConfigAttribute>();
            if (preResource != null && presentResourceStr.equals(preResource)) {
                List<ConfigAttribute> preAuthList = resourcesMap.get(presentResource);
                Iterator<ConfigAttribute> preAuthIt = preAuthList.iterator();
                while (preAuthIt.hasNext()) {
                    SecurityConfig tempConfig = (SecurityConfig) preAuthIt.next();
                    configList.add(tempConfig);
                }
            }

            configList.add(new SecurityConfig((String) tempMap.get("authority")));
            resourcesMap.put(presentResource, configList);
            preResource = presentResourceStr;
        }
        
        return resourcesMap;
    }
	
	public LinkedHashMap<Object, List<ConfigAttribute>> getRolesAndUrl() throws Exception {
        return getRolesAndResources("url");
    }
	
	public LinkedHashMap<Object, List<ConfigAttribute>> getRolesAndMethod() throws Exception {
        return getRolesAndResources("method");
    }
	
	public LinkedHashMap<Object, List<ConfigAttribute>> getRolesAndPointcut() throws Exception {
        return getRolesAndResources("pointcut");
    }
	
	public String getHierarchicalRoles() throws Exception {
        List<Map<String, Object>> resultList = this.namedParameterJdbcTemplate.queryForList(getSqlHierarchicalRoles(), new HashMap<String, String>());
        Iterator<Map<String, Object>> itr = resultList.iterator();
        StringBuffer concatedRoles = new StringBuffer();
        Map<String, Object> tempMap;

        while (itr.hasNext()) {
            tempMap = itr.next();
            concatedRoles.append(tempMap.get("child"));
            concatedRoles.append(" > ");
            concatedRoles.append(tempMap.get("parent"));
            concatedRoles.append("\n");
        }
       return concatedRoles.toString();
    }	
}
