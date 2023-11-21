# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'model_helper'

ModelHelper.initial_check

describe MapController do
  describe 'map controller method' do
    before do
      arr = ModelHelper.init_slo
      @cali = arr[0]
      @slo = arr[1]

      arr2 = ModelHelper.init_county('DiffState', 'DF', 8, 'Diff County', 34)
      @diff_state = arr2[0]
      @diff_county = arr2[1]

      @diff_state_no_county = ModelHelper.init_state('AnotherState', 'AS', 10)

      @event_slo = ModelHelper.create_event(@slo, 'Pride Parade')

      @event_diff_county = ModelHelper.create_event(@diff_county, 'Other Parade')
    end

    it 'call index' do
      get :index, params: { 'state' => 'CA', 'county' => '79' }
      expect(response).to render_template :index
      expect(assigns(:states)).to eq(State.all)
      expect(assigns(:states_by_fips_code)).to eq({ '08' => @diff_state, '06' => @cali, '10' => @diff_state_no_county })
    end

    it 'call state with valid state' do
      get :state, params: { 'state_symbol' => 'CA' }
      expect(response).to render_template :state
      expect(assigns(:state)).to eq(@cali)
      expect(assigns(:county_details)).to eq(@cali.counties.index_by(&:std_fips_code))
    end

    it 'call state with invalid state' do
      get :state, params: { 'state_symbol' => 'Cadfa' }
      expect(response).to redirect_to(root_path)
    end

    it 'call county with valid county' do
      get :county, params: { 'state_symbol' => 'CA', 'std_fips_code' => '79' }
      expect(response).to render_template :county
      expect(assigns(:state)).to eq(@cali)
      expect(assigns(:county)).to eq(@slo)
      expect(assigns(:county_details)).to eq(@cali.counties.index_by(&:std_fips_code))
    end

    it 'call county with invalid county' do
      get :county, params: { 'state_symbol' => 'AS', 'std_fips_code' => '12' }
      expect(response).to redirect_to(root_path)
    end
  end
end
