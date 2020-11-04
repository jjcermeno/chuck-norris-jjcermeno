class CreateJokeSearches < ActiveRecord::Migration[6.0]
  def change
    create_table :joke_searches do |t|
      t.references :joke, index: true
      t.references :search, index: true
      t.timestamps
    end
  end
end
