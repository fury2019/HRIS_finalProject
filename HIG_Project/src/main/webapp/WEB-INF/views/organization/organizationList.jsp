<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<security:authentication property="principal" var="principal" />
  <title>조직도</title>
  <!-- FancyTree 스타일과 라이브러리 (glyph extension을 이용하려면 Font Awesome CSS 필요) -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/jquery.fancytree/dist/skin-win8/ui.fancytree.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/jquery.fancytree/dist/jquery.fancytree-all-deps.min.js"></script>
  <!-- chart.js -->
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
  <script src="/resources/js/organization/organization.js" defer></script>
<!-- 별도의 CSS -->
<style>
	/* CSS 추가 */

  /* 전역 박스 사이징 */
  *, *:before, *:after {
    box-sizing: border-box;
  }

  body {
    margin: 0;
    padding: 0;
    font-family: sans-serif;
  }



  .page-header-bar {
    margin-top: -50px !important;
    padding: 10px 20px;
  }

  .button-container {
    position: absolute;
    top: 100px;
    left: 55%;
    transform: translateX(-50%);
    display: flex;
    justify-content: center;
    gap: 10px;
  }

  /* Wrapper: 페이지 좌우 여백 */
  .wrapper {
    margin: 0 10%;
  }

  /* 카드 컨테이너 */
  .card {
    height: 900px;
    width: 100%;
    max-width: 1400px;
    margin: 10px auto;
  }

  /* 전체 내부 컨테이너 : Flexbox 사용 */
  .container-flex {
    display: flex;
    justify-content: space-between;  /* 자식들(트리, 디테일, 차트)을 양쪽 끝에 배치 */
    align-items: flex-start;
    gap: 20px;
    height: 100%;
    width: 100%;
  }

  /* 트리 영역: 고정 너비, 높이 */
  .orgTree-container {
    width: 300px;
    height: 800px;
    margin-top: 20px;
    margin-left: 20px;
    flex: 0 0 270px;	/* flex 속성으로 고정 크기 지정 */
  }
  /* 차트 영역: 고정 너비 */
#chartContainer {
  flex: 0 0 500px;
  max-width: 500px;
  height: 500px;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
  margin-left: auto; /* 오른쪽으로 고정 */
}

  .scrollable-list {
    border-radius: 12px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    padding: 10px;
    background-color: #fff;
    max-height: 800px;
    display: flex;
    flex-direction: column;
    overflow-y: auto;
  }

  #orgTree {
    flex: 1 1 auto;
    padding: 10px;
    overflow-y: auto;
  }

/* 디테일 페인 */
#detailPane {
  position: flex; /* 절대 위치로 변경 */
  left: 320px; /* 트리 너비(300px) + 간격(20px) */
  top: 20px;
  margin-top: 20px;
  border-radius: 12px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  border: 1px solid #ccc;
  background: #f9f9f9;
  width: 380px;
  padding: 20px;
  z-index: 100; /* 다른 요소 위에 표시 */
  display: none; /* 초기에는 숨김 */
}



  #deptEmpCountChart {
    width: 100%;
    height: 100%;
  }

  /* FancyTree 기본 스타일 커스터마이징 (연결선 제거 등) */
  .fancytree-container.fancytree-treefocus span.fancytree-connector,
  .fancytree-container span.fancytree-connector {
    display: none !important;
  }
  .fancytree-container {
    border: none !important;
  }
  .fancytree-expander {
    border: none !important;
  }
  .fancytree-container:focus,
  .fancytree-node:focus,
  .fancytree-active.fancytree-node {
    outline: none !important;
    box-shadow: none !important;
    border: none !important;
  }

  /* 검색 관련 버튼 스타일 */
  #openToTeamBtn {
    color: white !important;
    background-color: #17a2b8 !important;
    border-color: #17a2b8 !important;
  }

/* body { */
/*   font-size: clamp(14px, 1vw, 16px) !important; */
/* } */

/* h1 { */
/*   font-size: clamp(24px, 5vw, 40px); */
/* } */


.fancytree-title {
  font-size: 16px !important;  /* 기본 사이즈 */
}


 @media (min-width: 1610px) {
   .fancytree-title {
     font-size: 14px !important;
   }
 }

  @media (min-width: 2080px) {
    .fancytree-title {
      font-size: 16px !important;
    }
  .orgTree-container {
    width: 300px;
    flex: 0 0 350px;
  }

  }

  }

.card {
    position: relative; /* 버튼을 절대배치할 기준 컨테이너 */
}

#buttonGroup {
    position: absolute;
    bottom: 20px;
    right: 20px;
}


</style>

<!-- 내용 부분 -->
<div class="wrapper">
  <div class="page-header-bar container-fluid">
    <div style="display: flex; justify-content: space-between; align-items: center;">
      <!-- 뒤로가기 버튼 -->
      <div>
        <button type="button" class="btn btn-outline-secondary" onclick="history.back();">
          <i class="fas fa-arrow-left"></i>
        </button>
      </div>
      <!-- 브레드크럼브 -->
      <nav aria-label="breadcrumb">
        <ol class="breadcrumb mb-0">
          <li class="breadcrumb-item fw-bold text-primary">
            <a href="${pageContext.request.contextPath}/account/login/home">📌 Main</a>
          </li>
          <li class="breadcrumb-item active" aria-current="page">조직도</li>
        </ol>
      </nav>
    </div>
  </div>

  <h1>조직도</h1>

  <div class="button-container">
    <input type="text" id="empSearchInput" placeholder="이름, 팀, 부서 검색" class="form-control" style="width:200px; ">
    <button id="empSearchBtn" class="btn btn-primary">검색</button>
<!--     <button id="openToTeamBtn" class="btn btn-info">팀 열기</button> -->
<!--     <button id="openAllBtn" class="btn btn-success">전체 열기</button> -->
<!--     <button id="collapseAllBtn" class="btn btn-secondary">전체 닫기</button> -->
  </div>

  <div class="card">
    <div class="container-flex">

      <!-- 트리 영역 -->
      <div id="orgTreeContainer" class="orgTree-container">
        <div class="list-group scrollable-list">
          <div id="orgTree"></div>
        </div>
      </div>

      <!-- 디테일 페인 (display: none; → detailPane이 필요 없을 때 제거되어, 트리와 차트가 좌우 끝에 고정) -->
      <div id="detailPane">
        <div style="display: flex; justify-content: space-between; align-items: center;">
          <h2 id="detailTitle" style="margin: 0;">Detail Title</h2>
          <button id="closeDetailBtn" class="btn btn-sm btn-outline-danger">&times;</button>
        </div>
        <div id="detailContent">세부 내용</div>
      </div>

      <!-- 차트 영역 -->
      <div id="chartContainer">
        <canvas id="deptEmpCountChart"></canvas>
      </div>

	<div id="buttonGroup">
	    <a href="${pageContext.request.contextPath}/department/list" class="btn btn-primary">
	        <i class="fas fa-building"></i> 부서목록
	    </a>
	    <a href="${pageContext.request.contextPath}/team/list" class="btn btn-primary me-2">
	        <i class="fas fa-users"></i> 팀목록
	    </a>
	</div>


    </div>
  </div>
</div>


<security:authorize access="hasAnyRole('HR_MANAGER', 'HR_ADMIN')">
    <script>
        var hasHRRole = true;
    </script>
</security:authorize>
<security:authorize access="!hasAnyRole('HR_MANAGER', 'HR_ADMIN')">
    <script>
        var hasHRRole = false;
    </script>
</security:authorize>


  <c:if test="${not empty updateError}">
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            Swal.fire({
                title: "업데이트 실패",
                text: "${updateError}",
                icon: "error",
                confirmButtonText: "확인"
            });
        });
    </script>
</c:if>

<c:if test="${not empty updateSuccess}">
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            Swal.fire({
                title: "업데이트 성공",
                text: "${updateSuccess}",
                icon: "success",
                confirmButtonText: "확인"
            });
        });
    </script>
</c:if>