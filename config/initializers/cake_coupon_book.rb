module CakeCouponBook
  APPLICATION_FEE = ENV['APPLICATION_FEE'].to_f
  STRIPE_FEE = 2.9

  ASYNC_VENDOR_JS = [
    "https://js.stripe.com/v2/", 
    "//widget.cloudinary.com/global/all.js", 
    "//s7.addthis.com/js/300/addthis_widget.js#async=1&pubid=ra-542a2ea07b4b6c5d"
  ]
end