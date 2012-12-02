$(document).ready(function() {
  $('#submit_comment').click(function() {
    $('#homepage').val('collablearnapp.com');
  });
  $('#fadeout').delay(5000).fadeOut(400);
  $('#rot13_email').click(function() {
    window.location.href = rot13('YOUREMAILHERE');
  });
  $('.tablesorter').tablesorter();
});

function rot13(string) {
  return string.replace(/([a-m])|([n-z])/ig, function($0, $1, $2) {
    return String.fromCharCode($1 ? $1.charCodeAt(0) + 13 : $2 ? $2.charCodeAt(0) - 13 : 0) || $0;
  });
}