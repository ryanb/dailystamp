# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def mark_image(mark, size = 70)
    options = {:size => "#{size}x#{size}", :class => "mark"}
    if mark.position_x && mark.position_y
      options[:style] = "margin-left: #{mark.position_x-size/2-6}px; margin-top: #{mark.position_y-size/2-6}px;"
    end
    image_tag (mark.skip? ? "skip.png" : "mark.png"), options
  end
  
  def points(num)
    if num > 0
      "+#{num}"
    elsif num.zero?
      num.to_s
    else
      content_tag(:span, num, :class => "negative")
    end
  end
end
