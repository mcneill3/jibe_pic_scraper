json.array!(@flickr_accounts) do |flickr_account|
  json.extract! flickr_account, :id, :access_token, :username
  json.url flickr_account_url(flickr_account, format: :json)
end
