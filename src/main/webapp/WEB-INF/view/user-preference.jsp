<%@include file="jspf/header.jsp"%>
<body>

	<%@include file="jspf/navbar.jspf"%>

	<div uk-grid>
		<div class="uk-width-1-4"></div>
		<div class="uk-width-1-2">
			<div class="uk-card uk-card-default uk-card-large uk-card-body">
				<ul class="uk-subnav uk-subnav-pill" uk-switcher>
					<li><a href="#">Listings</a></li>
					<li><a href="#">Item</a></li>
					<li><a href="#">Item</a></li>
				</ul>

				<ul class="uk-switcher uk-margin">
					<li>Hello!</li>
					<li>Hello again!</li>
					<li>Bazinga!</li>
				</ul>
			</div>
		</div>
	</div>

</body>
</html>