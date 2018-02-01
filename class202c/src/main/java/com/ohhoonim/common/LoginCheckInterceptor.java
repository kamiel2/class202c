package com.ohhoonim.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter {
	
	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {         
         System.out.println("Interceptor : PreHandle");
       String contextPath = request.getContextPath();
       // Session getAdminId check
       HttpSession session = request.getSession();   
       String getAdminId = (String) session.getAttribute("getAdminId");
// Login false
       if(null==getAdminId) {
        System.out.println("Interceptor : Session Check Fail");
        // main page 로 이동
        response.sendRedirect(contextPath + "/macomm/login.do");
        return false;
       } 
       // Login true
       else { 
        System.out.println("Interceptor : Session Check true");
        return super.preHandle(request, response, handler);
       }
}

}
