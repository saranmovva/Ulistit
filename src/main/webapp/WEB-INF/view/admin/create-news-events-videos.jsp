<div uk-grid>
    <div class="uk-card uk-width-1-3@m">
        <div class="uk-card-small uk-card-default uk-card-hover uk-border-rounded uk-card-body">
            <h3>Events</h3>
            <hr>
            <form method="POST" action="createEvent"
                  enctype="multipart/form-data">
                <fieldset class="uk-fieldset">

                    <strong>Event Title</strong> <input class="uk-input" name="title"
                                                        type="text"
                                                        placeholder="Title" required>
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
                                                          placeholder="End Date" required>
                    </div>
                    <br>
                    <div id="dateEnd">
                        <strong>End Date</strong><input type="datetime-local"
                                                        class="uk-input" id="endDate"
                                                        name="endDate"
                                                        placeholder="End Date" required>
                    </div>
                    <br>
                    <strong>Give a Description</strong>
									<textarea class="uk-textarea" name="description" rows="5"
                                              placeholder="Textarea"></textarea>
                    <br>
                    <br>
                    <button type="submit"
                            class="uk-button uk-width-1-1 uk-margin-small-bottom">Create Event
                    </button>


                </fieldset>
            </form>
        </div>

    </div>
    <div class="uk-card uk-width-1-3@m">
        <div class="uk-card-small uk-card-default uk-card-hover uk-border-rounded uk-card-body">
            <h3>News</h3>
            <hr>
            <form method="POST" action="uploadNews"
                  enctype="multipart/form-data">
                <fieldset class="uk-fieldset">

                    <strong>News Article Title</strong>
                    <input class="uk-input" name="title" type="text" placeholder="Title" required>
                    <br>
                    <br>

                    <strong>Upload News Article:</strong> <input id="doc"
                                                                 type="file" name="doc" required> <span
                        class="val_error"
                        id="image_error"></span>

                    <br>
                    <br>
                    <strong>Upload News Article Image:</strong> <input id="image"
                                                                       type="file" name="image" required> <span
                        class="val_error"
                        id="image_error2"></span>
                    <br>
                    <br>

                    <strong>Description: </strong>
                    <textarea class="uk-textarea" name="description" rows="5"
                              placeholder="Textarea" required></textarea>

                    <br>
                    <br>
                    <button type="submit"
                            class="uk-button uk-width-1-1 uk-margin-small-bottom">Create News
                    </button>
                </fieldset>
            </form>
        </div>
    </div>
    <div class="uk-card uk-width-1-3@m">
        <div class="uk-card-small uk-card-default uk-card-hover uk-border-rounded uk-card-body">
            <h3>Videos</h3>
            <hr>
            <form method="POST" action="uploadVideo"
                  enctype="multipart/form-data">
                <fieldset class="uk-fieldset">

                    <strong>Title: </strong>
                    <input class="uk-input" name="videoTitle" type="text" placeholder="Title">
                    <br>

                    <strong>Youtube URL: </strong>
                    <textarea class="uk-textarea" name="video" rows="5"
                              placeholder="Textarea"></textarea>

                    <br>
                    <br>
                    <button type="submit"
                            class="uk-button uk-width-1-1 uk-margin-small-bottom">Upload Video
                    </button>

                </fieldset>
            </form>
        </div>
    </div>
</div>