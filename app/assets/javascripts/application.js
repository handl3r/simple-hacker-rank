// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require codemirror
//= require codemirror/modes/ruby
//= require codemirror/keymaps/vim
//= require jquery3
//= require jquery_ujs
//= require popper
//= require bootstrap-sprockets
//= require activestorage
//= require turbolinks
//= require_tree .
$(document).on('turbolinks:load', function () {
    window.codemirror_editors = {};
    $('.codemirror').each(function () {
        var $el = $(this);
        codemirror_editors[$el.attr('id')] = CodeMirror.fromTextArea($el[0],
            {
                mode: "ruby",
                theme: 'base16-dark',
                tabMode: "indent",
                textWrapping: false,
                lineNumbers: true,
            });
        //  call ajax to get default_code
        var url = window.location.href;
        var pos = url.lastIndexOf("/");
        var challenge_id = url.substring(pos+1);
        console.log(challenge_id);
        $.ajax({
            type: 'GET',
            url: '/default_code',
            data: {challenge: challenge_id},
            success: function (response) {
                // set text for codemirror
            }
        });
        var default_code = 'def mainMethod()\n\tputs "Hello"\nend';
        codemirror_editors[$el.attr('id')].setValue(default_code);
        var editor = codemirror_editors[$el.attr('id')];


        document.getElementById('test-btn').onclick = function (e) {
            var code = editor.getValue();
            $.ajax({
                type: 'POST',
                url: '/process',
                data: {content: code, language: 'ruby' }, // change language when want more language
                success: function (response) {
                    // console.log(code)
                    console.log(response);
                    console.log(response.language);
                    $('#content').text(response.content);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log('fail')
                }
            })
        }
    });
});


