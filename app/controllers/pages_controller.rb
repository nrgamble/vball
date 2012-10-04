class PagesController < ApplicationController
  
  def index
    @body[:classes].push('pages_index')
  end
  
end