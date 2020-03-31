package com.kh.kkiri.common;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpSession;
//import javax.servlet.http.HttpSessionEvent;
//import javax.servlet.http.HttpSessionListener;
//
//import org.springframework.web.context.WebApplicationContext;
//import org.springframework.web.context.request.RequestContextHolder;
//import org.springframework.web.context.request.ServletRequestAttributes;
//import org.springframework.web.context.support.WebApplicationContextUtils;
//
//import com.kh.kkiri.common.dao.VisitCountDAO;
//
//public class VisitSessionListener implements HttpSessionListener{
//	
//	@Override
//	public void sessionCreated(HttpSessionEvent arg0) {
//		
//		HttpSession session = arg0.getSession();
//        WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(session.getServletContext());
//        //등록되어있는 빈을 사용할수 있도록 설정해준다
//        HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
//        //request를 파라미터에 넣지 않고도 사용할수 있도록 설정
//        VisitCountDAO visitCountDAO = (VisitCountDAO)wac.getBean("visitCounterDAO");
////        VisitCountVO vo = new VisitCountVO();
////        vo.setVisit_ip(req.getRemoteAddr());
////        vo.setVisit_agent(req.getHeader("User-Agent"));//브라우저 정보
////        vo.setVisit_refer(req.getHeader("referer"));//접속 전 사이트 정보
//        try {
//			visitCountDAO.insertVisitor();
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//	}
//	
//	@Override
//	public void sessionDestroyed(HttpSessionEvent arg0) {
//		
//	}
//}
