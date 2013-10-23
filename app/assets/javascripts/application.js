// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

function typesetMath() {
  console.log("TYPESETTING");

  $("code").map(function(){
    match = /^\$(.*)\$$/.exec($(this).html());
    if (match){
      $(this).replaceWith("<span class=hpl_mathjax_inline>" + $(this).html() + "</span>");
      MathJax.Hub.Queue(["Typeset",MathJax.Hub,$(this).get(0)]);
    }
  });

  MathJax.Hub.Queue(["Typeset",MathJax.Hub]);

  $("#input-output").append("<script src='https://gist.github.com/Sirupsen/7111270.js'></script>")
}

$(document).ready(typesetMath)
document.addEventListener("page:load", typesetMath)
