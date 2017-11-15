$(function() {
  var data = {};
  data[$('meta[name=csrf-param]').attr('content')] = $('meta[name=csrf-token]').attr('content');
  $.ajaxSetup({
    data: data
  });
});
