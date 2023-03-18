class CreateResources < ActiveRecord::Migration[7.0]
  def change
    create_table :resources do |t|
      t.string :target_url
      t.string :response
      t.string :response_clean
      t.json :payload
      t.belongs_to :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
