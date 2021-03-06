<%@page import="vo.SawonVO"%>
<%@page import="vo.DeptVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.InitialContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%

	int deptNum = Integer.parseInt(request.getParameter("deptno"));	//넘겨받은 파라미터 저장.
	/* DB 연동 */
	InitialContext ic = new InitialContext();	
	Context ctx = (Context)ic.lookup("java:comp/env"); 
	DataSource dataSource = (DataSource)ctx.lookup("jdbc/oracle_test");	
	Connection conn = dataSource.getConnection(); 

	String sql = "SELECT * FROM SAWON WHERE DEPTNO = " + deptNum;
	System.out.println(sql);
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();	
	/* DB 연동 */
	
	List<SawonVO> sawon_list = new ArrayList<>();
	while(rs.next()){	//rs.next() 수행시 다음 행을 탐색한다. 
		SawonVO vo = new SawonVO();	//사원 VO 생성
		//현재 컬럼값을 vo에 담는다.
		vo.setDeptNo(rs.getInt("DEPTNO"));//DEPTNO 컬럼에 있는 값을 가져옴	
		vo.setSabun(rs.getInt("SABUN"));	//DNAME 컬럼에 있는 값을 가져옴	
		vo.setSaJob(rs.getString("SAJOB"));	//LOC 컬럼에 있는 값을 가져옴	
		vo.setSaName(rs.getString("SANAME"));
		sawon_list.add(vo);
	}
	
	
	/* DB 스트림 해제 */
	rs.close();
	pstmt.close();
	conn.close();

%>
<html>
	<head>
		<meta charset="UTF-8">
		<title>데이터베이스에서 값 받아오기</title>
	</head>
	<body>
		<table border="1">
			<tr>
				<th>부서번호</th>
				<th>사번</th>
				<th>직책</th>
				<th>이름</th>
			</tr>
			
			<% for( int i = 0; i < sawon_list.size(); i++ ){ %>	
				<tr>
					<td><%= sawon_list.get(i).getDeptNo() %></td>
					<td><%= sawon_list.get(i).getSabun() %></td>
					<td><%= sawon_list.get(i).getSaJob() %></td>
					<td><%= sawon_list.get(i).getSaName() %></td>
				</tr>
			<%} %>
		</table>
	</body>
</html>