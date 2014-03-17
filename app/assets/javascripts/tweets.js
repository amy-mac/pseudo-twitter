// Autocomplete Feature

var userList;
var $tweetBox = $("#tweet_tweet_text");
var charCount = 0;

// Retrieve all users from database
$.ajax({
  url: "/users.json",
  method: "GET"
}).done(function(data) {
  userList = data;
});

// Retrieves character count of tweet and updates page
function getCharCount() {
  charCount = $tweetBox.val().length;
  $("#characters").html(charCount);
}

// Checks to see if there are too many characters and warns user
function charWarning() {
  if(charCount >= 140) {
    $("#characters").addClass("warning-text");
  } else {
    $("#characters").removeClass("warning-text");
  }
}

$(document).ready(function() {

  // Listen for the @ symbol to be pressed
  $tweetBox.on("keyup", function(e) {
    if( e.shiftKey && e.which === 50) {
      // call function to search through list
      var match = $tweetBox.autocomplete({
        lookup: userList,
        delimiter: "@",
        onSelect: function (suggestion) {
          this.focus();
          match.autocomplete().disable();
        }
      });
    }
    getCharCount();
    charWarning();
  });

});
