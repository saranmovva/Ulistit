<table class="uk-table uk-table-hover uk-table-divider">
    <thead>
    <tr>
        <th>Title</th>
        <th>Location</th>
        <th>Start Date</th>
        <th>End Date</th>
        <th>Active</th>
        <th>Edit</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="event" items="${events}" varStatus="loop">
        <tr>
            <td>${event.title}</td>
            <td>${event.location}</td>
            <td>${event.startTime.toString()}</td>
            <td>${event.endTime.toString()}</td>
            <td>${event.active}</td>
            <td><a uk-icon="icon:  file-edit; ratio: 1" href="#modal-sections" uk-toggle></a>

                <div id="modal-sections" uk-modal>
                    <div class="uk-modal-dialog">
                        <button class="uk-modal-close-default" type="button" uk-close></button>
                        <div class="uk-modal-header">
                            <h2 class="uk-modal-title">Edit ${event.title}</h2>
                        </div>
                        <div class="uk-modal-body">
                            <div class="uk-container">
                                <div class="uk-card-small uk-card-default uk-card-hover uk-border-rounded uk-card-body">
                                    <h3>Events</h3>
                                    <hr>
                                    <form method="POST" action="editEvent"
                                          enctype="multipart/form-data">
                                        <input class="uk-input" name="eventId"
                                               type="hidden"
                                               value="${event.eventId}">
                                        <fieldset class="uk-fieldset">
                                            <strong>Event Title</strong> <input class="uk-input" name="title"
                                                                                type="text"
                                                                                value="${event.title}" required>
                                            <br>
                                            <br>
                                            <strong>Choose A Location</strong><select class="uk-select"
                                                                                      name="location" required>
                                            <option value="birck">Birck Hall of Science</option>
                                            <option value="field">Football/Soccer Field</option>
                                            <option value="goodwin">Goodwin Hall of Business</option>
                                            <option value="krasa">Krasa Student Center</option>
                                            <option value="rice">Rice Center</option>
                                            <option value="abbey">St. Precopious Abbey</option>
                                            <option value="scholl">Scholl Hall</option>
                                        </select>
                                            <br>
                                            <br>
                                            <div id="dateStart">
                                                <strong>Start Date</strong><input type="datetime-local"
                                                                                  class="uk-input" id="startDate"
                                                                                  name="startDate"
                                                                                  value="${startTime.get(loop.index)}"
                                                                                  required>
                                            </div>
                                            <br>
                                            <div id="dateEnd">
                                                <strong>End Date</strong><input type="datetime-local"
                                                                                class="uk-input" id="endDate"
                                                                                name="endDate"
                                                                                value="${endTime.get(loop.index)}"
                                                                                required>
                                            </div>
                                            <br>
                                            <strong>Give a Description</strong>
                                            <textarea class="uk-textarea" name="description" rows="5"
                                                ${event.description}></textarea>
                                            <br>
                                            <br>
                                            <button type="submit"
                                                    class="uk-button uk-width-1-1 uk-margin-small-bottom">Edit Event
                                            </button>


                                        </fieldset>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </td>

        </tr>
    </c:forEach>

    </tbody>
</table>
