package calendar.controller.bean;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import calendar.service.bean.CalendarService;



@Controller
@RequestMapping("/calendar/")
public class CalendarBean {

	
	@Autowired
	private CalendarService calendarService = null;
	
	@RequestMapping("calendar.moa")
	public String calendar(Model model) throws SQLException{
		
		String id=(String)RequestContextHolder.getRequestAttributes().getAttribute("memId", RequestAttributes.SCOPE_SESSION);

		//budget의 날짜와 총 지출액 map 형태로 받아오기 
		Map budgetDateAndAmount = calendarService.selectBudgetDateAndAmount(id);
		
		
		model.addAttribute("budgetDateAndAmount", budgetDateAndAmount);
	
		
		return "calendar/calendar";
	}
	
	
	
	
	
	
	
	
}