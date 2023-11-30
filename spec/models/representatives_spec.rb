# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

ModelHelper.initial_check

describe Representative do
  describe 'testing civic method' do
    before do
      described_class.create!({ name: 'Joseph R. Biden',
        ocdid: 'ocd-division/country:us', title: 'President of the United States' })

      @address_mock = double
      allow(@address_mock).to receive(:line1).and_return('line1 new')
      allow(@address_mock).to receive(:city).and_return('biden city')
      allow(@address_mock).to receive(:state).and_return('biden state')
      allow(@address_mock).to receive(:zip).and_return('biden zip')

      @official_mock = double
      allow(@official_mock).to receive(:name).and_return('Joe Biden')
      allow(@official_mock).to receive(:address).and_return([@address_mock])
      allow(@official_mock).to receive(:party).and_return('biden party')
      allow(@official_mock).to receive(:photo_url).and_return('biden photo url')

      @office_mock = double
      allow(@office_mock).to receive(:name).and_return('President of the United States')
      allow(@office_mock).to receive(:division_id).and_return('ocd-division/country:us')
      allow(@office_mock).to receive(:official_indices).and_return([0])

      @rep_info = double
      allow(@rep_info).to receive(:officials).and_return([@official_mock])
      allow(@rep_info).to receive(:offices).and_return([@office_mock])

      described_class.civic_api_to_representative_params(@rep_info)
    end

    it 'call civic method' do
      res = described_class.civic_api_to_representative_params(@rep_info)
      expect(res.length).to eq 1
      @biden_entries = described_class.where(name: 'Joe Biden')
      p @biden_entries
      expect(@biden_entries.size).to eq 1
    end
  end
end
