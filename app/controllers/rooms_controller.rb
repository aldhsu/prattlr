class RoomsController < ApplicationController
  def index
    render json: Room.all
  end

  def create
  end

  def new
  end

  def destroy
  end

  def update
  end
end
