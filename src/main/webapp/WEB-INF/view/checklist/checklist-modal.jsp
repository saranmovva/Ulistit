<button id="modalButton" style="display: none;" uk-toggle="target: #checkListModal" type="button"></button>

<div id="checkListModal" class="uk-modal-container" uk-modal>
    <div class="uk-modal-dialog uk-modal-body uk-border-rounded uk-text-large uk-grid-small"
         style="background-image: url(
         ${pageContext.request.contextPath}/resources/img/checklist-background.jpg); color: white;" uk-grid>
        <button class="uk-modal-close uk-position-large uk-position-top-right" style="color: white;" type="button"
                uk-close></button>
        <div class="uk-text-center uk-width-1-1" style="color: white;"><h1>Welcome to U-ListIt!</h1></div>
        <div class="uk-margin uk-width-1-2" style="font-size: 20px;">
            <p>College is an exciting time!</p>
            <br>
            <p>To make your life a little bit easier, we have created a <i>checklist</i> of essential items college
                students
                frequently buy.</p>
            <p><i>Click below</i> to create a personal <i>checklist</i> to keep track of things you have bought and
                still need to
                buy.</p>
            <br>
            <p>Happy Shopping!</p>
            <br>
            <br>
            <a style="color: white;"
                    class="uk-button-large uk-button-secondary uk-float-left uk-border-rounded" href="/checklist">Start A
                Checklist
            </a>
        </div>
    </div>
</div>

<script>
    function freshmanChecklistModal(newUser) {

        if (newUser == true) {
            setTimeout(function () {
                $('#modalButton').click();
            }, 1500);
        }
    }
</script>