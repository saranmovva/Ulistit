<div class="uk-overflow-auto">
	<table class="uk-table uk-table-hover uk-table-middle uk-table-divider">
		<thead>
			<tr>
				<th class="uk-table-shrink"></th>
				<th class="uk-table-shrink">Username</th>
				<th class="uk-table-expand">Offer</th>
				<th class="uk-width-small">Listing</th>
				<th class="uk-table-shrink uk-text-nowrap">Status</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><img class="uk-preserve-width uk-border-circle"
					src="${pageContext.request.contextPath}/resources/img/profile-pic/default.jpeg"
					width="40" alt=""></td>
				<td class="uk-text-truncate">${offer.userID.username}</td>
				<td class="uk-table-link"><a class="uk-link-reset" href="">$${offer.offerAmount}: ${offer.offerMessage}</a></td>
				<td class="uk-text-truncate">${offer.listingID.name}</td>
				<td class="uk-text-nowrap">${offer.status}</td>
			</tr>
		</tbody>
	</table>
</div>