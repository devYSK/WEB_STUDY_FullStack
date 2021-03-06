package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import service.DBService;
import vo.DeptVO;

//DAO : Data Access Object(DB접근을 목표로 하는 객체)

public class DeptDAO {
	// single-ton pattern: 
	// 객체1개만생성해서 지속적으로 서비스하자
	static DeptDAO single = null;

	public static DeptDAO getInstance() {
		//생성되지 않았으면 생성
		if (single == null)
			single = new DeptDAO();
		//생성된 객체정보를 반환
		return single;
	}
	
	//부서 전체목록 조회
	//_select 자동완성 selectList : 전체조회, selectOne : 하나조회, ctrl,shift,o로 import
	public List<DeptVO> selectList() {

		List<DeptVO> list = new ArrayList<DeptVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM DEPT";

		try {
			//1.Connection얻어온다
			conn = DBService.getInstance().getConnection();
			//2.명령처리객체정보를 얻어오기
			pstmt = conn.prepareStatement(sql);

			//3.결과행 처리객체 얻어오기
			rs = pstmt.executeQuery();

			while (rs.next()) {
				DeptVO vo = new DeptVO();
				//현재레코드값=>Vo저장
				vo.setDeptNO(rs.getInt("DEPTNO"));
				vo.setdName(rs.getString("DNAME"));
				vo.setLoc(rs.getString("LOC"));
				//ArrayList추가
				list.add(vo);
			}

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {

			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		return list;
	}
}
