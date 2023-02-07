defmodule FileSniffer do
  def media do
    %{
      "exe" => %{
        media_type: "application/octet-stream",
        signature: <<0x7F, 0x45, 0x4C, 0x46>>
      },
      "bmp" => %{
        media_type: "image/bmp",
        signature: <<0x42, 0x4D>>
      },
      "png" => %{
        media_type: "image/png",
        signature: <<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A>>
      },
      "jpg" => %{
        media_type: "image/jpg",
        signature: <<0xFF, 0xD8, 0xFF>>
      },
      "gif" => %{
        media_type: "image/gif",
        signature: <<0x47, 0x49, 0x46>>
      }
    }
  end

  def type_from_extension(extension), do: media()[extension][:media_type]

  def type_from_binary(file_binary) do
    {ext, _media} =
      Enum.find(media(), fn {_media, %{signature: sig}} ->
        has_signature?(file_binary, sig)
      end) || {:error, nil}

    type_from_extension(ext)
  end

  def verify(file_binary, extension) do
    file_type = type_from_binary(file_binary)

    if file_type == type_from_extension(extension) do
      {:ok, file_type}
    else
      {:error, "Warning, file format and file extension do not match."}
    end
  end

  defp binary_size(bin), do: bin |> String.codepoints() |> length()

  defp has_signature?(file_binary, signature) do
    sig_size = binary_size(signature)

    if binary_size(file_binary) >= sig_size do
      <<head::binary-size(sig_size), _body::binary>> = file_binary
      head == signature
    else
      false
    end
  end
end
