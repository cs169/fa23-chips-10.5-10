# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'model_helper'

ModelHelper.initial_check

describe ApplicationHelper do
  describe 'testing state method' do
    before do
      @cali = ModelHelper.init_california

      @other_state = State.create!({ name:         'OtherState',
                                     symbol:       'OS',
                                     fips_code:    7,
                                     is_territory: 0,
                                     lat_min:      -123.32432,
                                     lat_max:      -114.13324,
                                     long_min:     32.423423,
                                     long_max:     -113.1432,
                                     created_at:   '2023-11-18 21:17:37',
                                     updated_at:   '2023-11-18 21:17:37' })
    end

    it 'call state_ids_by_name' do
      res = described_class.state_ids_by_name
      expect(res).to eq({ 'California' => 1, 'OtherState' => 2 })
    end

    it 'call state_symbols_by_name' do
      res = described_class.state_symbols_by_name
      expect(res).to eq({ 'California' => 'CA', 'OtherState' => 'OS' })
    end

    it 'call nav_items' do
      res = described_class.nav_items
      expect(res).to eq([{ link: '/', title: 'Home' },
                         { link: '/events', title: 'Events' },
                         { link: '/representatives', title: 'Representatives' }])
    end
  end
end
