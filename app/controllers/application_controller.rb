class ApplicationController < ActionController::Base
  
  protect_from_forgery
  
  before_filter :set_globals
  
  def set_globals
    @body = { :classes => Array.new }
    @h1   = 'Tourney Time'
  end
  
end