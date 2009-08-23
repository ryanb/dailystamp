var current_suggestion = 1;

$(function() {
  $("#suggestions .more").click(function() {
    $("#suggestions_" + current_suggestion).slideUp("normal", function() {
      if (current_suggestion == 3) {
        current_suggestion = 1
      } else {
        current_suggestion++;
      }
      $("#suggestions_" + current_suggestion).slideDown("normal");
    });
    return false;
  });
  $("#suggestions ul a").click(function() {
    $("#stamp_name").attr("value", this.innerHTML)
    return false;
  });
});
