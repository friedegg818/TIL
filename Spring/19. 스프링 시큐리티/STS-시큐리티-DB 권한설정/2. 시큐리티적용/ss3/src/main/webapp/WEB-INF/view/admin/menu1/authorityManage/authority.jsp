<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<link rel="stylesheet" href="<%=cp%>/resource/css/tabs.css" type="text/css">
<style type="text/css">
/* 모달대화상자 타이틀바 */
.ui-widget-header {
	background: none;
	border: none;
	height:35px;
	line-height:35px;
	border-bottom: 1px solid #cccccc;
	border-radius: 0px;
}

.hover-tr:hover {
	cursor: pointer;
	background: #fffdfd;
}

.help-block {
	margin-bottom: 5px;
}
</style>

<script type="text/javascript">
$(function(){
	$("#tab-roles").addClass("active");
	
	roles(1);
});

$(function(){
	$("ul.tabs li").click(function() {
		tab = $(this).attr("data-tab");
		
		$("ul.tabs li").each(function(){
			$(this).removeClass("active");
		});
		
		$("#tab-"+tab).addClass("active");
		
		if(tab=="roles")
			roles(1);
		else if(tab=="rolesHierarchy")
			rolesHierarchy(1);
		else if(tab=="resources")
			resources(1);
		else
			provisioning(1);
	});
});

// -- 권한(롤) 리스트 ------------------------------------
function roles(page) {
	var url = "<%=cp%>/admin/rolesManage/roles";
	var query = "pageNo="+page;
	$.ajax({
        url : url,
        data : query,
        type : 'post',
        success : function(data) {
        	$('#authority-content').html(data);
        },
        beforeSend : function(jqXHR) {
            // 서버에 요청하기 전에 "AJAX"라는 이름의 헤더 추가 
            jqXHR.setRequestHeader("AJAX", true);
        },
        error : function(jqXHR) {
            if (jqXHR.status == 401) {
            	console.log(jqXHR);
            } else if (jqXHR.status == 403) { // 로그인이 되지 않은 경우
                location.href="<%=cp%>/member/login";
            } else {
            	console.log(jqXHR);
            }
        }
    });
}

// 권한(롤) 수정 폼 및 상세보기
function updateRoles(authority) {
	var dlg = $("#authority-dialog").dialog({
		  autoOpen: false,
		  modal: true,
		  buttons: {
		       " 수정 " : function() {
		    	   sendRoles('${pageNo}'); 
		       },
		       " 삭제 " : function() {
		    	   deleteRoles(authority, '${pageNo}');
		       },
		       " 닫기 " : function() {
		    	   $(this).dialog("close");
		       }
		  },
		  height: 440,
		  width: 500,
		  title: "권한수정",
		  close: function(event, ui) {
		  }
	});
	
	var url = "<%=cp%>/admin/rolesManage/updateRoles";
	var query = "authority="+authority;

	$.ajax({
      url : url,
      data : query,
      type : 'get',
      success : function(data) {
    	$('#authority-dialog').html(data);
    	dlg.dialog("open");
      },
      beforeSend : function(jqXHR) {
        jqXHR.setRequestHeader("AJAX", true);
      },
      error : function(jqXHR) {
        if (jqXHR.status == 401) {
        	console.log(jqXHR);
        } else if (jqXHR.status == 403) {
            location.href="<%=cp%>/member/login";
        } else {
        	console.log(jqXHR);
        }
      }
  });
}

// 권한(롤) 등록 폼
function insertRoles() {
	var dlg = $("#authority-dialog").dialog({
		  autoOpen: false,
		  modal: true,
		  buttons: {
		       " 등록 " : function() {
		    	   sendRoles(1); 
		       },
		       " 닫기 " : function() {
		    	   $(this).dialog("close");
		       }
		  },
		  height: 365,
		  width: 500,
		  title: "권한등록",
		  close: function(event, ui) {
		  }
	});
	
	var url = "<%=cp%>/admin/rolesManage/insertRoles";
	var query = "tmp="+new Date().getTime();

	$.ajax({
      url : url,
      data : query,
      type : 'get',
      success : function(data) {
      	$('#authority-dialog').html(data);
      	dlg.dialog("open");
      },
      beforeSend : function(jqXHR) {
          jqXHR.setRequestHeader("AJAX", true);
      },
      error : function(jqXHR) {
          if (jqXHR.status == 401) {
          	console.log(jqXHR);
          } else if (jqXHR.status == 403) {
              location.href="<%=cp%>/member/login";
          } else {
          	console.log(jqXHR);
          }
      }
  });
}

// 권한(롤) 등록 및 수정 완료
function sendRoles(page) {
	  var f = document.rolesForm;

	  var str = $.trim(f.authority.value);
	  if(!str) {
	     f.authority.focus();
	     return;
	  }
	        
	  if(str.indexOf("ROLE_")!=0 || str.length<6) {
		  f.authority.focus();
	      return;
	  }
	  f.authority.value = str;

	  str = $.trim(f.role_name.value);
	  if(!str) {
		  f.role_name.focus();
		  return;
	  }
	  f.role_name.value = str;

	  var url = "<%=cp%>/admin/rolesManage/updateRoles";
	  var query=$("#rolesForm").serialize();

	  $.ajax({
	      url : url,
	      data : query,
	      type : 'post',
	      dataType:"json",
	      success : function(data) {
	    	  var state=data.state;
	    	  if(state=="insertFail") {
	    	     alert("권한 등록이 실패했습니다. !!!");
	    	  } else if(state=="updateFail") {
	     	     alert("권한 수정이 실패했습니다. !!!");
	    	  } else {
	    		  roles(page);
	    		  
	    		  $('#authority-dialog').dialog("close");
	    	  }
	      },
	      beforeSend : function(jqXHR) {
	          jqXHR.setRequestHeader("AJAX", true);
	      },
	      error : function(jqXHR) {
	          if (jqXHR.status == 401) {
	          	 console.log(jqXHR);
	          } else if (jqXHR.status == 403) { // 로그인이 되지 않은 경우
	              location.href="<%=cp%>/member/login";
	          } else {
	          	 console.log(jqXHR);
	          }
	      }
	  });  
}

// 권한(롤) 삭제
function deleteRoles(authority, page) {
	if(! confirm("권한을 삭제 하시 겠습니까 ? "))
		return;
	
	var url = "<%=cp%>/admin/rolesManage/deleteRoles";
	var query="authority="+authority;

	$.ajax({
	      url : url,
	      data : query,
	      type : 'post',
	      dataType:"json",
	      success : function(data) {
	    	  var state=data.state;
	    	  if(state=="false") {
	    	     alert("권한 삭제가 실패했습니다. !!!");
	    	  } else {
	    		  roles(page);
	    		  $('#authority-dialog').dialog("close");
	    	  }
	      },
	      beforeSend : function(jqXHR) {
	          jqXHR.setRequestHeader("AJAX", true);
	      },
	      error : function(jqXHR) {
	          if (jqXHR.status == 401) {
	          	 console.log(jqXHR);
	          } else if (jqXHR.status == 403) {
	              location.href="<%=cp%>/member/login";
	          } else {
	          	 console.log(jqXHR);
	          }
	      }
	});  
}

// -- 권한 계층구조 ------------------------------------
function rolesHierarchy(page) {
	var url = "<%=cp%>/admin/rolesManage/rolesHierarchy";
	var query = "pageNo="+page;

	$.ajax({
        url : url,
        data : query,
        type : 'post',
        success : function(data) {
        	$('#authority-content').html(data);
        },
        beforeSend : function(jqXHR) {
            jqXHR.setRequestHeader("AJAX", true);
        },
        error : function(jqXHR) {
            if (jqXHR.status == 401) {
            	console.log(jqXHR);
            } else if (jqXHR.status == 403) { // 로그인이 되지 않은 경우
                location.href="<%=cp%>/member/login";
            } else {
            	console.log(jqXHR);
            }
        }
    });
}

// 권한 상속관계 등록 폼
function insertRolesHierarchy() {
	var dlg = $("#authority-dialog").dialog({
		  autoOpen: false,
		  modal: true,
		  buttons: {
		       " 등록 " : function() {
		    	   sendRolesHierarchy(1); 
		       },
		       " 닫기 " : function() {
		    	   $(this).dialog("close");
		       }
		  },
		  height: 270,
		  width: 560,
		  title: "권한상속등록",
		  close: function(event, ui) {
		  }
	});
	
	var url = "<%=cp%>/admin/rolesManage/insertRolesHierarchy";
	var query = "tmp="+new Date().getTime();

	$.ajax({
      url : url,
      data : query,
      type : 'get',
      success : function(data) {
    	$('#authority-dialog').html(data);
    	dlg.dialog("open");
      },
      beforeSend : function(jqXHR) {
        jqXHR.setRequestHeader("AJAX", true);
      },
      error : function(jqXHR) {
        if (jqXHR.status == 401) {
        	console.log(jqXHR);
        } else if (jqXHR.status == 403) {
            location.href="<%=cp%>/member/login";
        } else {
        	console.log(jqXHR);
        }
      }
  });
}

function updateRolesHierarchy(parent_role, child_role) {
	var dlg = $("#authority-dialog").dialog({
		  autoOpen: false,
		  modal: true,
		  buttons: {
		       " 수정 " : function() {
		    	   sendRolesHierarchy('${pageNo}'); 
		       },
		       " 삭제 " : function() {
		    	   deleteRolesHierarchy(parent_role, child_role, '${pageNo}');
		       },
		       " 닫기 " : function() {
		    	   $(this).dialog("close");
		       }
		  },
		  height: 270,
		  width: 560,
		  title: "권한수정",
		  close: function(event, ui) {
		  }
	});
	
	var url = "<%=cp%>/admin/rolesManage/updateRolesHierarchy";
	var query = "parent_role="+parent_role+"&child_role="+child_role;

	$.ajax({
      url : url,
      data : query,
      type : 'get',
      success : function(data) {
  	    $('#authority-dialog').html(data);
  	    dlg.dialog("open");
      },
      beforeSend : function(jqXHR) {
        jqXHR.setRequestHeader("AJAX", true);
      },
      error : function(jqXHR) {
        if (jqXHR.status == 401) {
      	    console.log(jqXHR);
        } else if (jqXHR.status == 403) {
            location.href="<%=cp%>/member/login";
        } else {
      	   console.log(jqXHR);
        }
     }
  });
}

function sendRolesHierarchy(page) {
	  var f = document.rolesHierarchyForm;

	  if(f.parent_role.value == f.child_role.value) {
		  f.parent_role.focus();
		  return;
	  }
	  
	  var url = "<%=cp%>/admin/rolesManage/updateRolesHierarchy";
	  var query=$("#rolesHierarchyForm").serialize();

	  $.ajax({
	      url : url,
	      data : query,
	      type : 'post',
	      dataType:"json",
	      success : function(data) {
	    	  var state=data.state;
	    	  if(state=="insertFail") {
	    	     alert("권한 등록이 실패했습니다. !!!");
	    	  } else if(state=="updateFail") {
	     	     alert("권한 수정이 실패했습니다. !!!");
	    	  } else {
	    		  rolesHierarchy(page);
	    		  
	    		  $('#authority-dialog').dialog("close");
	    	  }
	      },
	      beforeSend : function(jqXHR) {
	          jqXHR.setRequestHeader("AJAX", true);
	      },
	      error : function(jqXHR) {
	          if (jqXHR.status == 401) {
	          	 console.log(jqXHR);
	          } else if (jqXHR.status == 403) { // 로그인이 되지 않은 경우
	              location.href="<%=cp%>/member/login";
	          } else {
	          	 console.log(jqXHR);
	          }
	      }
	  });  
}

function deleteRolesHierarchy(parent_role, child_role, page) {
	if(! confirm("권한 계층구조 삭제 하시 겠습니까 ? "))
		return;
	
	var url = "<%=cp%>/admin/rolesManage/deleteRolesHierarchy";
	var query="parent_role="+parent_role+"&child_role="+child_role;

	$.ajax({
	      url : url,
	      data : query,
	      type : 'post',
	      dataType:"json",
	      success : function(data) {
	    	  var state=data.state;
	    	  if(state=="false") {
	    	     alert("계층구조 삭제가 실패했습니다. !!!");
	    	  } else {
	    		  rolesHierarchy(page);
	    		  $('#authority-dialog').dialog("close");
	    	  }
	      },
	      beforeSend : function(jqXHR) {
	          jqXHR.setRequestHeader("AJAX", true);
	      },
	      error : function(jqXHR) {
	          if (jqXHR.status == 401) {
	          	 console.log(jqXHR);
	          } else if (jqXHR.status == 403) {
	              location.href="<%=cp%>/member/login";
	          } else {
	          	 console.log(jqXHR);
	          }
	      }
	});  
}

// -- 리소스 패턴 관리 ------------------------------------
function resources(page) {
	var url = "<%=cp%>/admin/resourcesManage/resources";
	var query = "pageNo="+page;
	$.ajax({
        url : url,
        data : query,
        type : 'post',
        success : function(data) {
        	$('#authority-content').html(data);
        },
        beforeSend : function(jqXHR) {
            jqXHR.setRequestHeader("AJAX", true);
        },
        error : function(jqXHR) {
            if (jqXHR.status == 401) {
            	console.log(jqXHR);
            } else if (jqXHR.status == 403) {
                location.href="<%=cp%>/member/login";
            } else {
            	console.log(jqXHR);
            }
        }
    });
}

function insertResources() {
	var dlg = $("#authority-dialog").dialog({
		  autoOpen: false,
		  modal: true,
		  buttons: {
		       " 등록 " : function() {
		    	   sendResources(1); 
		       },
		       " 닫기 " : function() {
		    	   $(this).dialog("close");
		       }
		  },
		  height: 550,
		  width: 600,
		  title: "리소스 패턴 등록",
		  close: function(event, ui) {
		  }
	});
	
	var url = "<%=cp%>/admin/resourcesManage/insertResources";
	var query = "tmp="+new Date().getTime();

	$.ajax({
      url : url,
      data : query,
      type : 'get',
      success : function(data) {
    	  $('#authority-dialog').html(data);
    	  dlg.dialog("open");
      },
      beforeSend : function(jqXHR) {
          jqXHR.setRequestHeader("AJAX", true);
      },
      error : function(jqXHR) {
         if (jqXHR.status == 401) {
        	console.log(jqXHR);
         } else if (jqXHR.status == 403) {
            location.href="<%=cp%>/member/login";
         } else {
        	console.log(jqXHR);
         }
      }
  });
}

function updateResources(resource_id) {
	var dlg = $("#authority-dialog").dialog({
		  autoOpen: false,
		  modal: true,
		  buttons: {
		       " 수정 " : function() {
		    	   sendResources('${pageNo}'); 
		       },
		       " 삭제 " : function() {
		    	   deleteResources(resource_id, '${pageNo}');
		       },
		       " 닫기 " : function() {
		    	   $(this).dialog("close");
		       }
		  },
		  height: 630,
		  width: 600,
		  title: "리소스 패턴 수정",
		  close: function(event, ui) {
		  }
	});
	
	var url = "<%=cp%>/admin/resourcesManage/updateResources";
	var query = "resource_id="+resource_id;

	$.ajax({
      url : url,
      data : query,
      type : 'get',
      success : function(data) {
	       $('#authority-dialog').html(data);
	       dlg.dialog("open");
      },
      beforeSend : function(jqXHR) {
           jqXHR.setRequestHeader("AJAX", true);
      },
      error : function(jqXHR) {
           if (jqXHR.status == 401) {
    	       console.log(jqXHR);
           } else if (jqXHR.status == 403) {
             location.href="<%=cp%>/member/login";
           } else {
    	      console.log(jqXHR);
           }
     }
  });
}

// 권한(롤) 등록 및 수정 완료
function sendResources(page) {
	  var f = document.resourcesForm;

	  var str = $.trim(f.resource_name.value);
	  if(!str) {
	     f.resource_name.focus();
	     return;
	  }
	  f.resource_name.value = str;

	  str = $.trim(f.resource_pattern.value);
	  if(!str) {
		  f.resource_pattern.focus();
		  return;
	  }
	  f.resource_pattern.value = str;
	  
	  if(! /^(\d+)$/.test(f.sort_order.value)) {
		  f.sort_order.focus();
		  return;
	  }
	  
	  str = $.trim(f.resource_pattern.value);
	  if(f.resource_type.value=="url" && str.indexOf("/")!=0) {
		  alert("리소스 타입이 url인 경우 패턴은 /로 시작해야 합니다.");
		  f.resource_pattern.focus();
		  return;
	  }
	  
	  var url = "<%=cp%>/admin/resourcesManage/updateResources";
	  var query=$("#resourcesForm").serialize();

	  $.ajax({
	      url : url,
	      data : query,
	      type : 'post',
	      dataType:"json",
	      success : function(data) {
	    	  var state=data.state;
	    	  if(state=="insertFail") {
	    	     alert("패턴 등록이 실패했습니다. !!!");
	    	  } else if(state=="updateFail") {
	     	     alert("패턴 수정이 실패했습니다. !!!");
	    	  } else {
	    		  resources(page);
	    		  
	    		  $('#authority-dialog').dialog("close");
	    	  }
	      },
	      beforeSend : function(jqXHR) {
	          jqXHR.setRequestHeader("AJAX", true);
	      },
	      error : function(jqXHR) {
	          if (jqXHR.status == 401) {
	          	 console.log(jqXHR);
	          } else if (jqXHR.status == 403) {
	              location.href="<%=cp%>/member/login";
	          } else {
	          	 console.log(jqXHR);
	          }
	      }
	  });
}

function deleteResources(resource_id, page) {
	if(! confirm("패턴을 삭제 하시 겠습니까 ? "))
		return;
	
	var url = "<%=cp%>/admin/resourcesManage/deleteResources";
	var query="resource_id="+resource_id;

	$.ajax({
	      url : url,
	      data : query,
	      type : 'post',
	      dataType:"json",
	      success : function(data) {
	    	  var state=data.state;
	    	  if(state=="false") {
	    	     alert("패턴 삭제가 실패했습니다. !!!");
	    	  } else {
	    		  resources(page);
	    		  $('#authority-dialog').dialog("close");
	    	  }
	      },
	      beforeSend : function(jqXHR) {
	          jqXHR.setRequestHeader("AJAX", true);
	      },
	      error : function(jqXHR) {
	          if (jqXHR.status == 401) {
	          	 console.log(jqXHR);
	          } else if (jqXHR.status == 403) {
	              location.href="<%=cp%>/member/login";
	          } else {
	          	 console.log(jqXHR);
	          }
	      }
	});
}

//-- 리소스에 대한 프로비저닝(권한) 설정 ------------------------------------
function provisioning(page) {
	var url = "<%=cp%>/admin/resourcesManage/provisioning";
	var query = "pageNo="+page;
	$.ajax({
        url : url,
        data : query,
        type : 'post',
        success : function(data) {
        	$('#authority-content').html(data);
        },
        beforeSend : function(jqXHR) {
            jqXHR.setRequestHeader("AJAX", true);
        },
        error : function(jqXHR) {
            if (jqXHR.status == 401) {
            	console.log(jqXHR);
            } else if (jqXHR.status == 403) {
                location.href="<%=cp%>/member/login";
            } else {
            	console.log(jqXHR);
            }
        }
    });
}

function insertProvisioning() {
	var dlg = $("#authority-dialog").dialog({
		  autoOpen: false,
		  modal: true,
		  buttons: {
		       " 등록 " : function() {
		    	   sendProvisioning(1); 
		       },
		       " 닫기 " : function() {
		    	   $(this).dialog("close");
		       }
		  },
		  height: 310,
		  width: 500,
		  title: "리소스 권한 등록",
		  close: function(event, ui) {
		  }
	});
	
	var url = "<%=cp%>/admin/resourcesManage/insertProvisioning";
	var query = "tmp="+new Date().getTime();

	$.ajax({
        url : url,
        data : query,
        type : 'get',
        success : function(data) {
  	      $('#authority-dialog').html(data);
  	      dlg.dialog("open");
        },
        beforeSend : function(jqXHR) {
          jqXHR.setRequestHeader("AJAX", true);
        },
        error : function(jqXHR) {
          if (jqXHR.status == 401) {
             console.log(jqXHR);
          } else if (jqXHR.status == 403) {
             location.href="<%=cp%>/member/login";
          } else {
            console.log(jqXHR);
         }
      }
    });
}

function updateProvisioning(resource_id, authority) {
	var dlg = $("#authority-dialog").dialog({
		  autoOpen: false,
		  modal: true,
		  buttons: {
		       " 수정 " : function() {
		    	   sendProvisioning('${pageNo}'); 
		       },
		       " 삭제 " : function() {
		    	   deleteProvisioning(resource_id, authority, '${pageNo}');
		       },
		       " 닫기 " : function() {
		    	   $(this).dialog("close");
		       }
		  },
		  height: 390,
		  width: 500,
		  title: "리소스 권한 수정",
		  close: function(event, ui) {
		  }
	});
	
	var url = "<%=cp%>/admin/resourcesManage/updateProvisioning";
	var query = "resource_id="+resource_id+"&authority="+authority;

	$.ajax({
       url : url,
       data : query,
       type : 'get',
       success : function(data) {
	       $('#authority-dialog').html(data);
	       dlg.dialog("open");
       },
       beforeSend : function(jqXHR) {
         jqXHR.setRequestHeader("AJAX", true);
       },
       error : function(jqXHR) {
         if (jqXHR.status == 401) {
  	       console.log(jqXHR);
         } else if (jqXHR.status == 403) {
           location.href="<%=cp%>/member/login";
         } else {
  	      console.log(jqXHR);
         }
      }
   });

}

function selectPattern() {
	var f=document.provisioningForm;
	f.resource_id2.value=f.resource_id.value;
}

function sendProvisioning(page) {
	  var url = "<%=cp%>/admin/resourcesManage/updateProvisioning";
	  var query=$("#provisioningForm").serialize();

	  $.ajax({
	      url : url,
	      data : query,
	      type : 'post',
	      dataType:"json",
	      success : function(data) {
	    	  var state=data.state;
	    	  if(state=="insertFail") {
	    	     alert("리소스에 대한 권한 등록이 실패했습니다. !!!");
	    	  } else if(state=="updateFail") {
	     	     alert("리소스에 대한 권한 수정이 실패했습니다. !!!");
	    	  } else {
	    		  provisioning(page);
	    		  
	    		  $('#authority-dialog').dialog("close");
	    	  }
	      },
	      beforeSend : function(jqXHR) {
	          jqXHR.setRequestHeader("AJAX", true);
	      },
	      error : function(jqXHR) {
	          if (jqXHR.status == 401) {
	          	 console.log(jqXHR);
	          } else if (jqXHR.status == 403) {
	              location.href="<%=cp%>/member/login";
	          } else {
	          	 console.log(jqXHR);
	          }
	      }
	  });
}

function deleteProvisioning(resource_id, authority, page) {
	if(! confirm("리소스에 대한 권한을 삭제 하시 겠습니까 ? "))
		return;
	
	var url = "<%=cp%>/admin/resourcesManage/deleteProvisioning";
	var query="resource_id="+resource_id+"&authority="+authority;

	$.ajax({
	      url : url,
	      data : query,
	      type : 'post',
	      dataType:"json",
	      success : function(data) {
	    	  var state=data.state;
	    	  if(state=="false") {
	    	     alert("리소스에 대한 권한 삭제가 실패했습니다. !!!");
	    	  } else {
	    		  provisioning(page);
	    		  $('#authority-dialog').dialog("close");
	    	  }
	      },
	      beforeSend : function(jqXHR) {
	          jqXHR.setRequestHeader("AJAX", true);
	      },
	      error : function(jqXHR) {
	          if (jqXHR.status == 401) {
	          	 console.log(jqXHR);
	          } else if (jqXHR.status == 403) {
	              location.href="<%=cp%>/member/login";
	          } else {
	          	 console.log(jqXHR);
	          }
	      }
	});
}

</script>

<div class="body-content-container">
     <div class="body-title">
         <h3><span style="font-family: Webdings">2</span> 권한관리 </h3>
     </div>
     
     <div>
         <div style="clear: both;">
	        <ul class="tabs">
			    <li id="tab-roles" data-tab="roles">권한(롤) 관리</li>
			    <li id="tab-rolesHierarchy" data-tab="rolesHierarchy">권한 계층구조</li>
			    <li id="tab-resources" data-tab="resources">리소스 패턴 관리</li>
			    <li id="tab-provisioning" data-tab="provisioning">리소스 권한 설정</li>
			</ul>
		</div>
		
		<div id="authority-content" style="clear:both; padding: 20px 0px 0px;"></div>
     </div>
     
 	 <div id="authority-dialog" style="display: none;"></div>
</div>