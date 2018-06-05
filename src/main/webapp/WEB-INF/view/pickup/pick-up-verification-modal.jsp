<div id="verifyPickUpModal" class="uk-modal" uk-modal>
    <div class="uk-modal-dialog uk-modal-body uk-border-rounded">
        <button class="uk-modal-close uk-position-large uk-position-top-right" type="button"
                uk-close></button>
        <div class="uk-text-center uk-width-1-1"><h1>Verify Your Pick Up</h1></div>

        <div class="uk-grid-small uk-margin-medium" uk-grid style="color: white">

            <a class="uk-width-1-1@s uk-width-expand@m uk-link-heading uk-box-shadow-hover-large uk-tile
            uk-border-rounded uk-padding-small uk-text-center uk-margin-small-left uk-margin-small-right uk-float-left"
               href="/pick-up-confirm?l=${listing.id}" style="height: 250px; background-color: #ADE25D">
                <h3>Pick Up Went Great!</h3>
                <span style="color: white;" uk-icon="icon: check; ratio: 7"></span>
            </a>

            <a class="uk-width-1-1@s uk-width-expand@m uk-link-heading uk-box-shadow-hover-large uk-tile
            uk-border-rounded uk-padding-small uk-text-center uk-margin-small-left uk-margin-small-right"
               href="" style="height: 250px; background-color: #C96567">
                <h3>Shoot, I Missed It!</h3>
                <span style="color: white" uk-icon="icon: warning; ratio: 7"></span>
            </a>

        </div>

    </div>
</div>
