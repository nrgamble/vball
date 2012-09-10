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
  
  def update
    @pool = Pool.find(params[:id])

    if @pool.update_attributes(params[:pool])
      redirect_to pools_url    
    else
      redirect_to edit_pool_url(@pool)
    end
  end
  
  def destroy
    @pool = Pool.find(params[:id])
    @pool.destroy
   
    redirect_to pools_url
  end

end