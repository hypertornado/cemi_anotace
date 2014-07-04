
$( document ).ready(function() {
  bindEvents();
});

function bindEvents() {

  $("#save").click(save);
  $("#save-and-quit").click(saveAndQuit);
  $("#skip").click(skip);
  $(window).keyup(keyup);

  $(".annotation-pictures img").mousedown(function (event){
    var positiveClass = "selected-ok";
    var negativeClass = "selected-fail";
    if (event.which == 3) {
      positiveClass = "selected-fail";
      negativeClass = "selected-ok";
    }

    $(event.target).removeClass(negativeClass);
    $(event.target).toggleClass(positiveClass);
    return false;
  });
}

function save() {
  dosave(false);
}

function dosave(quit) {
  var saveOk = $(".selected-ok").map(function(){return $(this).attr("src");}).get().join(";");
  var saveFail = $(".selected-fail").map(function(){return $(this).attr("src");}).get().join(";");


  $.ajax({
    type: "GET",
    url: "/save",
    data: {id: $("body").data("id"), appropriate: saveOk, not_appropriate: saveFail},
    success: function () {
      if (quit == true) {
        window.location = "/logout";
      } else {
        window.location.reload();
      }
    }
  });

}

function saveAndQuit() {
  dosave(true);
}

function skip() {
  $.ajax({
    type: "GET",
    url: "/skip",
    data: {id: $("body").data("id")},
    success: function () {
      window.location.reload();
    }
  });
}

function keyup(event) {
  if (event.keyCode == 13 && event.ctrlKey) { //ctrl + enter
    save();
  }
}