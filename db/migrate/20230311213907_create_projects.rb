class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.text :json_schema
      t.integer :expiry

      t.timestamps
    end
  end
end
