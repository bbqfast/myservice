class MessagesController2 < ApplicationController

  def create
    xx
  end

  def new
@messages = Message.all
  end

  def index
    @messages = Message.all
  end

  def create2
    x
    @message = Message.create!(params[:message])
  end

end

