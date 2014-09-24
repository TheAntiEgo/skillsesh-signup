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
//= require handlebars.runtime
//= require bootstrap-sprockets
//= require bootstrap-modal
//= require bootstrap-modalmanager
//= require bootstrap-tagsinput
//= require twitter/typeahead
//= require editable/bootstrap-editable
//= require editable/inputs-ext/typeahead-editable.js
//= require editable/rails
//= require_tree ./templates
//= require_tree .

$(document).ready(function(){
    // JOHN THIS IS WHAT YOU WERE LAST FOOLING AROUND WITH
    $('a[href="' + this.location.pathname + '"]').parent().addClass('active');
    
    // Fix email form
    $('.subscribeForm').on('ajax:before', function(){
        $('#myModal').modal();
    });

    //Initialize typeahead
    var skills = new Bloodhound({
        prefetch: { url: "http://lotus-laptop.codio.io:3000/skills" },
        datumTokenizer: Bloodhound.tokenizers.obj.whitespace("name"),
        queryTokenizer: Bloodhound.tokenizers.whitespace
    });
    
    skills.initialize();
    
    $('.bootstrap-tagsinput input:first-child').typeahead({
      highlight: true,
      trimValue: true
    },{
        // dataset options
        name: "skills",
        displayKey: "name",
        source: skills.ttAdapter() 
      });
    
    //Increase the size of tag input
    $('.bootstrap-tagsinput > > input').attr({"size": 5}); // The average length of a word in the English language
    
    // Prepare tag/typeahead input for tooltips and popovers
    $('.tt-input').addClass('has-tooltip');
    $('.tt-input').attr({
      title: "Press enter after each skill.",
      "data-toggle": "popover",
      "data-html": "true",
      "data-placement": "top",
      "data-content": "#charnum"
    });
    
    // Enable tooltips
    $('.has-tooltip').tooltip();
    $('input[title]').tooltip({ placement:'top' });
    $('.has-popover').popover({ trigger: 'hover' });
    
    // Enable word count
    var countChar = function countChar(val) {
        var len = val.value.length;
      
        if (len >= 500) {
            val.value = val.value.substring(0, 500);
        }else {
            $('#charNum').text(500 - len);
        }
    };
    
    //Initialize editable fields
    $('.editable-default').editable({
      url: "/profile",
      ajaxOptions: {
        type: 'put',
        dataType: 'json'
      },
      mode: 'inline',
      success: function edit_success(response, newValue) {
        console.log("The response has these keys: " + Object.keys(response));
        console.log("The new value was: " + newValue);
        return;
    }
  });
  
    // New course
    $('.editable-new-name').editable({
      mode: 'inline',
      emptytext: "Add a new session starting with its name",
      send: 'never',
      validate: function(value) {
        if (value.length > 0 && value.length < 5){
          return {newValue: value, msg: "Make it just a little bit longer"};
        }
      },
      success: function success(response, value){
        $(HandlebarsTemplates['profiles/newGoal']()).appendTo('.panel-initial-heading');
        
        $('.editable-new-goal').editable({
          mode: 'inline',
          send: "never",
          unsavedclass: null,
          validate: function(value){
            if (value.length > 0 && value.length < 10){
              return {newValue: value, msg: "Make it just a little bit longer"};
            }
          },
          success: function success(res, val){
            $(HandlebarsTemplates['profiles/newHow']()).appendTo('.panel-initial');
            
            $('.editable-new-how').editable({
              mode: 'inline',
              send: "never",
              unsavedclass: null,
              validate: function(value){
                if (value.length > 0 && value.length < 10){
                  return {newValue: value, msg: "Make it just a little bit longer"};
                }
              },
              success: function(res, val){
                $(HandlebarsTemplates['profiles/newRequirements']()).appendTo('.panel-initial-body');
                
                $('.editable-new-requires').editable({
                  mode: 'inline',
                  send: 'never',
                  unsavedclass: null,
                  validate: function(value){
                    if (value.length > 0 && value.length < 10){
                      return {newValue: value, msg: "Say a little bit more, please"};
                    }
                  },
                  success: function(res, val){}
                });
                
                $('.editable-new-duration').editable({
                    mode: 'inline',
                    send: 'never',
                    unsavedclass: null,
                    validate: function validate(value){
                      if (Number(value) === NaN){
                        return {newValue: "", msg: "Make sure this is a number"};
                      }
                    },
                    success: function(res, val){}
                });
                
                $('.editable-new-price').editable({
                    mode: 'inline',
                    send: 'never',
                    unsavedclass: null,
                    validate: function validate(value){
                      if (Number(value) === NaN){
                        return {newValue: "", msg: "Make sure this is a number"};
                      }
                    },
                    success: function success(res, val){
                      $('.panel-initial-footer > button').removeClass('btn-default disabled').addClass('btn-primary').attr('disabled', false);
                      $('.panel-initial-footer > button').click(function(){
                          $('.editable-new').editable('submit', {
                              url: '/profile/courses',
                              ajaxOptions: {
                                  dataType: 'json'
                              },
                              success: function success(data, config){
//                               TODO Fulfill new course submission
//                                 if (data && data.id){
//                                   $('.editable-new').editable({
//                                     ajaxOptions: {
//                                       type: 'put',
//                                       dataType: 'json'
//                                     },
//                                     pk: data.id,
//                                     url: '/profile/courses/' + data.id
//                                   });
                                  
//                                   var buttons = $('.panel-initial-footer > button');
//                                   buttons.removeClass('btn-danger btn-default disabled');
//                                   buttons[0]
//                                       .addClass('btn-primary')
//                                       .attr({
//                                           "data-toggle": "collapse",
//                                           "data-parent": "#accordion",
//                                           "href": "#course-panel-" + data.id
//                                       })
//                                       .val("Read more");
//                                   buttons[1]
//                                       .addClass('btn-danger')
//                                       .attr('href', '#')
//                                       .val("Book it!");
//                                 }
                              },
                              error: function success(err){}
                          });
                      });
                    }
                });
              }
            });
            
            $('#panel-initial-collapse').collapse("toggle");            
          }
        });
      }
    });
    
});
