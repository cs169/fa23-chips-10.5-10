# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'model_helper'

ModelHelper.initial_check

describe CampaignFinancesController do
  describe 'GET index' do
    it 'correctly maps the category name' do
      category = 'candidate-loan'
      cycle = '2020'
      get :index, params: { category: category, cycle: cycle }
      expect(assigns(:category_correct)).to eq('candidate_loans')
    end
  end
end
