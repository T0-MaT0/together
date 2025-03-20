<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>


<c:set var="url" value="/manageCustomer/"/>
<c:set var="menuName" value="customer"/> <!-- 사이드 메뉴 설정 -->
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/resources/css/manager-css/manager-common.css" />
    <link rel="stylesheet" href="/resources/css/manager-css/manager-customer.css" />
    <script>
        // 사이드 메뉴 설정
        const menuName = "${menuName}";
    </script>
</head>

<body>

</body>

<main>
    
    <!-- 사이드 메뉴 -->
    <!-- open menu /item 설정 할것 -->
    <jsp:include page="/WEB-INF/views/manager/common/sideMenu.jsp"/>

    <!-- 위쪽 영역 -->
    <header>
        <div class="head-title">
            <div>고객 관리</div>
             <!-- &nbsp; <div> - 대시보드</div> -->
        </div>
    </header>

    <!-- 본문(종앙) -->
    <div id="container-center">


        <!-- 고객 규모 -->
        <section class="item-wrap">
            <div class="cs-item">
                
                <div class="cs-top-title">
                    <div>고객 규모</div> <a href="${url}state">상세 보기 ></a>
                </div>
                
                <div class="cs-top-content">
                    <div  class="ch-number">
                        <div> 총 회원 수</div>
                        <div>${map.customerTotalCount}</div>
                     </div>                   
                     <div  class="ch-number">
                         <div> 신규 가입 수</div>
                         <div>${map.customerNewCount}</div>
                     </div>                   
                     <div  class="ch-number">
                         <div> 회원 탈퇴 수</div>
                         <div>${map.customerOutCount}</div>
                     </div>                   
                     <div  class="ch-number">
                         <div>블랙 리스트</div>
                         <div>${map.customerBlackCount}</div>
                     </div>      
                </div>

            </div>
            <div class="cs-item">
                    <div class="cs-bot-title">
                        고객 상태 리스트
                    </div>
                    <div class="ch-list bottom-line">
                            <div>프로필</div>
                            <div>닉네임</div>
                            <div>이메일</div>
                            <div>상태</div>
                    </div>
                    <c:forEach begin="0" end="4" var="i">
                        <div class="ch-list bottom-line">
                                <img src="/resources/images/image-manager/profile.png" alt="회원 프로필">
                                <div>${map.customerStateList[i].memberNick}</div>
                                <div>${map.customerStateList[i].memberEmail}</div>
                                <div>${map.customerStateList[i].memberDelFl}</div>
                        </div>
                    </c:forEach>
            </div>
        </section>


        <!-- 게시글 규모 -->
        <section class="item-wrap">
            <div class="cs-top-title">
                <div>모집 규모</div> <a href="${url}board">상세 보기 ></a>
            </div>

            <div class="cs-top-content">
                <div  class="ch-number">
                    <div> 총 공구 모집 수</div>
                    <div>${map.GatherTotalCount}</div>
                 </div>                   
                 <div  class="ch-number">
                     <div> 성사된 모집</div>
                     <div>${map.GatherSuccessCount}</div>
                 </div>                   
                 <div  class="ch-number">
                     <div>최소된 모집</div>
                     <div>${map.GatherCancelCount}</div>
                 </div>                   
                 <div  class="ch-number">
                     <div>정지된 모집</div>
                     <div>${map.GatherStopCount}</div>
                 </div>      
            </div>
        </section>

        <!-- 문의 -->
        <section class="item-wrap">
            <div class="cs-top-title">
                <div>문의</div> <a href="${url}question">상세 보기 ></a>
            </div>
            <div class="cs-top-content">
                <div  class="ch-number">
                    <div>총 문의 개수</div>
                    <div>${map.questTotalCount}</div>
                 </div>                   
                 <div  class="ch-number ">
                     <div>미처리 문의</div>
                     <div>${map.questWaitCount}</div>
                 </div>                   
                 <div  class="ch-number">
                     <div>처리 문의</div>
                     <div>${map.questAcceptCount}</div>
                 </div>                   
            </div>
        </section>

        <!-- 신고 -->
        <section class="item-wrap">
            <div class="cs-top-title">
                <div>신고</div> <a href="${url}report">상세 보기 ></a>
            </div>

            <div class="cs-bot-content">
                <!-- 회원용 -->
                <div class="report-item">

                    <div class="wrap-chart">
                        <div class="ch-title">회원</div>
                        <div  class="ch-number bottom-line">
                            <div>미처리 건</div>
                            <div>${map.customerWaitReport}</div>
                        </div>    
                        <div  class="ch-number bottom-line">
                            <div>처리 건</div>
                            <div>${map.customerDoneReport}</div>
                        </div>    
                    </div>

                    <div class="cs-item">
                        <div class="ch-list bottom-line">
                                <div>신고자</div>
                                <div>피신고자</div>
                                <div>신고내용</div>
                                <div>상태</div>
                        </div>
                        <c:forEach items="${map.customerReportFourList}" var="reportList">
                            <div class="ch-list bottom-line">
                                    <div>${reportList.memberNick}</div>
                                    <div>${reportList.reportedUserNick}</div>
                                    <div>${reportList.reportTitle}</div>
                                    <div>${reportList.reportStatus}</div>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <!-- 모집공구용 -->
                <div class="report-item">

                    <div class="wrap-chart">
                        <div class="ch-title">공구 모집글</div>
                        <div  class="ch-number bottom-line">
                            <div>미처리 건</div>
                            <div>${map.gatherWaitReport}</div>
                        </div>    
                        <div  class="ch-number bottom-line">
                            <div>처리 건</div>
                            <div>${map.gatherDoneReport}</div>
                        </div>    
                    </div>

                    <div class="cs-item">
                        <div class="ch-list bottom-line">
                            <div>신고자</div>
                            <div>피신고자</div>
                            <div>신고내용</div>
                            <div>상태</div>
                        </div>
                        <c:forEach items="${map.gatherReportFourList}" var="reportList">
                            <div class="ch-list bottom-line">
                                <div>${reportList.memberNick}</div>
                                <div>${reportList.reportedUserNick}</div>
                                <div>${reportList.reportTitle}</div>
                                <div>${reportList.reportStatus}</div>
                              </div>
                        </c:forEach>
                    </div>
                </div>
            </div>

        </section>
        
    </div>


</main>

</body>

</html>
