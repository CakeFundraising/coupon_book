CakeCouponBook.pr_boxes ?= {}

CakeCouponBook.pr_boxes.validation = ->
  $('.formtastic.pr_box').each ->
    $(this).validate(
      errorElement: "span"
      rules:
        'pr_box[title]':
          required: true
        'pr_box[description]':
          required: true
        'pr_box[url]':
          required: true
        'pr_box[flag]':
          required: true
    )
    return
  return