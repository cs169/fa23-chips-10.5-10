# frozen_string_literal: true

class Representative < ApplicationRecord
  include RepresentativesHelper
  has_many :news_items, dependent: :delete_all

  # validates :address, :city, :state, :zip, :party, :photo_url, presence: true

  def self.civic_api_to_representative_params(rep_info)
    reps = []
    rep_info.officials.each_with_index do |official, index|
      info = RepresentativesHelper.get_title_and_ocdid(rep_info.offices, index)
      title_temp = info[0]
      ocdid_temp = info[1]
      out = RepresentativesHelper.get_address(official)
      address_temp = out[0]
      city_temp = out[1]
      state_temp = out[2]
      zip_temp = out[3]
      party_temp = ''
      photo_url_temp = ''
      party_temp = official.party if official.party
      photo_url_temp = official.photo_url if official.photo_url

      rep = Representative.find_or_create_by({ name: official.name, ocdid: ocdid_temp,
      title: title_temp, address: address_temp, city: city_temp, state: state_temp,
      zip: zip_temp, party: party_temp, photo_url: photo_url_temp })

      reps.push(rep)
    end
    reps
  end
end
