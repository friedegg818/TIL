package com.util;

public class MyUtil {
	/**
	 * ������ �� ���ϱ�
	 * @param rows �� ȭ�鿡 ǥ���� ������ ���� 
	 * @param dataCount ��ü ������ �� 
	 * @return ������ �� 
	 */	
	public int pageCount(int rows, int dataCount) {		
		if(dataCount<0) 
			return 0;
		
		return dataCount / rows + (dataCount%rows>0?1:0);
	}
	
	/**
	 * ����¡ó�� (GET ���)
	 * @param current_page ���� ǥ�� �� ������
	 * @param total_page ��ü ������ �� 
	 * @param list_url ��ũ�� ������ url
	 * @return ����¡ ó�� ��� 
	 */	
	public String paging(int current_page, int total_page, String list_url) {
		StringBuilder sb = new StringBuilder();
		
		int numPerBlock = 10; 	// �� �������� ǥ�� �� �Խù� ���� 
		int currentPageSetup; 
		int n, page; 
		
		if(current_page < 1 || total_page < 1) 
			return "";
		
		if(list_url.indexOf("?")!=-1) {
			list_url += "&";
		} else {
			list_url += "?";
		}
		
		// currentPageSetup : ǥ�� �� ù ������ -1 
		currentPageSetup = (current_page/numPerBlock)*numPerBlock; 
		if(current_page%numPerBlock==0)
			currentPageSetup = currentPageSetup-numPerBlock;
		
		sb.append("<div id='paginate'>");
		
		// ó��, ���� (10������ ��) 
		n = current_page - numPerBlock;
		if(total_page > numPerBlock && currentPageSetup > 0) {
			sb.append("<a href='"+list_url+"page=1'>[ó��]</a>");
			sb.append("&nbsp;<a href='"+list_url+"page="+n+"'>[����]</a>");
		}
		
		// ����¡ 
		page = currentPageSetup+1;
		while(page<=total_page && page<=(currentPageSetup+numPerBlock)) {
			if(page==current_page) {
				sb.append("&nbsp;<span style='color:Fuchsia;'>"+page+"</span>");
				sb.append("");
			} else {
				sb.append("&nbsp;<a href='"+list_url+"page="+page+"'>"+page+"</a>");
			}
			page++;
		}	
		
		// ����(10������ ��), ������ ������ 
		n = current_page+numPerBlock;
		if(n>total_page) n=total_page;
		
		if(total_page - currentPageSetup > numPerBlock) {
			sb.append("&nbsp;<a href='"+list_url+"page="+n+"'>[����]</a>");
			sb.append("&nbsp;<a href='"+list_url+"page="+total_page+"'>[��]</a>");
		}		
		sb.append("</div>");
				
		return sb.toString();
	}	
}
