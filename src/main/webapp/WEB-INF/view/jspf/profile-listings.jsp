<div class="uk-card uk-card-muted uk-card-small uk-card-body">
	<div class="uk-align-center" style="margin-bottom: -5%;" uk-lightbox>
		<a
			href="${pageContext.request.contextPath}/resources/img/listings/${listing.image_path}"
			title="Image" class="thumbnail"><img height="auto" width="100"
			src="${pageContext.request.contextPath}/resources/img/listings/${listing.image_path}"
			alt="Listing" /></a>
	</div>
	<div class="name" style="font-size: 22px;">

		<a href="#"><strong class="uk-text-danger">${listing.name}</strong></a>
		<c:if test="${listing.user.getUserID() != sessionScope.user.userID }">
			<div
				class="watch-item color1 uk-position-medium uk-position-top-right"
				id="${listing.id}">
				<a uk-icon="icon: star; ratio: 1"></a>
			</div>
			<div
				class="watch-item color2 uk-position-medium uk-position-top-right"
				id="${listing.id}" style="display: none;">
				<a uk-icon="icon: star; ratio: 2"></a>
			</div>
		</c:if>
	</div>

	<c:choose>
		<c:when test="${listing.type == 'auction'}">
			<div class="price" style="font-size: 16px;">
				<span class="uk-badge">Current Bid: $${listing.highestBid}</span>

				<c:if test="${listing.user.userID != user.userID}">
					<a class="uk-button uk-button-text"
						style="color: cornflowerblue; margin-left: 5px"
						uk-toggle="target: #placeBidModal${listing.id}"
						id="bidButton${listing.id}">Place Bid</a>
				</c:if>
				<c:if test="${listing.highestBidder.userID == user.userID}">
					<a title="Cancel Bid" uk-icon="icon: ban"
						uk-toggle="target: #cancelBid${listing.id}Modal"
						style="margin-left: 10px; color: red;"></a>
				</c:if>
			</div>
			<hr>
			<div style="margin-left: 8%;" id="countdown${listing.id}"
				class="uk-grid-small" uk-grid
				uk-countdown="date: ${listing.endTimestamp}">
				<div>
					<div class="uk-countdown-label uk-text-center uk-visible@s">Days</div>
					<div class="uk-countdown-number uk-countdown-days"></div>
				</div>
				<div>
					<div class="uk-countdown-label uk-text-center uk-visible@s">Hours</div>
					<div class="uk-countdown-number uk-countdown-hours"></div>
				</div>
				<div>
					<div class="uk-countdown-label uk-text-center uk-visible@s">Minutes</div>
					<div class="uk-countdown-number uk-countdown-minutes"></div>
				</div>
				<div>
					<div class="uk-countdown-label uk-text-center uk-visible@s">Seconds</div>
					<div class="uk-countdown-number uk-countdown-seconds"></div>
				</div>
			</div>
		</c:when>
		<c:when test="${listing.type == 'fixed'}">
			<div class="price" style="font-size: 16px;">
				<span class="uk-badge" id="currentBid${listing.id}">Price:
					$${listing.price}</span>

				<c:if test="${listing.user.userID == user.userID}">

					<a class="uk-button uk-button-text"
						style="margin-left: 5px; color: red;"
						href="${pageContext.request.contextPath}/edit?listing=${listing.id}">Edit</a>

					<button class="uk-button uk-button-default uk-margin-small-right" type="button"
						style="margin-left: 5px; color: green;"
						href="${pageContext.request.contextPath}/myOffers?listing=${listing.id}"
						uk-toggle="target: #offcanvas-overlay">View offers</button>

					<div id="offcanvas-overlay" uk-offcanvas="overlay: true">
						<div class="uk-offcanvas-bar">

							<button class="uk-offcanvas-close" type="button" uk-close></button>

							<!-- For loop -->
							<c:forEach var="offer" items="${offers}">
								<article class="uk-comment">
									<header class="uk-comment-header uk-grid-medium uk-flex-middle"
										uk-grid>
										<div class="uk-width-auto">
											<img class="uk-comment-avatar"
												src="../docs/images/avatar.jpg" width="80" height="80"
												alt="">
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


				</c:if>

			</div>

		</c:when>
	</c:choose>
</div>
<%@include file="../listing/bid-buy-modals.jsp"%>