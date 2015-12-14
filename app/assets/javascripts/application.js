// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.remotipart
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .

$(document).on('change', 'input#product_image', function() {
  var input = this;
  var reader = new FileReader();
  reader.onload = function(e) {
    var image_base64 = e.target.result;
    $('#' + input.id + '_preview').attr('src', image_base64);
  };
  reader.readAsDataURL(input.files[0]);
});

$(document).on('keyup', '#_search', function() {
  $(this.form).trigger('submit.rails');
});

$(document).on('change', '.quantity input', calc);

function calc() {
    var $input = $(this),
        total = 0;
    $('.modal-body').find('.quantity').each(function() {
        total += +$(this).attr('data-price') * +$(this).find('input').val();
    });
    $('#total-price').html(total.toFixed(2));$.ajax({
        type: 'PUT',
        contentType: 'application/json; charset=utf-8',
        url: '/orders/' + $input.attr('id').split('_')[1],
        data : JSON.stringify({quantity: $input.val()}),
        dataType: 'json'
    });
}
