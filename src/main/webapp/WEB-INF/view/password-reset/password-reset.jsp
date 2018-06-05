<%@ include file="../jspf/header.jsp" %>

<body>

<%@ include file="../jspf/navbar.jspf" %>

<div class="row">
    <div
            class="col-xs-12 col-sm-8 col-md-6 col-sm-offset-2 col-md-offset-3">

        <%@ include file="../jspf/messages.jsp" %>

        <form role="form" data-toggle="validator"
              method="post" action="${pageContext.request.contextPath}/reset" style="margin-top: 45px;">
            <h2>Reset Password</h2>
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-12">
                    <div class="form-group">
                        <div class="input-group" data-validate="email">
                            <input type="email" name="email" path="email" id="email"
                                   class="form-control input-lg" placeholder="Email Address"
                                   tabindex="1" data-minlength="2" data-minlength="30" required>
                            <span class="input-group-addon danger"><span
                                    class="glyphicon glyphicon-remove"></span></span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12 col-sm-6 col-md-6">
                    <div class="form-group has-feedback">
                        <label class="input-group">
                            <span class="input-group-addon">
                                <input type="radio" name="emailType" id="personal" value="personal"/>
                            </span>
                            <div class="form-control form-control-static">
                                Personal Email Address
                            </div>
                            <span class="glyphicon form-control-feedback "></span>
                        </label>
                    </div>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-6">
                    <div class="form-group has-feedback">
                        <label class="input-group">
                            <span class="input-group-addon">
                                <input type="radio" name="emailType" id="school" value="school"/>
                            </span>
                            <div class="form-control form-control-static">
                                School Email Address
                            </div>
                            <span class="glyphicon form-control-feedback "></span>
                        </label>
                    </div>
                </div>
            </div>
            <br>
            <div class="row">
                <div class="col-xs-12 col-md-12">
                    <button class="btn btn-success btn-block btn-lg">Continue</button>
                </div>
            </div>
            <input type="hidden" name="action" value="reset">
        </form>
    </div>
</div>

<script>
    $(document).ready(function () {
        $('.input-group input[required], .input-group textarea[required], .input-group select[required]').on('keyup change', function () {
            var $form = $(this).closest('form'),
                $group = $(this).closest('.input-group'),
                $addon = $group.find('.input-group-addon'),
                $icon = $addon.find('span'),
                state = false;

            if (!$group.data('validate')) {
                state = $(this).val() ? true : false;
            } else if ($group.data('validate') == "email") {
                state = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.test($(this).val())
            }

            if (state) {
                $addon.removeClass('danger');
                $addon.addClass('success');
                $icon.attr('class', 'glyphicon glyphicon-ok');
            } else {
                $addon.removeClass('success');
                $addon.addClass('danger');
                $icon.attr('class', 'glyphicon glyphicon-remove');
            }

            if ($form.find('.input-group-addon.danger').length == 0) {
                $form.find('[type="submit"]').prop('disabled', false);
            } else {
                $form.find('[type="submit"]').prop('disabled', true);
            }
        });

        $('.input-group input[required], .input-group textarea[required], .input-group select[required]').trigger('change');


    });
</script>

</body>
</html>