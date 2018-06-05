<%@include file="header.jsp"%>
<style>
.uk-countdown-number {
	font-size: 18px;
}

.uk-countdown-label {
	font-size: 10px;
}

.uk-card-media-left img {
	max-height: 100%;
	max-width: 100%;
}
</style>
<body>

	<%@include file="navbar.jspf"%>

	<div style="background-color: #f2f2f2;">

		<div class="uk-section">
			<form method="post" action="editTheListing" name="edit_listing"
				enctype="multipart/form-data">
				<div class="form-group">
					<input name="listingID" type="hidden" class="form-control"
						id="listingID" value="1" readonly>
				</div>
				<div class="form-group">
					<strong>Edit Name</strong> <input type="text" class="form-control"
						id="title" name="title" placeholder="${listing.name}">
				</div>
				<div class="form-group">
					<strong>Edit Image:</strong> <input type="file" name="file">
				</div>
				<div class="form-group">
					<stronge>Edit Category</strong> <select id="category"
						name="category" class="form-control"
						placeholder="${listing.category}">
						<option value="" disabled selected>Select Category</option>
						<option value="apparel">Apparel</option>
						<option value="books">Books</option>
						<option value="furnature">Furniture</option>
						<option value="supplies">School Supplies</option>
						<option value="technology">Technology</option>
					</select>
				</div>
				<div class="form-group">
					<strong>Edit Price: </strong><input type="number"
						class="form-control" id="price" name="price"
						placeholder="${listing.price}">
				</div>

				<div class="form-group">
					<strong> Edit Description: </strong>
					<textarea class="form-control" type="textarea" name="description"
						id="message" placeholder="${listing.description}" maxlength="140"
						rows="7"></textarea>
					<span class="help-block"><p id="characterLeft"
							class="help-block "></span>
				</div>

				<button type="submit" id="submit" name="submit"
					class="btn btn-primary pull-right">Edit Changes</button>
			</form>
		</div>

	</div>

</body>
</html>