package org.zerock.controller;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.domain.PageMaker;
import org.zerock.domain.SearchCriteria;
import org.zerock.service.BoardService;

@Controller
@RequestMapping("/sboard/*")

public class SearchBoardController {
	int cnt=0;
	
	
	 
	//String uploadPath= "C:\\Users\\AH\\Documents\\temp"; 
	private static final Logger logger = LoggerFactory.getLogger(SearchBoardController.class);
	
	@Inject
	private BoardService service;
	
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public void listPage(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception{
		logger.info(cri.toString());
		model.addAttribute("list",service.listSearchCriteria(cri));
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.listSearchCount(cri));
		model.addAttribute("pageMaker",pageMaker);	
	}
	
	@RequestMapping(value="/temp",method=RequestMethod.GET)
	public void listPage() throws Exception{
		logger.info("temp");

	}
	
	@RequestMapping(value="/readPage", method=RequestMethod.GET)
	public void read(@RequestParam("bno")int bno, @ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception{
		model.addAttribute(service.read(bno));
	}
	
	@RequestMapping(value="/register",method=RequestMethod.GET)
	public void registerGET() throws Exception{
		logger.info("register get......");
	}
	
	@RequestMapping(value="/register",method=RequestMethod.POST)
	public String registerPOST(BoardVO board, RedirectAttributes rttr) throws Exception{
		logger.info("regist post....");
		logger.info(board.toString());
		service.regist(board);
		rttr.addFlashAttribute("msg","SUCCESS");
		//model.addAttribute("result","success");
		return "redirect:/sboard/list";
	}
	
	@RequestMapping(value="/removePage",method=RequestMethod.POST)
	public String remove(@RequestParam("bno") int bno, SearchCriteria cri, RedirectAttributes rttr) throws Exception{
		service.remove(bno);
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		rttr.addAttribute("searchType",cri.getSearchType());
		rttr.addAttribute("keyword",cri.getKeyword());
		rttr.addFlashAttribute("mst","SUCCESS");
		return "redirect:/sboard/list";
	}
	
	@RequestMapping(value="/modifyPage",method=RequestMethod.GET)
	public void modifyget(@RequestParam("bno") int bno, @ModelAttribute("cri") SearchCriteria cri, Model model)throws Exception {	
		model.addAttribute(service.read(bno));
		logger.info(cri.toString()+"modify page get");
	}

	
	@RequestMapping(value="/modifyPage",method=RequestMethod.POST)
	public String modifypost(BoardVO board, SearchCriteria cri, RedirectAttributes rttr)throws Exception {	
		System.out.println(cnt++);
		logger.info(cri.toString()+"addAttribute 전");
		service.modify(board);
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		rttr.addAttribute("searchType",cri.getSearchType());
		rttr.addAttribute("keyword",cri.getKeyword());
		rttr.addFlashAttribute("msg","SUCCESS");
		logger.info(rttr.toString());
		return "redirect:/sboard/list";
	}
	
	@RequestMapping("/getAttach/{bno}")
	@ResponseBody
	public List<String> getAttach(@PathVariable("bno")Integer bno) throws Exception{
		return service.getAttach(bno);
	}
		
}
