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
    // setup option for codemirror
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
        // get default code and set to codemirror
        codemirror = document.querySelector('#code-mirror');
        var default_code = codemirror.dataset.defaultcode;
        console.log("dasda:" + default_code);
        codemirror_editors[$el.attr('id')].setValue(default_code);
        // set even click to buttons to send request to server
        var editor = codemirror_editors[$el.attr('id')];
        document.getElementById('test-btn').onclick = function (e) {
            var code = editor.getValue();
            $.ajax({
                type: 'POST',
                url: '/process',
                data: {content: code, language: "ruby" }, // change language when want more language
                success: function (response) {
                    // console.log(code)
                    console.log(response.content);
                    // $('#content').text(response.content);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log('fail')
                }
            })
        }
    });
});


