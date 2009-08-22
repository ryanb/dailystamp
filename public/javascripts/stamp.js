$(document).ajaxSend(function(event, request, settings) {
  if (typeof(AUTH_TOKEN) == "undefined") return;
  // settings.data is a serialized string like "foo=bar&baz=boink" (or null)
  settings.data = settings.data || "";
  settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
});

$(function() {
  $("#calendar td").live("click", function(event) {
    if ($(this).children("a.mark_link").length > 0) {
      if ($(this).children(".mark").length > 0) {
        $.post($(this).children("a.mark_link").attr("href"), { _method: "delete" }, null, "script");
      } else {
        var p = $(this).position();
        var x = (event.pageX - p.left);
        var y = (event.pageY - p.top);
        $.post($(this).children("a.mark_link").attr("href"), { x: x, y: y, skip: "true" }, null, "script");
      }
    }
    return false;
  });
  
  $("#calendar #month a").live("click", function(event) {
    $.getScript(this.href);
    return false;
  });
});
