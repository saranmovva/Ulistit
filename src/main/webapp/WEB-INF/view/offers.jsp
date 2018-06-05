<div id="offcanvas-overlay" uk-offcanvas="overlay: true">
	<div class="uk-offcanvas-bar">

		<button class="uk-offcanvas-close" type="button" uk-close></button>

		<!-- For loop -->
		<c:forEach var="offer" items="${offers}">
			<article class="uk-comment">
				<header class="uk-comment-header uk-grid-medium uk-flex-middle"
					uk-grid>
					<div class="uk-width-auto">
						<img class="uk-comment-avatar" src="../docs/images/avatar.jpg"
							width="80" height="80" alt="">
					</div>
					<div class="uk-width-expand">
						<h4 class="uk-comment-title uk-margin-remove">
							<a class="uk-link-reset" href="#">${offer.userID.username}</a>
						</h4>
						<ul
							class="uk-comment-meta uk-subnav uk-subnav-divider uk-margin-remove-top">
							<li>${offer.dateCreated}</li>
							<li><a
								href="${pageContext.request.contextPath}/acceptOffer?offererID=${offer.userID.userID}&listing=${offer.listingID.id}"
								style="color: green;">Accept</a><span
								class="uk-margin-small-right" uk-icon="check"></span></li>
							<li><a
								href="${pageContext.request.contextPath}/rejectOffer?offererID=${offer.userID.userID}&listing=${offer.listingID.id}"
								style="color: red;">Reject</a><span
								class="uk-margin-small-right" uk-icon="close"></span></li>
						</ul>
					</div>
				</header>
				<div class="uk-comment-body">
					<c:out value="${offer.offerMessage}" />
				</div>
				<hr>
			</article>
		</c:forEach>
		<!-- End for loop -->
	</div>
</div>