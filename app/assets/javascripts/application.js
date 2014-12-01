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
//= require foundation
//= require typeahead.bundle
//= require bootstrap-sprockets
//= require bootstrap-tagsinput
//= require bootstrap-datetimepicker
//= require editable/bootstrap-editable
//= require editable/rails
//= require_tree .
//= require scrolltop
//= require star-rating
//= require jquery.datetimepicker
var updateOptions, textValidator, numberValidator, textAreaValidator, showbutton, showForm, putSuccess, putError, initRecord, searchEngine,
    $subscribeForm, $tagInput, $editableRecord, $newRecord, $addbutton, $cancelbutton;

// Default options for pre-rendered editables
updateOptions = {
    mode: 'inline',
    ajaxOptions: {
        type: 'put',
        dataType: 'json'
    }
};

// editable validation objects
textValidator = {
    validate: function textValidator(value){ if (value.length <= 2) return "Make that just a little bit longer"; }
};

numberValidator = { 
    validate: function numberValidator(value){ if (value === null || undefined || NaN) return "Make sure there's a number here, that's important."; }
};

textAreaValidator = {
    validate: function textAreaValidator (value){ if (value.length < 50 || 500 < value.length) return "50 - 500 words will do";}
};

// editable success callback
putSuccess = {
    success: function putSuccess(response, newValue){ return; }
};

// editable error callback
putError = {
    error: function putError($xhr, status, error){ 
      return;
    }
};

// Prepare editables with appropriate option objects
initRecord = function($collection, options){
    var validator, inputType;

    $collection.each(function(index, element){ 
        
        inputType = $(element).data('type');
        
        switch (inputType) {
            case 'textarea':
                validator = textAreaValidator;
                break;
            case 'number':
                validator = numberValidator;
                break;
            default:
                validator = textValidator;
        }
        
        $(element).editable($.extend(options, validator)); 
    });
};

// Swap 'add course' button with form
showForm = function(event){
    $addbutton.hide(300);
    $newRecord.show(300);
};

// Swap form with button
showbutton = function(event){
    $newRecord.hide(300);
    $addbutton.show(300);
};

// Construct a Bloodhound object
searchEngine = new Bloodhound({
  prefetch: { url: 'http://lesson-single.codio.io:3000/skills' },
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace("name"),
    queryTokenizer: Bloodhound.tokenizers.whitespace
});

// Only execute what *needs* to be initialized at ready
$(document).ready(function(){
    // Cache selectors
    $subscribeForm = $('.subscribeForm');
    $tagInput = $('.bootstrap-tagsinput > input');
    $newRecord = $('#course-new');
    $addbutton = $('.add-btn');
    $cancelbutton = $('.cancel-btn');
    $editableRecord = $('.editable-record');

    //Hide new course form
    $newRecord.hide();

    // Event handlers
    $subscribeForm.on('ajax:before', function(){ $('#myModal').modal(); });
    $addbutton.on('click', showForm);
    $cancelbutton.on('click', showbutton);

    // Fetch or locally load JSON of skills
    searchEngine.initialize();

    // Add typeahead to the tag input
    $tagInput.typeahead({
        highlight: true,
        trimValue: true
    },{
        name: "skills",
        displayKey: "name",
        source: searchEngine.ttAdapter()
    });

    // Set the length of a tag input to 5, instead of the default 1
    $tagInput.attr({"size": 5});
      
    // Initialize pre-rendered editables with defaults
    initRecord($editableRecord, $.extend(updateOptions, putSuccess, putError));
});


$(function(){ $(document).foundation(); });

$(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&appId=815265865170699&version=v2.0";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));
