package com.ikeo.event.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ikeo.community.vo.CommunityImageVO;
import com.ikeo.event.service.EventService;
import com.ikeo.event.vo.EventImageVO;
import com.ikeo.event.vo.EventVO;
import com.ikeo.eventReply.service.EventReplyService;
import com.ikeo.eventReply.vo.EventReplyVO;
import com.ikeo.member.vo.LoginVO;
import com.webjjang.util.file.FileUtil;
import com.webjjang.util.page.PageObject;
import com.webjjang.util.page.ReplyPageObject;

import lombok.Data;

@Controller
@RequestMapping("/event")
@Data
public class EventController {

	@Autowired
	@Qualifier("eventServiceImpl")
	private EventService service;

	@Autowired
	@Qualifier("eventReplyServiceImpl")
	private EventReplyService replyService;
	
	String path = "/upload/image";

	@GetMapping("/list.do")
	public String list(Model model, @ModelAttribute PageObject pageObject, HttpServletRequest request) {
		String perPageNumStr = request.getParameter("perPageNum");
		pageObject.setPerPageNum((perPageNumStr == null) ? 8L : Long.parseLong(perPageNumStr));
		model.addAttribute("list", service.list(pageObject));

		return "event/eventList";
	}

	@GetMapping("/view.do")
	public String view(Long no, Model model, HttpServletRequest request) throws Exception {
		// System.out.println("EventController.view() - ");
		ReplyPageObject replyPageObject = new ReplyPageObject(request);
		EventVO vo = service.view(no);
		
		vo.setContent(vo.getContent()
				.replace(" ", "&nbsp;").replace("<", "&lt;")
				.replace(">", "&gt;").replace("\n", "<br>"));
		
		model.addAttribute("vo", vo);
		model.addAttribute("imageList", service.getImageFile(no));
		List<EventReplyVO> replyList = replyService.replyList(replyPageObject);
		
		for(EventReplyVO replyVO : replyList) {
			replyVO.setContent(replyVO.getContent()
					.replace(" ", "&nbsp;").replace("<", "&lt;")
					.replace(">", "&gt;").replace("\n", "<br>"));
		}
		model.addAttribute("replyList", replyList);
		model.addAttribute("replyPageObject", replyPageObject);
		System.out.println("replyPageObject - " + replyPageObject);
		return "event/eventView";
	}

	@GetMapping("/write.do")
	public String write() {
		return "event/eventWrite";
	}

	// 글등록 처리.
	@PostMapping("/write.do")
	public String write(EventVO vo, Long perPageNum, HttpServletRequest request, HttpSession session,
			RedirectAttributes rttr) throws Exception {
		System.out.println("EventController.write().vo - " + vo);

		vo.setId(((LoginVO) session.getAttribute("login")).getId());

		// DB에 저장 할 file 정보가 여러개 들어 있는 변수 선언
		List<EventImageVO> fileList = new ArrayList<EventImageVO>();

		// 넘어오는 파일의 정보 출력 - 메인 이미지
		System.out.println("EventController.write() - 대표 이미지 : " + vo.getPreImageFile().getOriginalFilename());

		// 대표 이미지 업로드
		String prFileName = FileUtil.upload(path, vo.getPreImageFile(), request);
		EventImageVO prVO = new EventImageVO();
		prVO.setFile_name(prFileName);
		prVO.setPr(1);

		fileList.add(prVO);

		// 넘어오는 파일의 정보 출력 - 추가 이미지
		System.out.println("EventController.write() - 추가 이미지 : ");
		if (vo.getImageFile().isEmpty())
			System.out.println("추가 이미지 없음");
		else {
			// 추가 파일 업로드
			String fileName = FileUtil.upload(path, vo.getImageFile(), request);
			EventImageVO fileVO = new EventImageVO();
			fileVO.setFile_name(fileName);
			fileVO.setPr(0);
			fileList.add(fileVO);
		}

		// 업로드 된 정보 출력
		System.out.println(fileList);

		// DB 처리
		service.write(vo, fileList);

		// 파일의 저장되는 시간이 있으므로 멈춤 시간을 조금 준다. - 0.5초
		Thread.sleep(1000);

		// 처리 결과를 리스트로 보낸다.
		rttr.addFlashAttribute("msg", "일반게시판 글등록이 되었습니다.");
		// 이동 URL 정보: 앞에 "redirect:"을 붙여야 합니다.
		return "redirect:list.do?perPageNum=" + perPageNum;
	}

	@GetMapping("/update.do")
	public String update(Long no, EventVO vo, Model model) throws Exception {
		System.out.println("eventController.update() 글수정 폼");
		model.addAttribute("vo", service.view(no));
		model.addAttribute("imageList", service.getImageFile(no));
		return "event/eventUpdate";
	}

	@PostMapping("/update.do")
	public String update(EventVO vo, Long preImg_no, Long image_no, MultipartFile changePreImg,
			MultipartFile changeDetailImg, String delPreFile, String delFile, String prefileName, String imageName,
			PageObject pageObject, HttpSession session, HttpServletRequest request, RedirectAttributes rttr)
			throws Exception {
		System.out.println("eventController.update() 처리");
		System.out.println("vo: " + vo);
		System.out.println("preImg_no: " + preImg_no);
		System.out.println("image_no: " + image_no);
		System.out.println("changePreImg: " + changePreImg);
		System.out.println("changeDetailImg: " + changeDetailImg);
		System.out.println("prefileName: " + prefileName);
		System.out.println("imageName: " + imageName);
		System.out.println("delPreFile: " + delPreFile);
		System.out.println("delFile: " + delFile);

		vo.setId(((LoginVO) session.getAttribute("login")).getId());

		// DB event게시판 수정
		Integer dbUpdate = service.update(vo);

		// 이미지 수정
		if (dbUpdate == 1) {
			// 메인이미지
			if (!changePreImg.isEmpty()) {
				// 변경된 이미지 파일 업로드
				String fileName = FileUtil.upload(path, changePreImg, request);
				EventImageVO changeVO = new EventImageVO();
				changeVO.setImage_no(preImg_no);
				changeVO.setFile_name(fileName);
				Integer result = service.changeImage(changeVO);

				if (result == 1) {
					// 기존에 이미지 서버 삭제.
					FileUtil.remove(FileUtil.getRealPath("", delPreFile, request));
				}
			}

			// 상세이미지
			if (!changeDetailImg.isEmpty()) {
				if (delFile != null && image_no != null) {
					System.out.println("상세이미지 있는경우");
					String fileName = FileUtil.upload(path, changeDetailImg, request);
					EventImageVO changeVO = new EventImageVO();
					changeVO.setImage_no(image_no);
					changeVO.setFile_name(fileName);
					Integer result = service.changeImage(changeVO);
					// 삭제처리
					if (result == 1) {
						FileUtil.remove(FileUtil.getRealPath("", delFile, request));
						rttr.addFlashAttribute("msg", "상세 이미지 수정 및 등록 완료");
					} else {
						rttr.addFlashAttribute("msg", "상세 이미지 수정 및 등록 실패");
					}
				} else {
					System.out.println("상세이미지 없는경우");
					String fileName = FileUtil.upload(path, changeDetailImg, request);

					EventImageVO detailVO = new EventImageVO();
					detailVO.setNo(vo.getNo());
					detailVO.setFile_name(fileName);
					detailVO.setPr(0);
					Integer result = service.detailImageWrite(detailVO);

					if (result == 1) {
						rttr.addFlashAttribute("msg", "상세 이미지 등록 완료");
					} else {
						rttr.addFlashAttribute("msg", "상세 이미지 등록 실패");
					}
				}
			}
			
			if (changeDetailImg.isEmpty() && delFile != null && image_no != null) {
				Integer result = service.deleteImage(image_no, vo.getId());
				if (result == 1)
					// 상세 이미지가 있다가 삭제처리하고 새로운 이미지 업로드 없이 수정 한 경우
					FileUtil.remove(FileUtil.getRealPath("", delFile, request));
			}
			Thread.sleep(500);
		} else {
			rttr.addFlashAttribute("msg", "이벤트 게시판 수정 실패");
		}

		return "redirect:view.do?no=" + vo.getNo() + "&" + pageObject.getPageQuery();
	}

	@GetMapping("/delete.do")
	public String delete(EventVO vo, Long perPageNum, HttpSession session, HttpServletRequest request,
			RedirectAttributes rttr) throws Exception {
		System.out.println("EventController.delete().vo" + vo);

		vo.setId(((LoginVO) session.getAttribute("login")).getId());

		// image 데이터가 삭제 되기 전에 imageFile 데이터들을 꺼내서 가지고 있어야 파일을 지울 수 있다.
		List<EventImageVO> fileList = service.getImageFile(vo.getNo());

		System.out.println("EventController.delete().fileList" + fileList);
		// DB에 image 테이블 글 삭제 -> imageFile 테이블의 같은 글 이미지 데이터들이 삭제 된다.
		Integer result = service.delete(vo);

		if (result == 1) {
			// 가지고 있는 파일을 서버에서 지운다.
			for (EventImageVO fileVO : fileList) {
				// FileUtil.remove(파일시스템의 절대 주소)
				FileUtil.remove(FileUtil.getRealPath("", fileVO.getFile_name(), request));

			}
			rttr.addFlashAttribute("msg", "이벤트 게시판(글번호:" + vo.getNo() + ")글삭제가 완료되었습니다.");
		} else {
			// modal 창에서 줄바꿈은<br>로 한다. alert에서 줄 바꿈은 \n으로 한다.
			rttr.addFlashAttribute("msg",
					"이벤트게시판(글번호:" + vo.getNo() + ")글삭제가 실패했습니다." + "<br>본인의 글이 아니거나 글이 존재하지 않습니다.");
		}
		return "redirect:list.do?perPageNum=" + perPageNum;
	}

}
