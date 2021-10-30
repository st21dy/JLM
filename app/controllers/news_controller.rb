class NewsController < ApplicationController

  def create
    @new = New.new(new_params)
    @new.admin_id = current_admin.id
    @new.save
    redirect_to news_index_path
  end

  def index
    @new = New.new
    @news =New.all
  end

  def show
    @new = New.find(params[:id])
  end

  def destroy
    @new = New.find(params[:id])
    @new.destroy
    redirect_to news_index_path
  end

  private

  def new_params
    params.require(:new).permit(:image, :title, :score, :league)
  end

end
