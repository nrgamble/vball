$(document).bind('pageinit', function () {
  $('div[data-role="navbar"] li a').click(function () {
    $('.pane').hide();
    $('#' + this.id.replace(/a_/, '')).parent().show();
  });

  $('button[type=submit]').click(function () {
    $('form').submit();
  });
});