class CreatePlayers < ActiveRecord::Migration

  def change
    create_table :players do |t|
      t.string :name
      t.integer :age
      t.string :experience
      t.integer :instrument_id
    end
  end

end