class CreateInstruments < ActiveRecord::Migration

  def change
    create_table :instruments do |t|
      t.string :name
    end
  end

end