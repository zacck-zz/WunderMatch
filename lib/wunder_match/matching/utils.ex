defmodule WunderMatch.Matching.Utils do
  @moduledoc """
  This module contains some helper functions for processing items
  When ingesting them from csvs
  """

  @doc """
  This function takes in a String containing a latitude and a longitude
  and splits them using the comma between to a pair
  """
  @spec process_item(String.t()) :: {number(), number()}
  def process_item(item) do
    [h, t] = String.split(item, ",")

    {lon, _} = Float.parse(h)

    {lat, _} = Float.parse(t)

    {lon, lat}
  end

  @doc """
  This function checks any string that is passed in on whether it contains an
  Alphabetic character. It returns true if all the characters are numbers and false
  if any of the characters is Alphabetic
  """
  @spec number_filter(String.t()) :: boolean()
  def number_filter(item) do
    regex = ~r/[a-zA-Z]/

    case Regex.run(regex, item) do
      nil ->
        true

      [_] ->
        false
    end
  end
end
