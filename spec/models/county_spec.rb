# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'model_helper'

ModelHelper.initial_check

describe County do
  describe 'testing state method' do
    before do
      arr = ModelHelper.init_slo
      @cali = arr[0]
      @slo = arr[1]
    end

    it 'call std_fips_code' do
      res = @slo.std_fips_code
      expect(res).to eq '079'
    end
  end
end
