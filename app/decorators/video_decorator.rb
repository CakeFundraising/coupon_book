class VideoDecorator < ApplicationDecorator
  delegate_all

  def thumbnail
    h.image_tag object.thumbnail, class: :thumbnail if object.thumbnail.present?
  end

  def iframe
    if object.url.present?
      if provider == 'youtube'
        %Q{<iframe id="#{object.id}" class="youtube_video" title="YouTube video player" width="100%" height="400px" src="//www.youtube.com/embed/#{object.url}?enablejsapi=1" frameborder="0" allowfullscreen></iframe>}.html_safe
      elsif provider == 'vimeo'
        %Q{<iframe id="#{object.id}" class="vimeo_video" src="//player.vimeo.com/video/#{object.url}?api=1" width="100%" height="400px" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>}.html_safe
      end
    end
  end

  def input_value
    youtube = Proc.new{|url| "https://www.youtube.com/watch?v=#{url}" }
    vimeo = Proc.new{|url| "https://www.vimeo.com/#{url}"}

    if object.url.present?
      unless object.errors.messages[:url].blank?
        object.url
      else
        if provider == 'youtube'
          youtube.call(object.url)
        elsif provider == 'vimeo'
          vimeo.call(object.url)
        end
      end
    end

  end
end
