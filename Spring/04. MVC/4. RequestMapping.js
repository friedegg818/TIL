
- 주소 매핑 관련

   - Controller 파일 
     - @Controller 
	   - 컨트롤러 역할을 하는 클래스에 표기. 객체 자동 생성 
	   - @Controller("id") 부여
	 
	 - @RequestMapping("/user/*") 
	                  (value="/user/request") 
	   - <%=cp%> 이후 주소가 user 로 시작하는 모든 것을 처리 함 
	   - GET , POST 방식 모두 처리 
	   
	 - @GetMapping("request")
	              (value="/user2/request", method=RequestMethod.GET)
	   - get 방식
	 
	 - @PostMapping("request") 
	               (value="/user2/request", method=RequestMethod.POST)
	   - post 방식 
	   
	 - 컨트롤러 리턴 타입
	   1) Model 
	     - jsp 에 넘길 데이터를 담고 있음 
		 	@RequestMapping("/user4/hello")
			 public Model execute() throws Exception {
				Model model = new ExtendedModelMap();
		
				model.addAttribute("result", "model로 리턴 ");		
				return model;
			}
	     
	   2) ModelAndView 
	     - 메소드의 인수명과 request 파라미터의 이름이 동일한 경우 파라미터를 전달 받음 
         - 컨트롤러 처리 결과를 보여 줄 뷰와 뷰에 전달할 값을 저장하는 용도 (req.setAttribute 역할) 
		 - 포워딩할 view 를 가지고 있고, view 에 넘겨줄 데이터를 저장 할 수 있다.
		
			@RequestMapping(value="/user2/request", method=RequestMethod.POST)
				public ModelAndView submit(String name, String tel, int age) {

		
				String s = service.message(age);
		
		
				ModelAndView mav = new ModelAndView("user2/view");	// 생성자의 인수는 뷰 이름
				mav.addObject("name", name);

				return mav;
			}					
						
	   3) void 
	      - view 가 필요 없을 때 사용 
	      - response 를 직접 제어하는 경우나 다운로드 등에서 활용 가능 
		  
			@RequestMapping("/user3/hello")	
				public void execute(HttpServletResponse resp) throws Exception {
				
					resp.setContentType("text/html;charset=utf-8");
		
					PrintWriter out = resp.getWriter();
					out.println("<html><body>");
					out.println("<h3>void 리턴 타입</h3>");
					out.println("</body></html>");
			}
		  
	   4) Map 
	     - Map을 리턴하면 뷰의 이름은 자동으로 주소가 됨 
		 - view 에 전달할 데이터를 넘겨 줄 때 사용 
		 
		   @RequestMapping("/user/hello")
			public Map<String, Object> execute() throws Exception {
				Map<String, Object> model = new HashMap<>();
		
				model.put("result", "결과");		
				return model;
			}
    
       5) ModelMap 	
	   
			@RequestMapping("/user4/hello")
			 public ModelMap execute() throws Exception {
				ModelMap model = new ExtendedModelMap();
				model.addAttribute("result", "ModelMap으로 리턴"); // 뷰에 전달 하는 값 
				return model;
			}
			
		6) String 
		  - 리턴값 : 뷰 이름 
	
	
	
	- 동일한 이름을 가진 parameter 넘겨 받기 
	  1) dto에서는 List로 받기 
			@PostMapping("/user5/request")
				public String submit(User dto, Model model) {
					String s = "이름 : " + dto.getName() + ", 취미 : ";
					if (dto.getHobby() != null) {
						for (String h : dto.getHobby()) {
							s += " " + h;
					}
				}

				model.addAttribute("result", s);

				return "user5/view";
			}
	  
	  
	  2) 배열로 받기 (dto 안쓰는 경우) 
			@PostMapping("/user5/request")
				public String submit(String name, String[] hobby, Model model) {
	
				String s = "이름 :  " + name + ", 취미 : ";
		
				if(hobby!=null) {
					for(String h : hobby) {
						s+=" " + h;
				}
			}
		
				model.addAttribute("result", s);		
		
				return "user5/view";
			}
			
	   3) String 변수로 넘겨 받기
         - 동일한 이름을 가진 파라미터를 하나의 String 변수로 넘겨 받으면 , 로 구분되어서 받을 수 있음 
		 
		 	@PostMapping("/user5/request")
				public String submit(String name, String hobby, Model model) {
		
				String s = "이름 :  " + name + ", 취미 : " + hobby;
		
				model.addAttribute("result", s);		
		
				return "user5/view";
			}
   
    
	- @RequestParam 	
	  - key=value&key=value 형태로 넘어온 파라미터(get방식)를 메소드의 인수에 매핑하기 위해 사용 
	  - 값이 필수로 주어져야 함 → 파라미터가 넘어오지 않으면 400 에러 발생 
	    - (required=false) 입력 시 필수가 아닌 형태로 변경 가능 
		- (defaultValue=" ") 입력 시 기본값 지정 가능 
		- (value="클라이언트 지정 이름") 입력 시 파라미터와 메소드 인수의 이름이 동일하지 않아도 매핑 가능 
		
		   @RequestParam(defaultValue="0") int age, 
		   @RequestParam(value="gender", defaultValue="m") String g	
    
      - List / Map으로 파라미터 넘겨 받기 
	    - @RequestParam 어노테이션 필요 
		- Map의 경우 이름이 동일한 파라미터는 하나만 넘어온다. ※ 주의(이름을 다르게 해주어야 함)
		
		
	
	- @RequestHeader 
	  - 헤더 정보 가져 올 때 사용 
	  - 클라이언트 언어 
	    @RequestHeader("Accept-Language") String lang
	  - 클라이언트 브라우저 및 os 
	    @RequestHeader("User-Agent") String agent
	  
	  * referer(이전주소)는 @RequestHeader로는 확인이 불가능함
	    - String referer = req.getHeader("Referer"); 
	  
	  
	- @CookieValue 
	  - 쿠키 정보 가져오기 
	  - 값이 필수로 주어져야 함 
	   	@CookieValue(value="subject", required=false) String s, Model model)  
	  
      *쿠키 설정 방법 	  
	   	Cookie c = new Cookie("subject", "spring");
		resp.addCookie(c);
	
	
    - @ModelAttribute 
	  1) 메소드의 인수에서 사용하는 경우 
	     - JSP 파일에 반환되는 Model 객체에 속성값을 주입하거나 바인딩 함 
		    public String submit(@ModelAttribute("vo") User dto)  *req.setAttribute("vo", dto) 역할 
	  2) 메소드의 윗 부분에 설정한 경우 
	     - @RequestMapping 보다 먼저 실행 됨 
		 - @RequestMapping이 적용 되지 않는 별도의 메소드에서 모델에 추가 될 객체를 생성 할 때 사용 
		  
		  @ModelAttribute("memberTypes")
		  public List<String> types() throws Exception {
			List<String> list = new ArrayList<String>();
			list.add("일반 회원");
			list.add("기업 회원");
			list.add("관리자");
		
			return list;
		}
   
   
    - Redirect 
	  - 리다이렉트 하기 
	      return "redirect:/test2/error";  *이 경우 Model 값은 넘어가지 않는다.
		  
	  - 리다이렉트 하는 페이지에 값을 보내기 
	    - RedirectAttributes / addFlashAttribute
		  - 한번만 사용 가능 (F5 새로고침 시 사라짐)
		
			public String submit(User dto, RedirectAttributes rattr) {		
	
				rattr.addFlashAttribute("dto", dto);
				rattr.addFlashAttribute("msg", "end..");
		
				return "redirect:/test3/show";                     
			}
			
			* insert/update/delete 후에는 forward 하지 않는다. (DB가 새롭게 업데이트 되므로) 
			
	  - 보내진 값을 넘겨 받기 
	    - 메소드의 인수에 @ModelAttribute 어노테이션 사용 
	  
	  
	  
