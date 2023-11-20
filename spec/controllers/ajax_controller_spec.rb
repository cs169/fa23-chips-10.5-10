# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'model_helper'

ModelHelper.initial_check

describe AjaxController do
  describe 'rendering county json' do
    before do
      ModelHelper.init_slo

      @diff_state = ModelHelper.init_state('DiffState', 'DF', 8)
      @expected_output = [{ 'created_at' => '2023-11-18T21:17:38.000Z', 'fips_class' => 'H1', 'fips_code' => 79,
      'id' => 1,
      'name' => '["San Luis Obispo County", 6, 79, "H1", "2023-11-18 21:17:38", "2023-11-18 21:17:38"]',
      'state_id' => 1,
      'updated_at' => '2023-11-18T21:17:38.000Z' }]
    end

    it 'call counties' do
      get :counties, params: { 'state_symbol' => 'CA' }, format: :json
      parsed_body = JSON.parse(response.body)
      expect(parsed_body).to eq @expected_output
    end
  end
end
