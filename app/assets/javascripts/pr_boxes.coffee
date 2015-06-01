CakeCouponBook.pr_boxes ?= {}

CakeCouponBook.pr_boxes.validation = ->
  $('.formtastic.pr_box').each ->
    $(this).validate(
      errorElement: "span"
      rules:
        'pr_box[headline]':
          required: true
        'pr_box[story]':
          required: true
        'pr_box[url]':
          required: true
        'pr_box[flag]':
          required: true
    )
    return
  return