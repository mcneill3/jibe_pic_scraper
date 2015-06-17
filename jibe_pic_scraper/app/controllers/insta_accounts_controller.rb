class InstaAccountsController < ApplicationController

  CALLBACK_URL = "http://jibe_pic_scraper.dev/insta_accounts/insta_callback"
  def index
    @insta_accounts = InstaAccount.all
  end

  def new
    @insta_account = InstaAccount.new
  end

  def show
  end

  def edit
  end

  def create
    @insta_account = InstaAccount.new(insta_account_params)

    if @insta_account.save
      redirect_to insta_accounts_path
    else
      render :new
    end

  end

  def update
  end

  def destroy
  end

  def insta_connect
    Instagram.configure do |config|
      config.client_id = "b605ca12cf5b4686a7c989be77759b8b"
      config.client_secret = "f4210aac39b34dde8cb0c46f4aee542e"

    end

    redirect_to Instagram.authorize_url(:redirect_uri => CALLBACK_URL)

  end

  def insta_callback
    response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
    session[:access_token] = response.access_token

    client = Instagram.client(:access_token => session[:access_token])

    @dctech = client.tag_recent_media('dctech')

  end

  private

    def insta_account_params
      params.require(:insta_account).permit(:username)
    end
end
