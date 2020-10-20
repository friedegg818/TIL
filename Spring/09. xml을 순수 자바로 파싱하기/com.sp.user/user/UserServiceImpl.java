package com.sp.user;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

@Service("user.userService")
public class UserServiceImpl implements UserService {

	@Override
	public Map<String, Object> serializeNode(String spec) {
		Map<String, Object> map = new HashMap<String, Object>();

		// XML 문서를 분석하여 Map에 저장
		InputStream is = null;

		try {
			List<User> list = new ArrayList<User>();

			is = new URL(spec).openConnection().getInputStream();
			// InputSource : XML 엔티티의 단일 입력 소스
			InputSource source = new InputSource(new InputStreamReader(is, "UTF-8"));

			// DOM Document를 생성하기 위한 팩토리 생성
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			// 팩토리부터 Document 파서를 얻어낸다.
			DocumentBuilder parser = factory.newDocumentBuilder();
			// Document DOM 파서에게 입력 받은 파일을 파싱하도록 요청
			Document xmlDoc = parser.parse(source);

			// Element : XML 문서의 원소를 표현
			Element root = xmlDoc.getDocumentElement(); // xml 루트요소

			Node nodeCount = root.getElementsByTagName("dataCount").item(0);
			String dataCount = nodeCount.getFirstChild().getNodeValue();

			NodeList items = root.getElementsByTagName("record");
			for (int i = 0; i < items.getLength(); i++) {
				Node item = items.item(i);
				NodeList itemList = item.getChildNodes();

				// 속성 값
				NamedNodeMap itemMap = item.getAttributes();
				String num = itemMap.getNamedItem("num").getNodeValue();

				User dto = new User();
				dto.setNum(Integer.parseInt(num));
				for (int j = 0; j < itemList.getLength(); j++) {
					Node e = itemList.item(j);
					if (e.getNodeType() == nodeCount.ELEMENT_NODE) {
						String name = e.getNodeName();
						String value = e.getChildNodes().item(0).getNodeValue();	// 각각의 태그는 1개씩만 있으므로 item(0)

						if (name.equals("name")) {
							dto.setName(value);
						} else if (name.equals("content")) {
							dto.setContent(value);
						} else if (name.equals("created")) {
							dto.setCreated(value);
						}
					}
				}
				
				list.add(dto);
			}
			
			map.put("dataCount", dataCount);
			map.put("list", list);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (is != null) {
				try {
					is.close();
				} catch (Exception e2) {
				}
			}
		}

		return map;
	}

	@Override
	public String documentWriter(String spec) {

		return null;
	}

}
