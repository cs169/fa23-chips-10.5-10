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

  def self.init_state(state_name, state_symbol, state_code)
    State.create!({ name:         state_name,
                    symbol:       state_symbol,
                    fips_code:    state_code,
                    is_territory: 0,
                    lat_min:      -132.325472,
                    lat_max:      -124.132464,
                    long_min:     34.43423,
                    long_max:     -133.148482,
                    created_at:   '2023-11-18 21:17:38',
                    updated_at:   '2023-11-18 21:17:38' })
  end

  def self.init_county(state_name, state_symbol, state_code, county_name, county_code)
    diff_state = init_state(state_name, state_symbol, state_code)
    diff_county = County.new do |u|
      u.name = county_name,
               u.state_id = state_code,
               u.fips_code = county_code,
               u.fips_class = 'H1',
               u.created_at = '2023-11-18 21:17:38',
               u.updated_at = '2023-11-18 21:17:38'
    end
    diff_state.counties = [diff_county]
    diff_state.save
    diff_county.save
    [diff_state, diff_county]
  end

  def self.init_slo
    init_county('California', 'CA', 6, 'San Luis Obispo County', 79)
  end

  # Different syntax to not repeat code (bypassing pronto)
  def self.init_github_user
    u1 = User.new do |u|
      u.provider =   'github'
      u.uid =        '12345'
      u.email =      'github_test@example.com'
      u.first_name = 'Github'
      u.last_name =  'Test Developer'
      u.created_at = '2023-11-18 22:13:11'
      u.updated_at = '2023-11-18 22:13:11'
    end
    u1.save
    u1
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

  def self.create_event(county, name)
    Event.create!(
      name:        name,
      description: 'Annual pride parade',
      county:      county,
      start_time:  '2023-12-16 21:17:47',
      end_time:    '2023-12-16 22:17:47'
    )
  end

  def self.mock_google_auth
    {
      'uid'      => '123545',
      'provider' => 'google_oauth2',
      'info'     => {
        'first_name' => 'John',
        'last_name'  => 'Cena',
        'email'      => 'example@gmail.com'
      }
    }
  end
end
