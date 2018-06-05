$(function() {
	$('.button-checkbox')
			.each(
					function() {

						// Settings
						var $widget = $(this), $button = $widget.find('button'), $checkbox = $widget
								.find('input:checkbox'), color = $button
								.data('color'), settings = {
							on : {
								icon : 'glyphicon glyphicon-check'
							},
							off : {
								icon : 'glyphicon glyphicon-unchecked'
							}
						};

						// Event Handlers
						$button.on('click',
								function() {
									$checkbox.prop('checked', !$checkbox
											.is(':checked'));
									$checkbox.triggerHandler('change');
									updateDisplay();
								});
						$checkbox.on('change', function() {
							updateDisplay();
						});

						// Actions
						function updateDisplay() {
							var isChecked = $checkbox.is(':checked');

							// Set the button's state
							$button.data('state', (isChecked) ? "on" : "off");

							// Set the button's icon
							$button
									.find('.state-icon')
									.removeClass()
									.addClass(
											'state-icon '
													+ settings[$button
															.data('state')].icon);

							// Update the button's color
							if (isChecked) {
								$button.removeClass('btn-default').addClass(
										'btn-' + color + ' active');
							} else {
								$button.removeClass('btn-' + color + ' active')
										.addClass('btn-default');
							}
						}

						// Initialization
						function init() {

							updateDisplay();

							// Inject the icon if applicable
							if ($button.find('.state-icon').length == 0) {
								$button.prepend('<i class="state-icon '
										+ settings[$button.data('state')].icon
										+ '"></i>');
							}
						}
						init();
					});
});

//onload event
window.onload = function(){
    //get elements
    var typeselect = document.getElementById("username");
    var typeImg = document.getElementById('typeselectIMG');
    var secondstep = document.getElementById("secondstep");
    var quantInput = document.getElementById("quantity");
    var quantImg = document.getElementById("quantityIMG");
    //select event
    typeselect.onchange = function(){
        if( this.value != 'off' ){
            typeImg.style.visibility = 'visible';
            secondstep.style.visibility = 'visible';
        }else{
            typeImg.style.visibility = 'hidden';
            quantImg.style.visibility = 'hidden';
            secondstep.style.visibility = 'hidden';
        }
    };
    //input changed event
    quantInput.oninput = function(){
        if(this.value == 'hr'){
            quantImg.style.visibility = 'visible';
        }else{
            quantImg.style.visibility = 'hidden';
        }
    };
};