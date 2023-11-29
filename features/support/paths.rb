
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'
    when /^the Alameda County's Representatives Page$/
      '/search/Alameda%20County'
    when /^California State Map$/
      'https://parkingsharp-inviteclaudia-3000.codio.io/state/CA'
    end
  end
end

World(NavigationHelpers)
