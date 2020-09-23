# frozen_string_literal: true

class AlterOfferEnableField < ActiveRecord::Migration[6.0]
  def change
    remove_column :offers, :enable
    add_column :offers, :state, :integer
    add_index :offers, :state
  end
end
