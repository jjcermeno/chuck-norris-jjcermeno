class CreateJokeCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :joke_categories do |t|
      t.references :joke, index: true
      t.references :category, index: true
      t.timestamps
    end
  end
end
