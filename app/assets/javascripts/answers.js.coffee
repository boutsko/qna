$ ->
  $('.edit-answer-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    answer_id = $(this).data('answerId')
    $('form#for_answer_edit_' + answer_id).show()

  $('.best-answer-link').click (e) ->
    e.preventDefault();

  answer_create = (e, date, status, xhr) ->
    answer = $.parseJSON(xhr.responseText)
    id = answer.id
    $('.answer-errors').empty()

    attachments = ''


    delete_answer = "<a data-remote='true' rel='nofollow' data-method='delete' href='/questions/#{ answer.question_id }/answers/#{ id }'>Delete</a><span></span>"
    accept_as_best = "<a data-remote='true' rel='nofollow' data-method='patch' href='/questions/#{ answer.question_id }/answers/#{ id }/best'>Best</a><span></span>"
    edit_answer = "<a data-remote='true' href='' data-answer-id='#{ id }' class='edit-answer-link' id='edit_answer_#{ id }'>Edit</a>"
    form_for_answer_edit = "<p><form id='for_answer_edit_#{ id }' class='edit_answer' action='/questions/#{ answer.question_id }/answers/#{ id }' accept-charset='UTF-8' data-remote='true' method='post'><input name='utf8' type='hidden' value='&#x2713;' /><input type='hidden' name='_method' value='patch' /><label for='answer_body'>Answer</label><textarea name='answer[body]' id='answer_body'>#{ answer.body }</textarea><input type='submit' name='commit' value='Saves' /></form><\p>"


    $('.answers').append("<div class='answer' id='answer_#{ id }'><p>#{ answer.body }</p><p>#{ delete_answer } #{accept_as_best} #{edit_answer} #{form_for_answer_edit}</p>")

    $('.edit-answer-link').click (e) ->
      e.preventDefault();
      $(this).hide();
      answer_id = $(this).data('answerId')
      $('form#for_answer_edit_' + answer_id).show()


  $(document).on 'ajax:success', 'form#new_answer', answer_create


