package service;

import java.util.ArrayList;
import java.util.List;
import dao.BoardDAO;
import dao.BoardDaoImpl;

public class BoardServiceImpl implements BoardService{

	public BoardDAO dao;
	public String message;

	@Override
	public void setDao(BoardDAO dao) {
		this.dao = dao;
	}
	
	@Override
	public void setMessage(String message) {
		this.message = message;
	}
	
	@Override
	public List<String> selectList() {
		List<String> list = dao.selectList();
		list.add(message);
		return list;
	}

}








