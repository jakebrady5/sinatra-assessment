class CreateEnsemblePlayers < ActiveRecord::Migration

  def change
    create_table :ensemble_players do |t|
      t.integer :ensemble_id
      t.integer :player_id
    end
  end

end