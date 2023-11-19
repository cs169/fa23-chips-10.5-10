# frozen_string_literal: true

class ModelHelper
  def initialize
    puts 'None'
  end

  def self.init_california
    State.create!({ name:         'California',
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

  def self.init_slo
    cali = init_california

    slo = County.new do |u|
      u.name = 'San Luis Obispo County',
               u.state_id = 6,
               u.fips_code = 79,
               u.fips_class = 'H1',
               u.created_at = '2023-11-18 21:17:38',
               u.updated_at = '2023-11-18 21:17:38'
    end

    cali.counties = [slo]

    cali.save
    slo.save
    [cali, slo]
  end

  def self.init_github_user
    User.create!({
                   provider:   'github',
                   uid:        '12345',
                   email:      'github_test@example.com',
                   first_name: 'Github',
                   last_name:  'Test Developer',
                   created_at: '2023-11-18 22:13:11',
                   updated_at: '2023-11-18 22:13:11'
                 })
  end

  def self.init_google_user
    User.create!({
                   provider:   'google_oauth2',
                   uid:        '100000000000000000000',
                   email:      'google_test@example.com',
                   first_name: 'Google',
                   last_name:  'Test Developer',
                   created_at: '2023-11-18 22:12:50',
                   updated_at: '2023-11-18 22:12:50'
                 })
  end

  def self.initial_check
    return unless RUBY_VERSION >= '2.6.0'

    if Rails.version < '5'
      puts 'Problem to address'
      # class ActionController::TestResponse < ActionDispatch::TestResponse
      #   def recycle!
      #     @mon_mutex_owner_object_id = nil
      #     @mon_mutex = nil
      #     initialize
      #   end
      # end
    else
      puts 'Monkeypatch for ActionController::TestResponse no longer needed'
    end
  end
end
