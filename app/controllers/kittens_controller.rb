class KittensController < ApplicationController
  before_action :get_kitten, only: [:show, :edit, :update, :destroy]

  def index 
    @kittens = Kitten.all
    respond_to do |format|
      format.html 
      format.json {render :json => @kittens}
    end
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)
    if @kitten.save
      redirect_to kitten_path(@kitten), notice: 'Kitten create'
    else
      render :new, flash.now[:notice] = "Kitten is not save"
    end
  end

  def show 
    respond_to do |format|
      format.html 
      format.json {render :json => @kitten}
    end
  end

  def edit
  end

  def update
    @kitten.update(kitten_params)
    if @kitten.save
      redirect_to kitten_path(@kitten), notice: 'Kitten edit'
    else
      render edit_kitten_path(@kitten), flash.now[:notice] = "Kitten is not edit"
    end
  end

  def destroy
    @kitten.destroy
    redirect_to kittens_path, notice: 'Kitten destroy'
  end

  private

  def get_kitten
    @kitten = Kitten.find(params[:id])
  end

  def kitten_params
    params.require(:kitten).permit(:age,:name,:softness,:cuteness)
  end

end
