class CreateSearches < ActiveRecord::Migration[6.0]
  def change
    create_table :searches do |t|
      t.string :type
      t.string :value
      t.timestamps
    end
  end
end
