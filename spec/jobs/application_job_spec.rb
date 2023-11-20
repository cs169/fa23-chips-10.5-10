# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'model_helper'

ModelHelper.initial_check

describe ApplicationJob do
  describe 'testing dummy method' do
    before do
      @user1 = ModelHelper.init_github_user
    end

    let(:job) { instance_double(described_class) }

    it 'ensure existance' do
      res = job.null_object?
      expect(res).to be(false)
    end
  end
end
