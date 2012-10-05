class PoolsController < ApplicationController
  
  def index
    @pools = Pool.all
  end

  def show
    @pool = Pool.find(params[:id])
    @h1 = @pool.name
  end
  
  def new
    @pool = Pool.new
    @tournament = Tournament.find(params[:tournament_id])
    @h1 = 'New Pool'
  end
  
  def edit
    @pool = Pool.find(params[:id])
    @tournament = @pool.tournament
    @h1 = 'Edit Pool'
  end

  def create
    @pool = Pool.new(params[:pool])

    if @pool.save
      redirect_to @pool
    else
      render :action => :new
    end
  end
  
  def update
    @pool = Pool.find(params[:id])

    if @pool.update_attributes(params[:pool])
      redirect_to @pool
    else
      redirect_to edit_pool_url(@pool)
    end
  end
  
  def destroy
    @pool = Pool.find(params[:id])
    @pool.destroy
   
    redirect_to @pool.tournament
  end

end