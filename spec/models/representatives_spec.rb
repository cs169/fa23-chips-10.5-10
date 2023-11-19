# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

ModelHelper.initial_check

describe Representative do
  describe 'testing civic method' do
    before do
      described_class.create!({ name: 'Joseph R. Biden',
        ocdid: 'ocd-division/country:us', title: 'President of the United States' })

      @official_mock = double
      allow(@official_mock).to receive(:name).and_return('Joseph R. Biden')

      @office_mock = double
      allow(@office_mock).to receive(:name).and_return('President of the United States')
      allow(@office_mock).to receive(:division_id).and_return('ocd-division/country:us')
      allow(@office_mock).to receive(:official_indices).and_return([0])

      @rep_info = double
      allow(@rep_info).to receive(:officials).and_return([@official_mock])
      allow(@rep_info).to receive(:offices).and_return([@office_mock])
    end

    it 'call civic method' do
      res = described_class.civic_api_to_representative_params(@rep_info)
      expect(res.length).to eq 1
      @biden_entries = described_class.where(name: 'Joseph R. Biden')
      expect(@biden_entries.size).to eq 1
    end
  end
end
