defmodule AppApi.Convert do
  @epoch 62167219200

  def from_timestamp(timestamp) do
    timestamp
    |> Kernel.+(@epoch)
    |> :calendar.gregorian_seconds_to_datetime
  end

  def to_timestamp(datetime) do
    datetime
    |> NaiveDateTime.to_erl
    |> :calendar.datetime_to_gregorian_seconds
    |> Kernel.-(@epoch)

  end
end
