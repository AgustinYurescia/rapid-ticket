# frozen_string_literal: true

require 'test_helper'
require 'ffaker'
require 'json'

class ShowsControllerTest < ActionController::TestCase
  def setup
    @place = Place.create(city: 'Ciudad de prueba', state: 'Provincia de prueba',
      country: 'Pais de prueba', name: FFaker::Company.name, address: FFaker::Address.street_address)

    @location_1 = Location.create(location_number: 1, location_row: 1, place_id: @place)
    @location_2 = Location.create(location_number: 1, location_row: 2, place_id: @place)
    @location_3 = Location.create(location_number: 1, location_row: 3, place_id: @place)

    @show_1 = Show.create(day_and_hour: DateTime.now + 1, name: FFaker::Lorem.words(2).join(' '),
    show_type: 'music',  place_id: @place.id)
    @show_2 = Show.create(day_and_hour: DateTime.now + 30, name: FFaker::Lorem.words(2).join(' '),
    show_type: 'music',  place_id: @place.id)
    @show_3 = Show.create(day_and_hour: DateTime.now + 60, name: FFaker::Lorem.words(2).join(' '),
    show_type: 'music',  place_id: @place.id)

    @section_1 = Section.create(price: 500, currency: 'ARS', name: FFaker::Lorem.words(1), show_id: @show_1.id,  without_numeration: true, available_locations_count: 3)
    @section_2 = Section.create(price: 800, currency: 'ARS', name: FFaker::Lorem.words(1), show_id: @show_2.id,  without_numeration: true, available_locations_count: 3)
    @section_3 = Section.create(price: 900, currency: 'ARS', name: FFaker::Lorem.words(1), show_id: @show_3.id,  without_numeration: true, available_locations_count: 3)

    @section_location_1_1 = SectionLocation.create(section_id: @section_1.id, location_id: @location_1)
    @section_location_1_2 = SectionLocation.create(section_id: @section_1.id, location_id: @location_2)
    @section_location_1_3 = SectionLocation.create(section_id: @section_1.id, location_id: @location_3)

    @section_location_2_1 = SectionLocation.create(section_id: @section_2.id, location_id: @location_1)
    @section_location_2_2 = SectionLocation.create(section_id: @section_2.id, location_id: @location_2)
    @section_location_2_3 = SectionLocation.create(section_id: @section_2.id, location_id: @location_3)

    @section_location_3_1 = SectionLocation.create(section_id: @section_3.id, location_id: @location_1)
    @section_location_3_2 = SectionLocation.create(section_id: @section_3.id, location_id: @location_2)
    @section_location_3_3 = SectionLocation.create(section_id: @section_3.id, location_id: @location_3)
  end

  test 'index_method: index_without_filters_and_sort' do
    get :index
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_not_nil json_response['shows']
    assert_not_nil json_response['page_info']

    expected_response = {
      shows: [@show_1, @show_2, @show_3],
      page_info: {
        current_page: 1,
        total_pages: 1
      }
    }

    assert_equal(expected_response.as_json, json_response)
  end

  test 'index_method: index_with_date_filters' do
    get :index, params: { date_from: DateTime.now.strftime('%Y-%m-%d'), date_to: (DateTime.now + 7).strftime('%Y-%m-%d') }
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_not_nil json_response['shows']
    assert_not_nil json_response['page_info']

    expected_response = {
      shows: [@show_1],
      page_info: {
        current_page: 1,
        total_pages: 1
      }
    }

    assert_equal(expected_response.as_json, json_response)
  end

  test 'index_method: index_with_price_filters' do
    get :index, params: { min_price: 600, max_price: 850 }
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_not_nil json_response['shows']
    assert_not_nil json_response['page_info']

    expected_response = {
      shows: [@show_2],
      page_info: {
        current_page: 1,
        total_pages: 1
      }
    }

    assert_equal(expected_response.as_json, json_response)
  end

  test 'get_available_sections_method: get_available_sections_for_a_show' do
    get :get_available_sections, params: { show_id: @show_1.id }
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_not_nil json_response['sections']

    expected_response = {
      sections: [@section_1],
    }

    assert_equal(expected_response.as_json, json_response)
  end

  test 'get_available_locations_for_sections_method: get_available_locations_for_a_section_of_a_show' do
    get :get_available_locations_for_section, params: { show_id: @show_1.id, section_id: @section_1.id }
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_not_nil json_response['available_locations']

    expected_response = {
      available_locations: {
        message: 'Locations without numeration',
        locations_availables: @section_1.available_locations_count,
        price: @section_1.price
      }
    }
    assert_equal(expected_response.as_json, json_response)
  end
end
