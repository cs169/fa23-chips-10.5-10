# frozen_string_literal: true

module RepresentativesHelper
  def self.get_address(official)
    address_temp = ''
    city_temp = ''
    state_temp = ''
    zip_temp = ''
    if official.address &&
       official.address[0]
      address_temp = official.address[0].line1 if official.address[0].line1

      city_temp = official.address[0].city if official.address[0].city

      state_temp = official.address[0].state if official.address[0].state

      zip_temp = official.address[0].zip if official.address[0].zip
    end
    [address_temp, city_temp, state_temp, zip_temp]
  end

  def self.get_title_and_ocdid(offices, index)
    title = ''
    ocdid = ''
    offices.each do |office|
      if office.official_indices.include? index
        title = office.name
        ocdid = office.division_id
      end
    end
    [title, ocdid]
  end
end
