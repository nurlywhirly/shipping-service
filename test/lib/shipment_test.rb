require 'test_helper'

class ShipmentTest < ActiveSupport::TestCase
  PACKAGE_PARAMS = {
    weight: 3.5,
    length: 15,
    width: 10,
    height: 4.5
  }

  LOCATION_PARAMS = {
    country: "US",
    state: "CA",
    city: "Los Angeles",
    billing_zip: "90078"
  }

  test "the truth" do
    assert true
  end

  test "self.package creates a package object" do
    test_package = Shipment.package(3.5, 15, 10, 4.5)
    assert_instance_of ActiveShipping::Package, test_package

    assert_equal PACKAGE_PARAMS[:weight], test_package.pounds
    assert_equal [4.5,10,15], test_package.inches
  end

  test "self.origin creates a location object" do
    test_origin = Shipment.origin
    assert_instance_of ActiveShipping::Location, test_origin

    assert_equal test_origin.city, "Seattle"
    assert_equal test_origin.state, "WA"
  end

  test "self.destination creates a location object" do
    test_destination = Shipment.destination(LOCATION_PARAMS)
    assert_instance_of ActiveShipping::Location, test_destination

    puts "#{test_destination}"
    assert_equal LOCATION_PARAMS[:city], test_destination.city
    assert_equal LOCATION_PARAMS[:state], test_destination.state
    assert_equal LOCATION_PARAMS[:billing_zip], test_destination.postal_code
    assert_equal LOCATION_PARAMS[:country], test_destination.country_code
  end
end
