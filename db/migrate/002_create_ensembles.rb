class CreateEnsembles < ActiveRecord::Migration

  def change
    create_table :ensembles do |t|
      t.string :name
      t.string :city
      t.integer :user_id
    end
  end

end