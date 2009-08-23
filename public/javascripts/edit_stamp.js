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
