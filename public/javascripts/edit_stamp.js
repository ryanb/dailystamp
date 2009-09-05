$(document).ajaxSend(function(event, request, settings) {
  if (typeof(AUTH_TOKEN) == "undefined") return;
  // settings.data is a serialized string like "foo=bar&baz=boink" (or null)
  settings.data = settings.data || "";
  settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
});

jQuery.fn.change_color = function(color) {
  this.each(function() {
    $(this).attr("src", $(this).attr("src").replace(/\/(red|green|blue|purple|black)\//, "/" + color + "/")); 
  });
  return this;
};

$(function() {
  $("#colors input").click(function() {
    $("#stamp_images img").change_color(this.value);
  });
  $("#stamp_images .delete a").removeAttr("onclick").click(function () {
    if (confirm("Are you sure you want to delete this stamp image?")) {
      $.post(this.href, "_method=delete", null, "script");
    }
    return false;
  });
});
