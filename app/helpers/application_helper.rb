# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def mark_image(mark, size = 70)
    options = {:size => "#{size}x#{size}", :class => "mark"}
    if mark.position_x && mark.position_y
      options[:style] = "margin-left: #{mark.position_x-size/2-6}px; margin-top: #{mark.position_y-size/2-6}px;"
    end
    image_tag mark_image_name(mark), options
  end
  
  def small_mark_image(mark)
    image_tag mark_image_name(mark), :size => "25x25"
  end
  
  def mark_image_name(mark)
    if mark.nil?
      "spacer.gif"
    elsif mark.skip?
      "skip.png"
    elsif mark.image_path.nil?
      "question_mark.png"
    else
      mark.image_path
    end
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
  
  def stamp_owner?
    @stamp && @stamp.user == current_user
  end
end
