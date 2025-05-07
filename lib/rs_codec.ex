defmodule RSProtect do
  @moduledoc """
  Reed-Solomon encoder/decoder wrapper using Rust NIF.

  Wraps the `reed-solomon` Rust crate to provide robust
  error-correcting codes for binary data. This library is suitable for
  transmitting binary packets over noisy links with optional parity.

  ## Examples

      iex> {:ok, codeword} = RSProtect.encode("hello", 4)
      iex> {:ok, original} = RSProtect.correct(codeword, 4)
      iex> original == "hello"
      true
  """
  use Rustler, otp_app: :rs_protect, crate: "rs_protect_nif"

  @doc """
  Encodes a binary by appending N parity bytes for error correction.

  ## Parameters
  - `data`: binary to encode
  - `parity_bytes`: number of bytes to use as parity (must be >= 2)

  ## Returns
  - `{:ok, binary}` with appended parity
  - `:error` on failure
  """
  def encode(_data, _parity_bytes), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Encodes a binary by appending N parity bytes for error correction.
  As encode/2, except that it only returns the parity bytes.
  """
  def encode_ecc(_data, _parity_bytes), do: :erlang.nif_error(:nif_not_loaded)

  @doc false
  @spec correct(binary(), non_neg_integer()) :: {:ok, binary()} | {:error, any()}
  def correct(codeword, parity_bytes), do: correct(codeword, parity_bytes, nil)

  @doc """
  Decode/correct a binary codeword and attempts to correct up to N/2 errors.

  ## Parameters
  - `codeword`: binary of data + parity
  - `parity_bytes`: number of parity bytes originally used
  - 'known_erasures': offsets of known erasures (optional)

  ## Returns
  - `{:ok, original_data}` on success
  - `:error` if the message cannot be corrected
  """
  def correct(_codeword, _parity_bytes, _known_erasures), do: :erlang.nif_error(:nif_not_loaded)
  @spec correct(binary(), non_neg_integer(), [byte()]) :: {:ok, binary()} | {:error, any()}

  @doc false
  @spec correct_err_count(binary(), non_neg_integer()) :: {:ok, {binary(), non_neg_integer()}} | {:error, any()}
  def correct_err_count(codeword, parity_bytes), do: correct_err_count(codeword, parity_bytes, nil)

  @doc """
  Decode/Correct a binary codeword and attempts to correct up to N/2 errors.
  Same as `correct/2`, but returns the number of errors corrected.

  ## Parameters
  - `codeword`: binary of data + parity
  - `parity_bytes`: number of parity bytes originally used
  - 'known_erasures': offsets of known erasures (optional)

  ## Returns
  - `{:ok, original_data, err_count}` on success
  - `:error` if the message cannot be corrected
  """
  def correct_err_count(_codeword, _parity_bytes, _known_erasures),
    do: :erlang.nif_error(:nif_not_loaded)

  @doc "Check if a given codeword is corrupted (detectable by RS)."
  def is_corrupted(_codeword, _parity_bytes), do: :erlang.nif_error(:nif_not_loaded)
end
