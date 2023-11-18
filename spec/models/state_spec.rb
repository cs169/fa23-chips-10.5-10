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

describe State do
  describe 'testing state method' do
    before do
      @cali = described_class.create!({ name:         'California',
                                        symbol:       'CA',
                                        fips_code:    6,
                                        is_territory: 0,
                                        lat_min:      -124.409591,
                                        lat_max:      -114.131211,
                                        long_min:     32.534156,
                                        long_max:     -114.131211,
                                        created_at:   '2023-11-18 21:17:34',
                                        updated_at:   '2023-11-18 21:17:34' })
    end

    it 'call std_fips_code' do
      res = @cali.std_fips_code
      expect(res).to eq '06'
    end
  end
end
