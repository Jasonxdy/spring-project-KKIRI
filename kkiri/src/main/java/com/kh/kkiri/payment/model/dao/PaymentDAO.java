package com.kh.kkiri.payment.model.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PaymentDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int insertPayment(Map<String, Object> map) throws Exception {
		return sqlSession.insert("paymentMapper.insertPayment", map);
	}

	public int deleteTicket(String merchant_uid) throws Exception{

		
		return sqlSession.delete("paymentMapper.deleteTicket", merchant_uid);
	}
}
