defmodule ContexLinePlotTest do
  use ExUnit.Case

  alias Contex.{CategoryColourScale, Dataset, LinePlot, Plot}
  import SweetXml

  setup do
    plot =
      Dataset.new([{1, 2, 3, 4}, {4, 5, 6, 4}, {-3, -2, -1, 0}], ["aa", "bb", "cccc", "d"])
      |> LinePlot.new()

    %{plot: plot}
  end

  describe "smooth line plotting" do
    test "points to smoothed points" do
      points = [
        {20, 380},
        {58, 342},
        {100, 342},
        {100, 300},
        {140, 250},
        {190, 210},
        {220, 197},
        {250, 184},
        {280, 155},
        {310, 260},
        {404, 20}
      ]

      expected_output = """
      d=M20,380
      C26.333333333333332,373.6666666666667 44.666666666666664,348.3333333333333 58,342
      C71.33333333333333,335.6666666666667 93,349 100,342
      C107,335 93.33333333333333,315.3333333333333 100,300
      C106.66666666666667,284.6666666666667 125,265 140,250
      C155,235 176.66666666666666,218.83333333333334 190,210
      C203.33333333333334,201.16666666666666 210,201.33333333333334 220,197
      C230,192.66666666666666 240,191 250,184
      C260,177 270,142.33333333333334 280,155
      C290,167.66666666666666 289.3333333333333,282.5 310,260
      C330.6666666666667,237.5 388.3333333333333,60 404,20 "
      """

      output = Contex.SVG.line(points, true) |> IO.iodata_to_binary()
      IO.inspect(output)
    end
  end
end
