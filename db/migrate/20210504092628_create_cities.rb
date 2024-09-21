class CreateCities < ActiveRecord::Migration[6.1]
  def change
    create_table :cities do |t|
      t.decimal :longitude
      t.decimal :latitude
      t.string :capital
      t.string :country

      t.timestamps
    end

    add_index :cities, [:capital, :country], unique: true
  end
end
