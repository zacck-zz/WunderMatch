defmodule WunderMatch.Matching.MatcherTest do
  @moduledoc """
  This module contains the test for the Matching boundary module
  """
  use ExUnit.Case
  alias WunderMatch.Matching.{Matcher, Location}

  @lon_lat {120.99206, 14.7583}
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
  end
end
