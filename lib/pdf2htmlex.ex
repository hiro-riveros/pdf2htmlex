defmodule Pdf2htmlex do
  def open(pdf) when is_binary(pdf), do: [pdf]
  def save_to(opts, dir) when is_list(opts), do: ["--dest-dir", dir] ++ opts
  def convert!(opts) when is_list(opts), do: exec_cmd opts

  def zoom(opts, zoom_ratio) when is_list(opts) and is_float(zoom_ratio), do: ["--zoom", f_to_s(zoom_ratio)] ++ opts
  def first_page(opts, first) when is_list(opts) and is_integer(first), do: ["--first-page", i_to_s(first)] ++ opts
  def last_page(opts, last) when is_list(opts) and is_integer(last), do: ["--last-page", i_to_s(last)] ++ opts
  def fit_width(opts, width) when is_list(opts) and is_integer(width), do: ["--fit-width", i_to_s(width)] ++ opts
  def fit_height(opts, height) when is_list(opts) and is_integer(height), do: ["--fit-height", i_to_s(height)] ++ opts

  defp exec_cmd(opts) do
    cmd = System.find_executable("pdf2htmlex")
    System.cmd(cmd, opts, stderr_to_stdout: true)
  end

  defp i_to_s(s), do: Integer.to_string(s)
  defp f_to_s(f), do: Float.to_string(f, [decimals: 1, compact: true])
end
