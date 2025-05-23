/** 
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      			수정자           수정내용
 *  -----------   	-------------    ---------------------------
 * 2025. 4. 12.     	정태우            최초 생성
 *
 * </pre>
 */
document.addEventListener("DOMContentLoaded", () => {
  console.log(" accountFind.js 로딩됨");

  const modalElement = document.getElementById("descModal2");

  modalElement.addEventListener("show.bs.modal", () => {
      const modalBody = modalElement.querySelector(".modal-body");
      if (!modalBody) return;
	  let html = `
	  <div class="card">
	    <div class="card-body">
	      <p class="mb-3">
	        당사 연차 발생 기준은 <strong>근로기준법</strong>에 따라 아래와 같이 운영됩니다. 연차는 입사일 기준으로 산정되며, 매년 1월 또는 입사기준일에 부여됩니다.
	      </p>
	      <table class="table table-bordered table-striped text-center align-middle">
	        <thead class="table-light">
	          <tr>
	            <th>근속 기간</th>
	            <th>연차 발생 기준</th>
	            <th>비고</th>
	          </tr>
	        </thead>
	        <tbody>
	          <tr>
	            <td>1년 미만</td>
	            <td>매월 1개씩 발생 (최대 11일)</td>
	            <td>월 개근 시 발생</td>
	          </tr>
	          <tr>
	            <td>1년 이상 ~ 3년 미만</td>
	            <td>연 15일 부여</td>
	            <td>법정 기준 15일에서 사용된 월차 제외</td>
	          </tr>
	          <tr>
	            <td>3년차</td>
	            <td>연 15일 부여</td>
	            <td></td>
	          </tr>
	          <tr>
	            <td>5년차</td>
	            <td>연 16일</td>
	            <td>2년마다 1일씩 증가</td>
	          </tr>
	          <tr>
	            <td>7년차</td>
	            <td>연 17일</td>
	            <td></td>
	          </tr>
	          <tr>
	            <td>…</td>
	            <td>…</td>
	            <td></td>
	          </tr>
	          <tr>
	            <td>최대</td>
	            <td>연 25일</td>
	            <td>최대 발생량</td>
	          </tr>
	        </tbody>
	      </table>
	      <p class="text-muted mt-3 small">
	        ※ 연차는 당해 연도 내 사용을 권장하며, 미사용 시에는 소멸될 수 있습니다.<br>
	        ※ 상세한 사항은 사내 인사팀에 문의 바랍니다.
	      </p>
	    </div>
	  </div>
	  `;
  	
  	modalBody.innerHTML = html;
  	
    });
});
