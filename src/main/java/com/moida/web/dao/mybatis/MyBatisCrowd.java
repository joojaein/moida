package com.moida.web.dao.mybatis;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moida.web.dao.CrowdDao;
import com.moida.web.entity.CrowdSimpleDataView;

@Repository
public class MyBatisCrowd implements CrowdDao{
	
	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public List<CrowdSimpleDataView> getSimpleList() {
		CrowdDao crowdDao = session.getMapper(CrowdDao.class);
		System.out.println("com.moida.web.dao.mybatis.MyBatisCrowd - List<CrowdSimpleDataView> getSimpleList()");
		return crowdDao.getSimpleList();
	}


	
}
