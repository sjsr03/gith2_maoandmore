<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<title>오늘의 예산</title>
</head>
<style>
	#popup1 {
		display: flex;
		justify-content: center;
		align-items: center;
		position: fixed;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background: rgba(0, 0, 0, .7);
		z-index: 1;
		backdrop-filter: blur(4px);
 		-webkit-backdrop-filter: blur(4px);
 		display:none;
	}
	#popup1 * {
		padding:5px;
	}
	.popup {
		padding: 20px;
		background: #fff;
		border-radius: 5px;
		box-shadow: 1px 1px 3px rgba(0, 0, 0, .3);
	}
	input[type=number] {
		width:100px;
	}
	#leftMoneyList, tr, td {
		border:1px solid #ccc;
		border-collapse:collapse;
		padding:2px;
	}
</style>


<jsp:include page="../sidebar.jsp"/>
 <!-- Begin Page Content -->
        <div class="container-fluid">

          <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">오늘의 예산</h1>
            </div>
            
           	<!-- 첫번째 줄 -->
           	<div class="row">

            <!-- 예산기간 -->
            <div class="col-xl-6 col-md-8 mb-4">
              <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">예산 기간</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800">
                      <fmt:formatDate value="${TBdto.start_day}" pattern="yyyy년 MM월 dd일"/> ~ 
                      <fmt:formatDate value="${TBdto.end_day}" pattern="yyyy년 MM월 dd일"/> (일)</div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-calendar-check fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            
            <!-- 총예산 금액 -->
            <div class="col-xl-3 col-md-8 mb-4">
              <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">총예산액</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800">
                      <fmt:formatNumber value="${TBdto.budget}" pattern="#,###"/>원</div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-won-sign fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            
            <!-- 현재 사용 예산 -->
            <div class="col-xl-3 col-md-8 mb-4">
              <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">현재 사용 예산</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800">
                      <fmt:formatNumber value="${TBdto.budget-TBdto.current}" pattern="#,###"/>원</div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-won-sign fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            
          </div>
          <!-- 첫줄 끝 -->


			<!-- 두번째줄 -->
			<div class="row">
				<!-- 두번째줄 왼쪽컬럼 -->
				<div class="col-lg-6">
					<div class="card shadow mb-4">
		                <div class="card-header py-3">
		                  <h6 class="m-0 font-weight-bold text-primary">오늘의 예산</h6>
		                </div>
		                <div class="card-body">
		                	총예산 (${TBdto.budget-TBdto.current }/${TBdto.budget })
		                	<div class="progress mb-4">
		                    	<div class="progress-bar" role="progressbar" style="width: ${((TBdto.budget-TBdto.current)/TBdto.budget)*100 }%" aria-valuenow="${TBdto.budget-TBdto.current }" aria-valuemin="0" aria-valuemax="${TBdto.budget }">${((TBdto.budget-TBdto.current)/TBdto.budget)*100 }%</div>
		                 	</div>
		                 	<hr>
		                 	
		                </div>
	               </div>
              </div>
              <!-- 두번째줄 오른쪽컬럼 -->
				<div class="col-lg-6">
					<div class="card shadow mb-4">
		                <div class="card-header py-3">
		                  <h6 class="m-0 font-weight-bold text-primary">예산에서 남은 돈<br/></h6>
							총액 : <span id="totalLeftMoney"></span>원
		                </div>
		                <div class="card-body">
		                	<c:forEach items="${leftMoney}" var="i" >
								<div>
									<span>${categories[i.category_no] }</span> : <span class="amount">${i.amount }</span>원
								</div>
							</c:forEach>
		                 	<hr>
							 <div>
								<button onclick="$('#popup1').css('display','flex')">전환하기</button>
							</div>
		                </div>
	               </div>

				</div>
	<!-- 두번째줄 -->
	</div>	
	
	
	<!-- 남은돈 전환 창 -->
	<div id="popup1">
		<div class="popup">
			<div style="display:inline;text-align:right;"><h2 style="display:inline">남은 돈 전환하기</h2>
			<button onclick="$('#popup1').css('display','none')">X</button></div>
			<form action="/moamore/budget/LeftMoneyTransfer.moa" method="post">
				<div>
					<table id="leftMoneyList">
						<tr>
							<td><!-- 체크박스 -->&nbsp;</td>
							<td>항목</td>
							<td>잔액</td>
							<td>전환할 금액</td>
							<td>전환 후 남은 금액</td>
						</tr>
					<c:forEach items="${leftMoney}" var="i" >
						<tr>
							<td><input type="checkbox" class="chk" name="category" value="${i.category_no}"/></td>
							<td>${categories[i.category_no] }</td>
							<td>${i.amount }</td>
							<td><input type="number" class="inputAmount" name="inputAmount" value="0" max="${i.amount}" min="0"/></td>
							<td><input type="number" readonly class="LeftAfterTrans" value="${i.amount }"/></td>
						</tr>
					</c:forEach>
						<tr>
							<td colspan="5">전환할 총 금액 : <span id="transSum">0</span>원</td>
						</tr>
					</table>
					<div style="display:inline-block">
						<label><input type="radio" name="target_table" value="budget" checked/>현재예산에 재분배</label>
						<br/>
						<label><input type="radio" name="target_table" value="goals" />목표로 보내기</label>
					</div>
					<div style="display:inline-block; width:300px; height:50px; border:1px solid #ccc">
						<div id="subCat">
							재분배할 카테고리
							<select id="targetCat" name="subSel">
								<c:forEach items="${BDdtoList }" var="j">
									<option value=${j.category_no } class="${categories[j.category_no] }">${categories[j.category_no] }</option>
								</c:forEach>
							</select>
						</div>
						<div id="subGoal" style="display:none;">
							목표 선택
							<select id="targetGoal" name="subSel">
								<c:if test="${goals==null }" >
									<option disabled>목표가 없습니다</option>
								</c:if>
								<c:forEach items="${goals }" var="j">
									<option value=${j.goal_no } class="${j.subject }">${j.subject }</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div>
						<input type="button" id="trans" value="전환하기">
					</div>
				</div>
				</form>
		</div>
	</div>
	
	</div>
	
	<jsp:include page="../footer.jsp" />
  
<script>
	$(document).ready(function(){
		//남은 돈 총합 계산
		calSumFirst();

		
		//분배금액 입력될때마다
		$('.inputAmount').on('keyup', function(){
			//총금액을 넘지 않는지, 음수는 아닌지 계산
			testAmount($(this));
			
			//총합 계산
			calSumTrans();
			//남은금액 계산
			calRest($(this));
		});
		
		
		
		//체크될때마다
		$('.chk').on('change',function(){
			//총합 계산
			calSumTrans();
		});
		
		
		
		//타겟테이블이 선택될때마다
		$('input:radio').on('change', function(){
			//하위 셀렉트박스 출력
			printSubSelect();
		});
		
		
		
		
		//전환하기 누르면 확인창 출력 후 submit
		$('#trans').on('click', function(){
			//0원인지부터 확인
			if($('#transSum').text() == "0") {
				alert('전환할 금액을 입력하세요');
				return;
			}
			
			var target_table = $('input:radio:checked').val();
			var subSelect = "<";
			if(target_table == "budget") {
				subSelect += $('#targetCat').children(':selected').attr('class');
				subSelect += "> 카테고리";
			} else {
				subSelect += $('#targetGoal').children(':selected').attr('class');
				subSelect += "> 목표";
			}
			var ans = confirm("총 " + $('#transSum').text() + "원을 " + subSelect + "로 전환합니다");			
			if(ans == true) {
				$('.chk').each(function(){
					if($(this).is(':checked')==false) {
						$(this).parent().next().next().next().children('.inputAmount').prop('name', '');
					}
				});
				$('#trans').attr('type', 'submit');
			}
		});
	});
	
	
	
	//남은돈 총합 계산하기(페이지 불러올 때 한 번)
	function calSumFirst() {
		var sum = 0;
		
		$('.amount').each(function(){
			sum += parseInt($(this).text());
		});
		
		$('#totalLeftMoney').text(sum);
	}
	
	
	//보낼 타겟 체크할때마다 하위 셀렉트박스 출력
	function printSubSelect() {
		var target = $('input:radio:checked').val();
		
		if(target == 'budget') {
			$('#subGoal').css('display','none');
			$('#subCat').css('display','flex');
		} else {
			$('#subCat').css('display','none');
			$('#subGoal').css('display','flex');
		}
	}
	
	
	//전환할 총 금액 합산
	function calSumTrans() {
		var sum = 0;
		//체크된 것들만
		$('.chk').each(function(){
			if($(this).is(':checked')) {
				var inputAmount = $(this).parent().next().next().next().children('.inputAmount').val();
				if(inputAmount=="") {
					sum += 0;
				} else {
					sum += parseInt(inputAmount);
				}
			}
		});
		
		$('#transSum').text(sum);
	}
	
	//입력된 값이 최대값을 넘지 않는지, 음수는 아닌지 계산
	function testAmount(inputAmount) {
		var Ori = parseInt(inputAmount.parent().prev().text());
		if(Ori < inputAmount.val()) {
			alert("잔액을 초과할 수 없습니다.");
			var num = Math.floor(inputAmount.val()/10);
			inputAmount.val(num);
		}
		
	}
	
	
	
	
	
	//전환 후 남은 금액 자동계산
	function calRest(inputAmount) {
		var rest = 0;
		var Ori = parseInt(inputAmount.parent().prev().text());
		if(inputAmount.val()=="") {
			rest = Ori;
		} else {
			rest = Ori - parseInt(inputAmount.val());
		}
		inputAmount.parent().next().children('.LeftAfterTrans').val(rest);
	}
</script>
