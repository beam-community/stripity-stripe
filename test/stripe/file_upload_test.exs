defmodule Stripe.FileUploadTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  #these tests are dependent on the execution order
  # ExUnit.configure w/ seed: 0 was set
  setup do
    params = [
      purpose: "dispute_evidence",
      file: "/path/to/a/file.jpg"
    ]
    {:ok, params: params}
  end

  @tag disabled: false
  test "Create w/params", %{params: params} do
    use_cassette "file_upload_test/create", match_requests_on: [:query, :request_body] do

      case Stripe.FileUploads.create(params) do
        {:ok, res} -> assert res.id
        {:error, err} -> flunk err
      end
    end
  end

  @tag disabled: false
  test "Create w/params and key", %{params: params} do
    use_cassette "file_upload_test/create_with_key", match_requests_on: [:query, :request_body] do

      case Stripe.FileUploads.create(params, Stripe.config_or_env_key) do
        {:ok, res} -> assert res.id
        {:error, err} -> flunk err
      end
    end
  end


end
