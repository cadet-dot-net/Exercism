defmodule Newsletter do
  def read_emails(path) do
    path
    |> File.read!()
    |> String.split("\n", trim: true)
  end

  def open_log(path), do: File.open!(path, [:write])

  def log_sent_email(pid, email), do: IO.puts(pid, email)

  def close_log(pid), do: File.close(pid)

  def send_newsletter(emails_path, log_path, send_fun) do
    log_file = open_log(log_path)

    for email <- read_emails(emails_path),
        send_fun.(email) == :ok,
        do: log_sent_email(log_file, email)

    close_log(log_file)
  end
end
