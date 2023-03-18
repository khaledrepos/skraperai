class CreatePlaygroundRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :playground_requests do |t|
      t.string :target_url
      t.text :json_schema
      
      t.text :response
      t.text :response_clean
      t.json :response_gpt

      t.timestamps
    end
  end
end
