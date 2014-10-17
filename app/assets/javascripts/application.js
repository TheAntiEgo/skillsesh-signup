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
//= require bootstrap-sprockets
//= require bootstrap-modal
//= require bootstrap-modalmanager
//= require bootstrap-tagsinput
//= require bootstrap-datetimepicker
//= require twitter/typeahead
//= require editable/bootstrap-editable
//= require editable/rails
//= require_tree .

var updateOptions, textValidator, numberValidator, textAreaValidator, showButton, showForm, putSuccess, putError, initRecord, searchEngine,
    $subscribeForm, $tagInput, $editableRecord, $newRecord, $addButton, $cancelButton, $readButton;

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
    $addButton.hide(300);
    $newRecord.show(300);
};

// Swap form with button
showButton = function(event){
    $newRecord.hide(300);
    $addButton.show(300);
};

// Construct a Blooudhound object
searchEngine = new Bloodhound({
    prefetch: { url: "http://tape-hilton.codio.io:3000/skills" },
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace("name"),
    queryTokenizer: Bloodhound.tokenizers.whitespace
});

// One-way toggle unread => read
toggleReadStatus = function(event){
    $('.unread').removeClass('unread').addClass('read');
    
    $readButton.addClass('disabled');
};

// Only execute what *needs* to be initialized at ready
$(document).ready(function(){
    // Cache selectors
    $subscribeForm = $('.subscribeForm');
    $tagInput = $('.bootstrap-tagsinput > input');
    $newRecord = $('#course-new');
    $addButton = $('.add-btn');
    $cancelButton = $('.cancel-btn');
    $editableRecord = $('.editable-record');
    $readButton = $('.btn-mark-read');

    //Hide new course form
    $newRecord.hide();

    // Event handlers
    $subscribeForm.on('ajax:before', function(){ $('#myModal').modal(); });
    $addButton.on('click', showForm);
    $cancelButton.on('click', showButton);
    $readButton.on('click', toggleReadStatus);

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