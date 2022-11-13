class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @room = Room.new
    @rooms = Room.public_rooms

    @single_room = Room.find(params[:id])

    @users = User.all_except(current_user)
  end

  def create
    @room = Room.create(name: params["room"]["name"])
  end
end
