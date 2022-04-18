class CommentRelayJob < ApplicationJob
  queue_as :default

  def perform(note)
    # p note

    # binding.pry

    # ActionCable.server.broadcast "messages:#{comment.message_id}:comments",

    # ActionCable.server.broadcast 'room_channel', message: render_message(message)

    ActionCable.server.broadcast 'room_channel', { body_json: note.body_json, user: note.user }
  end
end
