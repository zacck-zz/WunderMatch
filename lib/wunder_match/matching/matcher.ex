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
  alias Geo.{Point, Polygon}
  alias WunderMatch.Matching.{Location, Area, Utils}

  @type coordinates() :: {number(), number()}
  @type match_error() :: {:error, String.t()}

  @doc """
  This function builds a Location.
  It expects an attribute named coordinate which is expected to be a Geo.Point
  """
  @spec point(coordinates()) :: {:ok, Location.t()}
  @spec point(any()) :: match_error()
  def point({lon, lat}) when is_number(lon) and is_number(lat) do
    point = %Point{coordinates: {lat, lon}}
    location = %Location{coordinate: point}
    {:ok, location}
  end

  def point(_) do
    {:error, "Point expects numbers for your x and y locations"}
  end

  @doc """
  This function builds an area using a list of coordinates passed to it
  """
  @spec area(list(coordinates())) :: {:ok, Area.t()} | match_error()
  def area(coords) do
    # flip the positions of th the elements to use the correct axis
    lat_lons = Enum.map(coords, fn {y, x} -> {x, y} end)
    bound = %Polygon{coordinates: [lat_lons]}

    area = %Area{bound: bound}
    {:ok, area}
  end

  @doc """
  This function builds a list of coordinates from a csv file with 2 columns
  As it goes through  the file it should discard any invalid coordinates
  Which for now is any value  that isn't numeric
  """
  @spec ingest(String.t()) :: {:ok, list(coordinates())} | match_error()
  def ingest(path) do
    items =
      File.stream!(path)
      |> Stream.map(&String.replace(&1, "\n", ""))
      |> Stream.filter(&Utils.number_filter/1)
      |> Stream.map(&Utils.process_item/1)
      |> Enum.to_list()

    {:ok, items}
  end
end
