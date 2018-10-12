$(document).ready(function () {
  $('.load-more').click(function (e) {
    e.preventDefault();
    $.ajax({
        type: "GET",
        url: $(this).attr('href'),
        dataType: "script",
        success: function () {
            $('.load-more').show();
        }
    });
  });
});