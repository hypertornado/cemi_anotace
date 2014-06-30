
$( document ).ready(function() {
  bindEvents();
});

function bindEvents() {

  $("#save").click(save);
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
  var saveOk = $(".selected-ok").map(function(){return $(this).attr("src");}).get().join(";");
  var saveFail = $(".selected-fail").map(function(){return $(this).attr("src");}).get().join(";");
  console.log(saveFail);
}

function skip() {
  alert("skip");
}

function keyup(event) {
  if (event.keyCode == 13) { //enter
    save();
  }
}