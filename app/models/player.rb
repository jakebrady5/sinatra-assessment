class Player < ActiveRecord::Base

  has_many :ensemble_players
  has_many :ensembles, :through => :ensemble_players
  belongs_to :instrument

end