<li>
    <div id="currentBidListings"
         class="uk-panel uk-panel-scrollable uk-resize-vertical uk-height-large uk-padding-remove uk-background-muted uk-border-rounded">
        <ul class="uk-nav uk-nav-default uk-child-width-1-3@m uk-grid list" uk-grid="">
            <c:forEach var="listing" items="${currentBidListings}">
                <li class="uk-padding-small">
                    <div
                            class="uk-panel uk-width-auto">
                        <a
                                href="${pageContext.request.contextPath}/listing?listingId=${listing.id}"><img
                                height="auto" width="85%"
                                class="uk-border-rounded uk-box-shadow-hover-large"
                                src="${pageContext.request.contextPath}/resources/img/listings/${listing.images.get(0)}"
                                alt=""></a><a href="edit?listing=${listing.id}"
                                              class="uk-icon-link uk-margin-small-right"
                                              uk-icon="file-edit"></a>
                    </div>
                </li>
            </c:forEach>
        </ul>
    </div>
</li>
