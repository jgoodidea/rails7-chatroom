class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @room = Room.new
    @rooms = Room.public_rooms

    @users = User.all_except(current_user)
  end

  def create
    @room = Room.create(name: params["room"]["name"])
  end
end
