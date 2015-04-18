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

answer_create = (e, date, status, xhr) ->
  answer = $.parseJSON(xhr.responseText)
  id = answer.id
  $('.answer-errors').empty()

  attachments = ''

#  edit_answer = "<a href='' data-answer-id='#{ id }' class='edit-answer-link' id='edit_answer_#{ id }'>Edit answer</a>"

#  delete_answer = "<a href='/answers/#{ id }' data-method='delete' rel='nofollow' data-remote='true' id='delete_answer_#{ id }'>Delete answer</a>"

  delete_answer = "<a data-remote='true' rel='nofollow' data-method='delete' href='/questions/#{ answer.question_id }/answers/#{ id }'>Delete</a><span></span>"

#  accept_as_best = "<a href='/answers/#{ id }/accept_as_best' data-method='patch' rel='nofollow' data-remote='true' class='accept_as_best' id='best_answer_#{ id }'>Accept as best answer</a>"
#  accept_as_best = "<a data-remote="true" rel="nofollow" data-method="patch" href="http://localhost:3000/questions/55/answers/77/best">Best</a><span></span>

#  $('.answers').append("<tr id='answer_#{ id }'><td class='body'><div id='answer_body_#{ id }'>#{ answer.body }</div></td><td class='attachments'>#{ attachments }</td><td class='edit'>#{ edit_answer }</td><td class='delete'>#{ delete_answer }</td><td id='is_best_#{ id }' class='is_best'>#{ accept_as_best }</td></tr>")

  $('.answers').append("<div class='answer' id='answer_#{ id }'><p>#{ answer.id }</p>")

$(document).on 'ajax:success', 'form#new_answer', answer_create
