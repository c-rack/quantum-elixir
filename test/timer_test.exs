defmodule Quantum.TimerTest do
  use ExUnit.Case

  test "tick function returns correct time when timezone is set" do
    current_time_zone = Application.get_env(:quantum, :timezone, :utc)

    Application.put_env(:quantum, :timezone, :utc)
    {d_utc, {h_utc, m_utc, _}} = :calendar.now_to_universal_time(:os.timestamp)
    assert Quantum.Timer.tick == {d_utc, h_utc, m_utc}

    Application.put_env(:quantum, :timezone, :local)
    {d_local, {h_local, m_local, _}} = :calendar.now_to_local_time(:os.timestamp)
    assert Quantum.Timer.tick == {d_local, h_local, m_local}

    Application.put_env(:quantum, :timezone, "America/Chicago")
    {d_local, {h_local, m_local, _}} = Quantum.Timer.custom("America/Chicago", :os.timestamp)
    assert Quantum.Timer.tick == {d_local, h_local, m_local}

    Application.put_env(:quantum, :timezone, current_time_zone)
  end
end
