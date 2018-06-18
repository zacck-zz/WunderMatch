defmodule WunderMatch.Matching.Matcher do
  @moduledoc """
  This is a Boundary module containing functions we need for the matching
  context.
  Use this module to
  1. Construct point locations
  2. Construct Polygon Areas
  3. Maintain a list of Areas
  4. Match locations to areas
  5. Maintain a list of matched locations to areas
  """
  alias Geo.Point
  alias WunderMatch.Matching.Location

  @doc """
  This function builds a Location.
  It expects an attribute named coordinate which is expected to be a Geo.Point
  """
  @spec point({number(), number()}) :: {:ok, Location.t()} | {:error, String.t()}
  def point({lon, lat}) when is_number(lon) and is_number(lat) do
    point = %Point{coordinates: {lat, lon}}
    location = %Location{coordinate: point}
    {:ok, location}
  end

  def point(_) do
    {:error, "Point expects numbers for your x and y locations"}
  end
end
