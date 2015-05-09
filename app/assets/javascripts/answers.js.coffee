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
    question = answer.question_id
    id = answer.id
    $('.answer-errors').empty()

    attachments = ''

    for file in answer.attachments
      attachments += "<ul><div class 'filename' id='file_#{file.id}'><a href='#{file.url}'>#{file.name}</a><a id='delete_file_#{file.id}' href='/attachments/#{file.id}' data-method='delete' rel='nofollow' data-remote='true'>Delete Attachment</a></div></ul>"

    delete_answer = "<a data-remote='true' rel='nofollow' data-method='delete' href='/answers/#{ id }'>Delete</a><span></span>"
    accept_as_best = "<a data-remote='true' rel='nofollow' data-method='patch' href='/answers/#{ id }/best'>Best</a><span></span>"
    edit_answer = "<a data-remote='true' href='' data-answer-id='#{ id }' class='edit-answer-link' id='edit_answer_#{ id }'>Edit</a>"
    form_for_answer_edit = "<p><form id='for_answer_edit_#{ id }' class='edit_answer' action='/answers/#{ id }' accept-charset='UTF-8' data-remote='true' method='post'><input name='utf8' type='hidden' value='&#x2713;' /><input type='hidden' name='_method' value='patch' /><label for='answer_body'>Answer</label><textarea name='answer[body]' id='answer_body'>#{ answer.body }</textarea><input type='submit' name='commit' value='Saves' /></form><\p>"


    $('.answers').append("<div class='answer' id='answer_#{ id }'><p>#{ answer.body }</p>#{attachments}<p>#{ delete_answer } #{accept_as_best} #{edit_answer} #{form_for_answer_edit}</p>")

    $('.edit-answer-link').click (e) ->
      e.preventDefault();
      $(this).hide();
      answer_id = $(this).data('answerId')
      $('form#for_answer_edit_' + answer_id).show()


  answer_create_error = (e, xhr, status, error) ->
    errors = $.parseJSON(xhr.responseText)
    $('.answer-errors').empty()
    $.each errors, (index, value) ->
      $('.answer-errors').append(value)

  # $(document).on 'ajax:success', 'form#new_answer', answer_create
  # $(document).on 'ajax:error', 'form#new_answer', answer_create_error

