package budget.controller.bean;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import budget.model.dto.TotalBudgetDTO;
import budget.service.bean.BudgetService;
import category.service.bean.CategoryService;

@Controller
@RequestMapping("/budget/")
public class BudgetBean {

	@Autowired
	private BudgetService budgetService = null;
	
	@Autowired
	private CategoryService categoryService = null;
	
	@RequestMapping("setBudget.moa")
	public String LCsetBudgetForm(HttpServletRequest request, Model model) throws SQLException {
		
		String id = (String) request.getSession().getAttribute("memId");
		
		TotalBudgetDTO currentTBudget = budgetService.selectCurrentOne(id);
		
		//회원의 지출카테고리 불러오기
		List categoryList = categoryService.selectAllById(id);
		
		model.addAttribute("categoryList", categoryList);
		
		
		if(currentTBudget != null) {	//현재 진행중인 예산이 있다면
			model.addAttribute("currentTBudget", currentTBudget);
			model.addAttribute("detailList", budgetService.selectAllbyBudgetNum(currentTBudget.getBudget_no()));
			
			return "budget/modifyBudget";
		} else {	//진행중인 예산이 없다면 
			return "budget/setBudget";
		}
		
	}
	
	@RequestMapping("setBudgetPro.moa")
	public String setBudgetForm() throws SQLException {
		budgetService.setBudget();
		return "main";
	}
}