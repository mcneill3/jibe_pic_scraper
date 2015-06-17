

CALLBACK_URL = "http://localhost:4567/oauth/callback"


Instagram.configure do |config|
  config.client_id = "b605ca12cf5b4686a7c989be77759b8b"
  config.client_secret = "f4210aac39b34dde8cb0c46f4aee542e"
  # For secured endpoints only
  #config.client_ips = '<Comma separated list of IPs>'
end

get "/oauth/connect" do
  redirect Instagram.authorize_url(:redirect_uri => CALLBACK_URL)
end

get "/oauth/callback" do
  response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
  session[:access_token] = response.access_token
  redirect "/nav"
end



get "/tags" do
  client = Instagram.client(:access_token => session[:access_token])
  html = "<h1>Search for tags, get tag info and get media by tag</h1>"
  tags = client.tag_search('cat')
  html << "<h2>Tag Name = #{tags[0].name}. Media Count =  #{tags[0].media_count}. </h2><br/><br/>"
  for media_item in client.tag_recent_media(tags[0].name)
    html << "<img src='#{media_item.images.thumbnail.url}'>"
  end
  html
end
