# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'model_helper'

ModelHelper.initial_check

describe Event do
  describe 'testing state method' do
    before do
      arr = ModelHelper.init_slo
      @cali = arr[0]
      @slo = arr[1]

      @event = described_class.create!(
        name:        'Pride Parade',
        description: 'Annual pride parade',
        county:      @slo,
        start_time:  '2023-12-16 21:17:47',
        end_time:    '2023-12-16 22:17:47'
      )
    end

    it 'call county_names_by_id' do
      res = @event.county_names_by_id
      expect(res).to eq [@slo].map { |c| [c.name, c.id] }.to_h
    end
  end
end
