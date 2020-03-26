package com.kh.kkiri.admin.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.kkiri.admin.model.dao.AdminDAO;
import com.kh.kkiri.admin.model.vo.Video;
import com.kh.kkiri.common.vo.PageInfo;
import com.kh.kkiri.member.model.vo.Member;
import com.kh.kkiri.payment.model.dao.PaymentDAO;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	private AdminDAO adminDAO;
	
	@Autowired
	private PaymentDAO paymentDAO;
	
	/** 회원 수 조회 Service
	 * @return memberCount
	 * @throws Exception
	 */
	@Override
	public int adminMemberCount(Map<String, Object> map) throws Exception {
		return adminDAO.adminMemberCount(map);
	}
	
	/** 회원 정보 조회(관리자) Service
	 * @param map
	 * @param pInf
	 * @return mList
	 * @throws Exception 
	 */
	@Override
	public List<Member> adminSelectMember(Map<String, Object> map, PageInfo pInf) throws Exception {
		return adminDAO.adminSelectMember(map, pInf);
	}
	
	/** 티켓 환불 Service
	 * @param map
	 * @return result
	 * @throws Exception
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int refundTicket(Map<String, Object> map) throws Exception {
		int result = adminDAO.refundTicket(map);
		if(result>0) {
			result = paymentDAO.insertPayment(map);
		}
				
		return result;
	}
	
	/** 회원 삭제 Service
	 * @param memberNo
	 * @return result
	 * @throws Exception
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int delete(Integer memberNo) throws Exception {
		return adminDAO.delete(memberNo);
	}
	
	/** 회원 삭제 복구 Service
	 * @param memberNo
	 * @return result
	 * @throws Exception
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int recover(Integer memberNo) throws Exception {
		return adminDAO.recover(memberNo);
	}
	
	/** 영상 업로드 Service
	 * @param videoName
	 * @return result
	 * @throws Exception
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int insertVideo(String videoName) throws Exception {
		return adminDAO.insertVideo(videoName);
	}
	
	/** 영상 조회 Service
	 * @return vList
	 * @throws Exception
	 */
	@Override
	public List<Video> adminSelectVideo() throws Exception {
		return adminDAO.adminSelectVideo();
	}
}
