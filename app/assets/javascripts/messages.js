$(document).on('turbolinks:load', function(){
  $('form.new_message').submit(formHandler);

  function formHandler(e){
    let method = e.target.method;
    let action = e.target.action;
    let message = e.target.message_content.value;
    let id = e.target.message_sender_id.value;

    $.ajax({
      method: method,
      url: action,
      data: { message: { sender_id: id, content: message } },
      dataType: 'script'
    });
    e.preventDefault();
  }
});
