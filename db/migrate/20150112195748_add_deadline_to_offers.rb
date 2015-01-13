class AddDeadlineToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :deadline, :DateTime
  end
end
