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

jQuery.fn.submit_with_ajax = function() {
  this.submit(function() {
    $.post(this.action, $(this).serialize(), null, "script");
    return false;
  })
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
  // $("#new_stamp_image_link").click(function() {
  //   $.getScript(this.href);
  //   return false;
  // });
});

function modal_dialog(content) {
  var overlay = $("<div id='modal_overlay'></div>");
  var window = $("<div id='modal_window'></div>");
  $("body").append(overlay.click(function() {
    modal_hide();
  })).append(window);
  overlay.css("opacity", 0.8);
  overlay.fadeIn(150);
	window.css({
		"margin-left": -300,
		"margin-top": -200
	}).html(content).fadeIn(150);
	$("#modal_window form").submit_with_ajax();
  $(document).keydown(handle_escape);
}

function modal_hide() {
  $(document).unbind("keydown", handle_escape)
  var remove = function() {
    $(this).remove();
  }
  $("#modal_window").fadeOut(remove);
  $("#modal_overlay").fadeOut(remove);
}

function handle_escape(e) {
  if (e.keyCode == 27) {
    modal_hide();
  }
}
