module ApplicationHelper
  
  def title
    base_title = "El Amigo Secreto"
    if @title
      base_title = base_title + " " + @title
    end
  end
end
