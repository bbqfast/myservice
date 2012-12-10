// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require jquery-ui-1.9.1.custom

// textbox + select list utility
var combo = 
{
  getSelectId: function(fieldname)
  {
    // JQ sample from web
    //$('#yourdropdownid').find('option:selected').text();
    return '#select_' + fieldname + ' > select ';
  },

  gettextboxId: function(fieldname)
  {
    return '#textbox_' + fieldname + ' > input';
  },
  
  addChangeEvent: function(fieldname)
  {
    $(combo.getSelectId(fieldname)).change(function()
      {
        var selectVal = $(combo.getSelectId(fieldname)).find('option:selected').text();
        $(combo.gettextboxId(fieldname)).val(selectVal);
      }
    );    
  }
}


$(function() {
// alert('pre subscribing!');
  var faye = new Faye.Client('http://localhost:9292/faye');
  //alert('subscribing!');
  faye.subscribe('/messages/new', function (data) {
    // alert(data);
    document.location.reload();
  });
});