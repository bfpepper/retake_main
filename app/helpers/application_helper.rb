module ApplicationHelper

  def color_output(status)
    if status = false
      new_class = "false"
    else
      new_class = "true"
    end
    new_class
  end

end
