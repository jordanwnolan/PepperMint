module Shareable
  extend ActiveSupport::Concern

  included do
    has_many :shares, as: :shareable
  end

  def create_public_share(options)
    user_id = options[:user_id]
    on_track = self.on_track?
    self.shares.create({message: self.generate_message({is_new: options[:is_new], on_track: on_track}), 
      status: on_track, user_id: user_id})
    # fail
  end
end