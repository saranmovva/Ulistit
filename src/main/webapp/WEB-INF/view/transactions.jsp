<%@include file="jspf/header.jsp"%>
<body>

	<%@include file="jspf/navbar.jspf"%>

	<div class="uk-section">

		<div class="uk-container">

			<c:forEach var="transaction" items="${buyerTransactions}">

				<div>${transaction.id}</div>

			</c:forEach>

		</div>

	</div>

</body>
</html>