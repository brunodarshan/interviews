class AddEnableToOffers < ActiveRecord::Migration[6.0]
  def change
    add_column :offers, :enable, :boolean, default: false
  end
end
