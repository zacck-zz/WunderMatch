defmodule WunderMatch.Matching.UtilsTest do
  use ExUnit.Case

  alias WunderMatch.Matching.Utils

  @text_item "lon,lat"
  @num_item "2,3"
  @item {2, 3}
  describe "Utils" do
    test "can filter a num var out item" do
      assert Utils.number_filter(@num_item) == true

      assert Utils.number_filter(@text_item) == false
    end

    test "can split a line from csv file" do
      assert Utils.process_item(@num_item) == @item
    end
  end
end
