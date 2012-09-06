class PoolsController < ApplicationController
  
  def index
    @pools = Pool.all
  end
    
  def new
    @pool = Pool.new
  end
  
  def edit
    @pool = Pool.find(params[:id])
  end

  def show
    @pool = Pool.find(params[:id])
  end

  def create
    @pool = Pool.new(params[:pool])

    if @pool.save
      redirect_to pools_url
    else
      render :action => :new
    end
  end

end