package com.sp.ts2;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.sp.common.dao.CommonDAO;

@Transactional(readOnly = true)
@Service("ts2.demoService")
public class DemoServiceImpl implements DemoService {
	@Autowired
	private CommonDAO dao;	
	
	// 메소드의 @Transactional 가 우선순위가 높음
	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor={Exception.class})
	public void insertDemo(Demo dto) throws Exception {
		try {
			dao.insertData("ts2.insertDemo1", dto);
			dao.insertData("ts2.insertDemo2", dto);
			dao.insertData("ts2.insertDemo3", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
			throw e;
		}
	}
}
