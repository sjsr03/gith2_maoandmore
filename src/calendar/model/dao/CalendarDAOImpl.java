package calendar.model.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;




public class CalendarDAOImpl implements CalendarDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSession = null;
	
	//id로 버겟 테이블에 데이터가 있는 날짜 가져오기
	@Override
	public List selectBudgetDatebyId(String id) throws SQLException {
		
		List budget = sqlSession.selectList("calendar.selectBudgetDatebyId",id);
		
		return budget;
	}

	@Override
	public List selectBudgetAmount(String id, List budgetAlldate) throws SQLException {
		
		
			Map map = new HashMap();
			map.put("id", id);
			map.put("budgetAlldate", budgetAlldate);
			
			
			
			List Allamount = sqlSession.selectList("calendar.selectBudgetAmountBydate",map);
			
			return Allamount;
		
	}

	@Override
	public List selectNoBudgetDatebyId(String id) throws SQLException {
		
		List noBudget = sqlSession.selectList("calendar.selectNoBudgetDatebyId",id);
		
		return noBudget;
		
		
		
	}

	@Override
	public List selectNoBudgetExpenseAmount(String id, List nobudgetAlldate) throws SQLException {
		
		Map map = new HashMap();
		map.put("id", id);
		map.put("nobudgetAlldate", nobudgetAlldate);
		
		
		
		List AllNobudgetExpenseAmount = sqlSession.selectList("calendar.selectNoBudgetExpenseAmountBydate",map);
		
		
		return AllNobudgetExpenseAmount;
	}

	@Override
	public List selectNoBudgetIncomeAmount(String id, List nobudgetAlldate) throws SQLException {


		Map map = new HashMap();
		map.put("id", id);
		map.put("nobudgetAlldate", nobudgetAlldate);
		
		
		
		List AllNobudgetIncomeAmount = sqlSession.selectList("calendar.selectNoBudgetIncomeAmountBydate",map);
		System.out.println(AllNobudgetIncomeAmount);
		
		return AllNobudgetIncomeAmount;
	}
	
	

	
	
}