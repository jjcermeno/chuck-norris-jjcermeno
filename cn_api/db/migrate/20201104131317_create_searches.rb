class CreateSearches < ActiveRecord::Migration[6.0]
  def change
    create_table :searches do |t|
      t.string :search_type
      t.string :search_value
      t.string :email
      t.timestamps
    end
  end
end
