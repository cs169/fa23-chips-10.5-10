# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'model_helper'

ModelHelper.initial_check

describe EventsController do
  describe 'event controller methods' do
    before do
      arr = ModelHelper.init_slo
      @cali = arr[0]
      @slo = arr[1]

      @diff_state = ModelHelper.init_state('DiffState', 'DF', 8)
      @diff_county = County.new do |u|
        u.name = 'Diff County',
                 u.state_id = 8,
                 u.fips_code = 34,
                 u.fips_class = 'H1',
                 u.created_at = '2023-11-18 21:17:38',
                 u.updated_at = '2023-11-18 21:17:38'
      end

      @diff_state.counties = [@diff_county]

      @diff_state.save
      @diff_county.save

      @event_slo = ModelHelper.create_event(@slo, 'Pride Parade')

      @event_diff_county = ModelHelper.create_event(@diff_county, 'Other Parade')
    end

    it 'call index without filter' do
      get :index, params: { 'state' => 'CA', 'county' => '79' }
      expect(response).to render_template :index
      expect(assigns(:events)).to eq([@event_slo, @event_diff_county])
    end

    it 'call index with filter' do
      get :index, params: { 'state' => 'CA', 'county' => '79', 'filter-by' => 'state-only' }
      expect(response).to render_template :index
      expect(assigns(:events)).to eq([@event_slo])
    end

    it 'call show' do
      get :show, params: { 'id' => '1' }
      expect(response).to render_template :show
      expect(assigns(:event)).to eq(@event_slo)
    end
  end
end
