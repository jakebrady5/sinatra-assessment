class Ensemble < ActiveRecord::Base

  belongs_to :user
  has_many :ensemble_players
  has_many :players, :through => :ensemble_player
  has_many :instruments, :through => :players

end