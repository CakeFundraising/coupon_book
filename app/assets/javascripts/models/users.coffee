CakeCouponBook.users ?= {}

CakeCouponBook.users.validation = ->
  $('.formtastic.user').validate(
    errorElement: "span"
    rules:
      'user[first_name]': 
        required: true
      'user[last_name]': 
        required: true
      'user[email]':
        required: true
        email: true
      'user[password]':
        minlength: 5
        required: true
      'user[password_confirmation]':
        required: true
        minlength: 5
        equalTo: "#user_password"
      'user[current_password]':
        minlength: 5
        required: true
  )
  return