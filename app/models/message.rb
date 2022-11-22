class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  before_create :confirm_participant
  has_many_attached :attachments, dependent: :destroy

  after_create_commit do
    notify_recipients
    update_parent_room
    broadcast_append_later_to room
    broadcast_to_home_page
  end

  def chat_attachment(index)
    target = attachments[index]
    return unless attachments.attached?

    if target.image?
      target.variant(resize_to_limit: [150, 150]).processed
    elsif target.video?
      target.variant(resize_to_limit: [150, 150]).processed
    end
  end

  def confirm_participant
    return unless room.is_private
    
    is_participant = Participant.where(user_id: self.user_id, room_id: self.room.id).first
    throw :abort unless is_participant
  end

  def update_parent_room
    room.update(last_message_at: Time.now)
  end

  private

  def notify_recipients
    users_in_room = room.joined_users
    users_in_room.each do |user|
      next if user.eql?(self.user)

      notification = MessageNotification.with(message: self, room:)
      notification.deliver_later(user)
    end
  end

  def broadcast_to_home_page
    if !self.room.is_private
      broadcast_prepend_later_to 'public_messages',
        target: 'public_messages',
        partial: 'messages/message_preview',
        locals: { message: self }
      
      message_to_remove = Message.where(room: Room.public_rooms).order(created_at: :desc).fifth

      broadcast_remove_to 'public_messages',
        target: message_to_remove
    end
  end
end
