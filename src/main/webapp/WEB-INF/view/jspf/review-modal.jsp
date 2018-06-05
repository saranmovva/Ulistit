<!-- This is the modal -->
<div id="reviewModal${review.id}" uk-modal>
	<div class="uk-modal-dialog uk-modal-body">
		<h2 class="uk-modal-title">Review User</h2>
		<p>
		<div id="form">
			<form id="form" name="review" action="leaveReview" class="uk-form"
				method="POST">
				<div class="uk-margin uk-position-center">
					<div class="uk-margin">
						<input class="uk-input" type="text" placeholder="Full Name"
							required>
					</div>
					<div class="uk-margin">
						<input class="uk-input" type="email" placeholder="Email" required>
					</div>
					<div class="uk-margin">
						<form action="">
							<input type="radio" name="rating" value="1"> 1<br> <input
								type="radio" name="rating" value="2"> 2<br> <input
								type="radio" name="rating" value="3"> 3 <input
								type="radio" name="rating" value="4"> 4 <input
								type="radio" name="rating" value="5"> 5
						</form>
					</div>
					<div class="uk-margin">
						<input class="uk-input" type="text" placeholder="Review" required>
					</div>
					<div id="mail-status"></div>
					<input type="submit" name="submit" value="Send Message"
						id="send-message" style="clear: both;">
				</div>
			</form>
			<p class="uk-text-right">
				<button class="uk-button uk-button-default uk-modal-close"
					type="button">Cancel</button>
				<button class="uk-button uk-button-primary" type="button">Buy</button>
			</p>
		</div>
	</div>
</div>