# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'model_helper'

ModelHelper.initial_check

describe State do
  describe 'testing state method' do
    before do
      @cali = ModelHelper.init_california
    end

    it 'call std_fips_code' do
      res = @cali.std_fips_code
      expect(res).to eq '06'
    end
  end
end
