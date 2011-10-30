(function ($) {

  $(function () {
    $('.video .download').click(function (ev) {
      ev.preventDefault();
      var url = $(this).data('url');
      $('#download-target').attr('src', url);
    });
  });

})(jQuery);
