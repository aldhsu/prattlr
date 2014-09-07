class MessagesController < ApplicationController
  def index
    render json: Message.all, :include => {:user => {:only => :username}}
  end

  def socketio
    # render json: {find: params}
    # render nothing: true
  end
end
