# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += [
  'pdf.css',
  'mail.css',
  'book_desktop.css',
  'models/coupon_books/templates/original.css',
  'models/coupon_books/templates/compact.css',
  'models/coupon_books/donate.css',
  'book_page.js',
  'coupon_books/templates/original.js',
  'coupon_books/templates/compact.js',
  'coupon_books/templates/mobile.js'
]
