defmodule WunderMatch.Matching.MatcherTest do
  @moduledoc """
  This module contains the test for the Matching boundary module
  """
  use ExUnit.Case
  alias WunderMatch.Matching.{Matcher, Location, Area}

  @lon_lat {120.99206, 14.7583}

  @points [
    {120.99287, 14.75659},
    {120.99206, 14.756699999999999},
    {120.99203999999999, 14.756939999999998},
    {120.99207999999999, 14.757139999999998}
  ]

  @error_lat {"name", 829.9}
  describe "Matching " do
    test "constructs a point from lat long tuple" do
      {:ok, %Location{} = location} = Matcher.point(@lon_lat)
      assert is_binary(location.id)
      assert %Geo.Point{} = location.coordinate
    end

    test "errors out if not provided with a number tuple" do
      {:error, message} = Matcher.point(@error_lat)

      assert message == "Point expects numbers for your x and y locations"
    end

    test "constructs an area from a list of lon_lat tuples" do
      {:ok, %Area{} = area} = Matcher.area(@points)

      assert is_binary(area.id)
      assert %Geo.Polygon{} = area.bound
    end
  end
end
