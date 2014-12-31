class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :code
      t.string :title
      t.text :description
      t.text :house_rules
      t.timestamps
    end
  end
end
