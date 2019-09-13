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
//= require codemirror/modes/python
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
        var challenge_id = codemirror.dataset.challenge;
        codemirror_editors[$el.attr('id')].setValue(default_code);

        // set even click to buttons to send request to server
        var editor = codemirror_editors[$el.attr('id')];

        // get language be selected
        var language = 'ruby';
        $('#dropdownlanguage .dropdown-menu .dropdown-item').click(function () {
            language = $(this).text();
            console.log(language);
            $('.btn-choose-lang').text(language);
        });
        // process event when click test button
        document.getElementById('test-btn').onclick = function (e) {
            var code = editor.getValue();

            // call ajax
            $.ajax({
                type: 'POST',
                url: '/process',
                data: {challenge: challenge_id, content: code, language: language, submit: '0'}, // change language when want more language
                success: function (response) {
                    var result = response.content;
                    var length_result = result.length;
                    var temp = 1;
                    for (temp = 1; temp < length_result; temp++) {
                        var id_cpn = "#result-" + temp;
                        var id_btn = "testcase-" + temp;
                        var id_output = "#output-" + temp;
                        var output = $(id_output).text();
                        if (output.replace(/ /g, '') === result[temp - 1].replace(/ /g, '')) {
                            document.getElementById(id_btn).style.color = '#28a745';
                        } else {
                            document.getElementById(id_btn).style.color = 'red';
                        }
                        $(id_cpn).text(result[temp - 1]);
                    }
                    $('#result').text(result[length_result - 1] + "/" + (length_result - 1));
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log('fail')
                }
            })
        };


        // call jax to get default code form server
        $.ajax({
            type: 'POST',
            url: '/default_code',
            data: {language: language, challenge: challenge_id},
            success: function (response) {
                // response struct : { status: 'status code', content: defaultcode}
                // fill code to update default code of language to codemirror
                var update_default_code = response.content;
                codemirror_editors[$el.attr('id')].setValue(update_default_code);
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log('fail to load default_code')
            }
        });


        document.getElementById('submit-btn').onclick = function (e) {
            var code = editor.getValue();
            $.ajax({
                type: 'POST',
                url: '/process',
                data: {challenge: challenge_id, content: code, language: language, submit: '1'}, // change language when want more language
                success: function (response) {
                    var result = response.content;
                    var length_result = result.length;
                    var temp = 1;
                    for (temp = 1; temp < length_result; temp++) {
                        var id_cpn = "#result-" + temp;
                        var id_btn = "testcase-" + temp;
                        var id_output = "#output-" + temp;
                        var output = $(id_output).text();
                        if (output.replace(/ /g, '') === result[temp - 1].replace(/ /g, '')) {
                            document.getElementById(id_btn).style.color = '#28a745';
                        } else {
                            document.getElementById(id_btn).style.color = 'red';
                        }
                        $(id_cpn).text(result[temp - 1]);
                    }
                    $('#result').text(result[length_result - 1] + "/" + (length_result - 1));
                    if (response.status === 'submit done') {
                        alert('Finished challenge!')
                    } else if (response.status === 'submit fail') {
                        alert('Check your code!')
                    } else if (response.status === 're-submit done') {
                        alert('Re-submit done')
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log('fail')
                }
            })
        };
    });
});


