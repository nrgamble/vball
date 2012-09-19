module ApplicationHelper
  
  def format_win_percentage(win_percentage)
    return win_percentage.to_f.round(3)
  end
  
end