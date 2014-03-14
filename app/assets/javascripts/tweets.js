// Autocomplete Feature

var userList;

// Retrieve all users from database
$.ajax({
  url: "/users.json",
  method: "GET"
}).done(function(data) {
  userList = data;
});

$(document).ready(function() {

  // Listen for the @ symbol to be pressed
  $("#tweet_tweet_text").on("keyup", function(e) {
    if( e.shiftKey && e.which === 50) {

      // call function to search through list
      var match = $("#tweet_tweet_text").autocomplete({
        lookup: userList,
        delimiter: "@",
        onSelect: function (suggestion) {
          this.focus();
          match.autocomplete().disable();
        }
      });
    }
  });

});
