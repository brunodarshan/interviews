class CreateOffer < ActiveRecord::Migration[6.0]
  def change
    create_table :offers do |t|
      t.string :advertiser_name, null: false
      t.string :url, null: false
      t.text :description
      t.timestamp :starts_at
      t.timestamp :ends_at
      t.boolean :premmium

      t.timestamps
    end
  end
end
