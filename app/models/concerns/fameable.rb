module Fameable
  extend ActiveSupport::Concern

  included do
    has_many :fames, as: :fameable
  end

  def total_fame
    self.fames.sum(:value)
  end
end