Feature: County Map Interactivity
  As a user of the application
  So that I can view a list of representatives from a county
  I want to click on a county in the county map

Background: 
  Given I am on California State Map

Scenario: Clicking on a county triggers the correct url
  When I press "Counties in California"
  When I click on the "View" link for "Alameda County"
  Then I should be on the Alameda County's Representatives Page