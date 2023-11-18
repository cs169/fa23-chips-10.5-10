# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

if RUBY_VERSION >= '2.6.0'
  if Rails.version < '5'
    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        @mon_mutex_owner_object_id = nil
        @mon_mutex = nil
        initialize
      end
    end
  else
    puts 'Monkeypatch for ActionController::TestResponse no longer needed'
  end
end

describe Event do
  describe 'testing state method' do
    before do
      @cali = State.create!({ name:         'California',
                              symbol:       'CA',
                              fips_code:    6,
                              is_territory: 0,
                              lat_min:      -124.409591,
                              lat_max:      -114.131211,
                              long_min:     32.534156,
                              long_max:     -114.131211,
                              created_at:   '2023-11-18 21:17:34',
                              updated_at:   '2023-11-18 21:17:34' })

      @slo = County.new do |u|
        u.name = 'San Luis Obispo County',
                 u.state_id = 6,
                 u.fips_code = 79,
                 u.fips_class = 'H1',
                 u.created_at = '2023-11-18 21:17:38',
                 u.updated_at = '2023-11-18 21:17:38'
      end

      @cali.counties = [@slo]

      @cali.save
      @slo.save

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
