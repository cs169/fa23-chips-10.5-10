# frozen_string_literal: true

class CreateCampaignFinances < ActiveRecord::Migration[5.2]
  def change
    create_table :campaign_finances do |t|
      t.string :name
      t.string :party

      t.timestamps
    end
  end
end
