module ApplicationHelper
  
  def format_win_percentage(win_percentage)
    wp = win_percentage.to_f.round(3)
    wp = wp.to_s.split('.')
    wp[0] = '' if wp[0] == '0'
    wp[1] = wp[1].ljust(3, '0')
    return "#{wp[0]}.#{wp[1]}"
  end

  def user_can_do_shit?
    user_signed_in? #and current_user.runs_tournament?
  end
  
end