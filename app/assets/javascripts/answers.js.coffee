ready = ->
  $('.edit-answer-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    answer_id = $(this).data('answerId')
    $('form#edit-answer-' + answer_id).show()

  $('.best-answer-link').click (e) ->
    e.preventDefault();

$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)

$ -> $('form.new_answer').bind 'ajax:success', (e, data, status, xhr) ->
       $('.answers').append(xhr.responseText)
       $('.answer-errors').html('')
     .bind 'ajax:error', (e, xhr, status, error) ->
       $('.answer-errors').html(xhr.responseText)
