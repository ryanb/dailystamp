$(function() {
  $("#calendar td").live("click", function() {
    $.post($(this).children("a.mark_link").attr("href"), null, null, "script");
  });
});
