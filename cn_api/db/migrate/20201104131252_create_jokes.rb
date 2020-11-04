class CreateJokes < ActiveRecord::Migration[6.0]
  def change
    create_table :jokes do |t|
      t.string :ext_id, unique: true
      t.text :joke_value
      t.string :joke_url
      t.string :icon_url
      t.timestamps
    end
  end
end
