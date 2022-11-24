class AdminController < ApplicationController
  def dashboard
    if (current_user&.admin?)
      @messages = Message.group_by_day(:created_at, range: 1.month.ago..Time.now).count
    else
      redirect_to root_path
    end
  end
end
