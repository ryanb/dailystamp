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
});
