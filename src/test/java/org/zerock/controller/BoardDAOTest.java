package org.zerock.controller;

import java.util.List;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.SearchCriteria;
import org.zerock.persistence.BoardDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations ={"file:src/main/webapp/WEB-INF/spring/*.xml"})
public class BoardDAOTest {

	@Inject
	private BoardDAO dao;
	private static final Logger logger = LoggerFactory.getLogger(BoardDAOTest.class);
	/*
	@Test
	public void testCreate() throws Exception{
		BoardVO board = new BoardVO();
		board.setTitle("ho");
		board.setContent("1111234");
		board.setWriter("111김아형");
		dao.create(board);
	}
	@Test
	public void testRead() throws Exception{
		logger.info(dao.read(1).toString());
	}
	@Test 
	public void testUpdate() throws Exception{
		BoardVO board = new BoardVO();
		board.setBno(1);
		board.setTitle("수정된 글입니다.");
		board.setContent("수정 테스트");
		dao.update(board);
	}
	@Test
	public void testListPage() throws Exception{
		int page =0;
		List<BoardVO> list=dao.listPage(page);
		for(BoardVO boardVO : list) {
			logger.info(boardVO.getBno()+":"+boardVO.getTitle());
		}
	}
	*/

	@Test
	public void testListCriteria() throws Exception{
		Criteria cri = new Criteria();
		cri.setPage(0);
		cri.setPerPageNum(3);
		List<BoardVO> list=dao.listCriteria(cri);
		for(BoardVO boardVO : list) {
			logger.info(boardVO.getBno()+":"+boardVO.getTitle());
		}
	}
	 
	@Test
	public void TestSearch() throws Exception{
		SearchCriteria cri = new SearchCriteria();
		cri.setPage(1);
		cri.setKeyword("오");
		cri.setSearchType("t");
		
		logger.info("=============");
		List<BoardVO> list = dao.listSearch(cri);
		for (BoardVO boardVO : list) {
			logger.info(boardVO.getBno()+": "+boardVO.getTitle());
		}
		logger.info("--------------");
		logger.info("COUNT : "+dao.listSearchCount(cri));
	}

}
