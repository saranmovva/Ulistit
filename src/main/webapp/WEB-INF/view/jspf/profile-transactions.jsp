<div class="uk-overflow-auto">
	<table class="uk-table uk-table-hover uk-table-middle uk-table-divider">
		<thead>
			<tr>
				<th class="uk-table-shrink">Buyer Username</th>
				<th class="uk-table-shrink">Seller Username</th>
				<th class="uk-table-expand">Accepted offer</th>
				<th class="uk-width-small">Listing</th>
				<th class="uk-width-small">Type</th>
				<th class="uk-table-shrink uk-text-nowrap">Status</th>
			</tr>
		</thead>
		<tbody>
			<tr>

				<td class="uk-text-truncate">${transaction.offerID.userID.username}</td>

				<td class="uk-text-truncate">${transaction.listingID.user.username}</td>

				<td class="uk-table-link"><a class="uk-link-reset" href="">$${transaction.offerID.offerAmount}:${transaction.offerID.offerMessage}</a></td>
				<td class="uk-text-truncate">${transaction.listingID.name}</td>
				<td class="uk-text-truncate">Sale or Purchase</td>
				<c:if test="${transaction.completed == 0}">
					<td class="uk-text-nowrap">Incomplete</td>
				</c:if>
				<c:if test="${transaction.completed == 1}">
					<td class="uk-text-nowrap">Complete</td>
				</c:if>
			</tr>
		</tbody>
	</table>
</div>