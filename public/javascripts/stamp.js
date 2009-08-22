$(document).ajaxSend(function(event, request, settings) {
  if (typeof(AUTH_TOKEN) == "undefined") return;
  // settings.data is a serialized string like "foo=bar&baz=boink" (or null)
  settings.data = settings.data || "";
  settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
});

var stamping = false;

$(function() {
  $("#calendar td").live("click", function(event) {
    if ($(this).children("a.mark_link").length > 0) {
      if ($(this).children(".mark").length > 0) {
        $.post($(this).children("a.mark_link").attr("href"), { _method: "delete" }, null, "script");
      } else {
        var p = $(this).position();
        var x = (event.pageX - p.left);
        var y = (event.pageY - p.top);
        $.post($(this).children("a.mark_link").attr("href"), { x: x, y: y, skip: !stamping }, null, "script");
      }
      stamping = false;
    }
    return false;
  });
  
  $("#calendar #month a").live("click", function(event) {
    $.getScript(this.href);
    return false;
  });
  
  $("#stamper a").click(function(click_event) {
    $("#stamper a img").attr("src", "/images/stamper/ink.png");
    $("#stamp_cursor").attr("src", "/images/stamper/holding.png").show().css({
      left: (click_event.pageX - 40) + 'px',
      top: (click_event.pageY - 45) + 'px'
    }).click(function(event) {
      $("body").unbind("mousemove");
      $("#stamp_cursor").unbind("click").hide();
      var element = document.elementFromPoint(event.pageX, event.pageY);
      if (element.id.search(/day_/) != -1 && $(element).children("a.mark_link").length > 0) {
        $("#stamp_cursor").attr("src", "/images/stamper/stamping.png").show();
        var p = $(element).position();
        var x = (event.pageX - p.left);
        var y = (event.pageY - p.top);
        $.post($(element).children("a.mark_link").attr("href"), { x: x, y: y }, null, "script");
      } else {
        $("#stamper a img").attr("src", "/images/stamper/ready.png");
      }
    });
    $("body").mousemove(function(event) {
      $("#stamp_cursor").css({
        left: (event.pageX - 40) + 'px',
        top: (event.pageY - 45) + 'px'
      });
    });
    return false;
  });
});
