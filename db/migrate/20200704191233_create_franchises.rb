class CreateFranchises < ActiveRecord::Migration[5.2]
  def change
    create_table :franchises do |t|
      t.integer :company_id
      t.integer :owner_id
      t.string :location
      t.integer :profit
    end
  end
end
