class MessagesController < ApplicationController
  def index
    render json: Message.all, :include => {:user => {:only => :username}}
  end
end
