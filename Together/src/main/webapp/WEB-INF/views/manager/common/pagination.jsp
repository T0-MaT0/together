<ul id="pagination">
    <li><a href="${urlCp}1">&lt;&lt;</a></li>
    <li><a href="${urlCp}${pagination.prevPage}">&lt;</a></li>
    
        <c:forEach var="i" begin="${pagination.startPage}" end="${pagination.endPage}">
            <c:choose>
                <c:when test="${pagination.currentPage == i}">
                    <!-- 현재 페이지인 경우 -->
                    <li class="curr">${i}</li>
                </c:when>

                <c:otherwise>
                    <!-- 현재 페이지가 아닌 경우 -->
                    <li><a href="${urlCp}${i}">${i}</a></li>
                </c:otherwise>
            </c:choose>
        </c:forEach>                
    
    <li><a href="${urlCp}${pagination.nextPage}">&gt;</a></li>
    <li><a href="${urlCp}${pagination.maxPage}">&gt;&gt;</a></li>
</ul>