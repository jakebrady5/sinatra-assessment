class CreateEnesembles < ActiveRecord::Migration

  def change
    create_table :ensembles do |t|
      t.string :name
      t.string :city
    end
  end

end