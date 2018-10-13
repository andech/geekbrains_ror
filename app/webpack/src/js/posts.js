$(document).ready(function () {
  $('.load-more').click(function (e) {
    e.preventDefault();
    var last_id = $('.post-item').last().attr('data-id');
    $.ajax({
        type: "GET",
        url: $(this).attr('href'),
        data: {
          id: last_id
        },
        dataType: "script",
        success: function () {
            $('.load-more').show();
        }
    });
  });
});