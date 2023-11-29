# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  validates :address, :city, :state, :zip, :party, :photo_url, presence: true

  def self.civic_api_to_representative_params(rep_info)
    reps = []

    rep_info.officials.each_with_index do |official, index|
      ocdid_temp = ''
      title_temp = ''
      
      address_temp = official.address[0].line1
      city_temp = official.address[0].city
      state_temp = official.address[0].state
      zip_temp = official.address[0].zip
      party_temp = official.party
      photo_url_temp = official.photoUrl

      rep_info.offices.each do |office|
        if office.official_indices.include? index
          title_temp = office.name
          ocdid_temp = office.division_id
        end
      end

      # FIRST check if representative is in DB, if it is then just use that instead
      rep = Representative.find_or_create_by({ name: official.name, ocdid: ocdid_temp,
          title: title_temp, address: address_temp, city: city_temp, state: state_temp, 
          zip: zip_temp, party: party_temp, photo_url: photo_url_temp })

      reps.push(rep)
    end

    reps
  end
end
