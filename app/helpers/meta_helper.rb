module MetaHelper
  def display_meta(title)
    content_tag(:span, class: 'meta') do
      meta({title: title})
    end
  end

  #Meta Tags
  def cake_meta_tags
    tags = {
      site: t('application.name'),
      title: [:title, :site],
      description: t('application.meta.description'),
      keywords: t('application.meta.keywords'),
      og: {
        title: t('application.meta.og.title'),
        description: t('application.meta.description'),
        image: image_url('fb_share.png'), 
        url: request.original_url, 
      },
      twitter: {
        card: 'summary',
        site: t('application.twitter_account'),
        title: t('application.meta.og.title'),
        description: t('application.meta.description'), 
        image: image_url('fb_share.png'), 
        url:request.original_url
      }
    }
    metamagic tags
  end

  def book_page_meta(coupon_book)
    tags = {
      title: t('application.meta.og.coupon_books.title', fr: coupon_book.fr_name),
      og: {
        title: t('application.meta.og.coupon_books.title', fr: coupon_book.fr_name), 
        image: coupon_book.shareable_screenshot_url, 
        description: coupon_book.name, 
        url: coupon_book_url(coupon_book)
      },
      twitter: {
        card: 'summary',
        site: t('application.twitter_account'),
        title: t('application.meta.og.coupon_books.title', fr: coupon_book.fr_name),
        description: coupon_book.name, 
        image: coupon_book.shareable_screenshot_url, 
        url: coupon_book_url(coupon_book)
      }
    }
    content_tag(:span, class: 'meta') do
      meta tags
    end
  end

  def affiliate_page_meta(affiliate_campaign)
    tags = {
      title: t('application.meta.og.coupon_books.title', fr: affiliate_campaign.meta_title),
      og: {
        title: t('application.meta.og.coupon_books.title', fr: affiliate_campaign.meta_title), 
        image: affiliate_campaign.shareable_screenshot_url, 
        description: affiliate_campaign.name, 
        url: affiliate_campaign_url(affiliate_campaign)
      },
      twitter: {
        card: 'summary',
        site: t('application.twitter_account'),
        title: t('application.meta.og.coupon_books.title', fr: affiliate_campaign.meta_title),
        description: affiliate_campaign.name, 
        image: affiliate_campaign.shareable_screenshot_url, 
        url: affiliate_campaign_url(affiliate_campaign)
      }
    }
    content_tag(:span, class: 'meta') do
      meta tags
    end
  end

end
