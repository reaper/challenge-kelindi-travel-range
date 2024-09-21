require "application_system_test_case"

class CitiesTest < ApplicationSystemTestCase
  test 'success to visit cities with specific query' do
    Rails.application.load_seed
    visit(cities_url)

    fill_in('form-latitude', with: "48.08")
    fill_in('form-longitude', with: "-1.68")
    fill_in('form-radius', with: "600")
    click_on('form-submit')

    assert_selector('.cities .city', count: 6)

    [
      { capital: 'Saint Helier', country: 'Jersey' },
      { capital: 'St Peter Port', country: 'Guernsey' },
      { capital: 'Paris', country: 'France' },
      { capital: 'London', country: 'United Kingdom' },
      { capital: 'Brussels', country: 'Belgium' },
      { capital: 'Luxembourg', country: 'Luxembourg' }
    ].each do |element|
      assert_selector('.cities .city span.capital', text: element[:capital], visible: true)
      assert_selector('.cities .city span.country', text: element[:country], visible: true)
    end
  end
end
