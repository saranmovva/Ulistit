<div class="uk-card-header">
    <div class="uk-grid-small uk-flex-middle" uk-grid>
        <div class="uk-inline">
            <a class="uk-preserve" type="button">
                <img alt="filter" class="uk-preserve"
                     src="${pageContext.request.contextPath}/resources/icons/filter-list-icon.svg"
                     width="25" height="auto" uk-svg>
            </a>
            <div uk-dropdown="mode: click">
                <ul class="uk-nav uk-dropdown-nav">
                    <li class="uk-active"><a href="#">Active</a></li>
                    <li><a href="#">Pending</a></li>
                    <li><a href="#">In progress</a></li>
                    <li><a href="#">Completed</a></li>
                    <li><a href="#">Cancelled</a></li>
                    <li><a href="#">Newest to oldest</a></li>
                    <li><a href="#">Oldest to newest</a></li>
                </ul>
            </div>
        </div>
        <h3 class="uk-card-title uk-text-center">Pickups</h3>
        <div class="uk-float-right uk-margin-auto-left">
            <div><i class="far fa-question-circle"></i></div>
            <div class="uk-width-large" uk-dropdown>
                <div class="uk-dropdown-grid uk-child-width-1-2@m" uk-grid>
                    <div>
                        <ul class="uk-nav uk-dropdown-nav">
                            <li class="uk-nav-header">What is a pickup?</li>
                            <li>Pickup definition:</li>
                            <li>The act of collecting a good or goods.</li>
                            <li class="uk-nav-divider"></li>

                            <li class="uk-nav-header">What do the headers mean?</li>
                            <li>User:</li>
                            <li>Person meeting with you at the pickup location.</li>
                            <li class="uk-nav-divider"></li>

                            <li>Time:</li>
                            <li>Scheduled period that was agreed upon for the pickup.</li>
                            <li class="uk-nav-divider"></li>

                            <li>Location:</li>
                            <li>Area or building that was agreed upon for the pickup.</li>
                        </ul>
                    </div>
                    <div>
                        <ul class="uk-nav uk-dropdown-nav">

                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>