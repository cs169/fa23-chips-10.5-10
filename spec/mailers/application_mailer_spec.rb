# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'model_helper'

ModelHelper.initial_check

describe ApplicationMailer do
  describe 'testing dummy method' do
    before do
      @user1 = ModelHelper.init_github_user
    end

    let(:mailer) { instance_double(described_class) }

    it 'call mail method' do
      allow(mailer).to receive(:mail).with('test').and_return(true)
      res = mailer.mail('test')
      expect(res).to be(true)
    end
  end
end
