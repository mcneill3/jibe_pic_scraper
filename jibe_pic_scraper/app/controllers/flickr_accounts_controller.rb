class FlickrAccountsController < ApplicationController

  require 'flickraw'

  CALLBACK_URL = "http://jibe_pic_scraper.dev/flickr_accounts/flickr_callback"

  # GET /flickr_accounts
  # GET /flickr_accounts.json
  def index
    @flickr_accounts = FlickrAccount.all
  end

  # GET /flickr_accounts/1
  # GET /flickr_accounts/1.json
  def show
  end

  # GET /flickr_accounts/new
  def new
    @flickr_account = FlickrAccount.new
  end

  # GET /flickr_accounts/1/edit
  def edit
  end

  # POST /flickr_accounts
  # POST /flickr_accounts.json
  def create
    @flickr_account = FlickrAccount.new(flickr_account_params)

    if @flickr_account.save
      redirect_to flickr_accounts_path
    else
      render :new
    end

    # respond_to do |format|
    #   if @flickr_account.save
    #     format.html { redirect_to @flickr_account, notice: 'Flickr account was successfully created.' }
    #     format.json { render :show, status: :created, location: @flickr_account }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @flickr_account.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /flickr_accounts/1
  # PATCH/PUT /flickr_accounts/1.json
  def update
    # respond_to do |format|
    #   if @flickr_account.update(flickr_account_params)
    #     format.html { redirect_to @flickr_account, notice: 'Flickr account was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @flickr_account }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @flickr_account.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /flickr_accounts/1
  # DELETE /flickr_accounts/1.json
  def destroy
    # @flickr_account.destroy
    # respond_to do |format|
    #   format.html { redirect_to flickr_accounts_url, notice: 'Flickr account was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end


  def flickr_connect
      Flickraw.api_key = "cff675a60acc72ab77c7b3f52655b690"
      Flickraw.shared_secret = "ba164b12cdb9ac3c"

      token = flickr.get_request_token
      auth_url = flickr.get_authorize_url(token['oauth_token'], :perms => 'delete')

      raise auth_url

      redirect_to Flickraw.authorize_url(:redirect_uri => CALLBACK_URL)
  end



  def flickr_callback
      token = flickr.get_request_token
      auth_url = flickr.get_authorize_url(token['oauth_token'], :perms => 'delete')

      raise auth_url

      begin
        flickr.get_access_token(token['oauth_token'], token['oauth_token_secret'], verify)
        login = flickr.test.login
        puts "You are now authenticated as #{login.username} with token #{flickr.access_token} and secret #{flickr.access_secret}"
      rescue FlickRaw::FailedResponse => e
        puts "Authentication failed : #{e.msg}"
      end
      # @dctech = client.tag_recent_media('dctech')

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flickr_account
      @flickr_account = FlickrAccount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def flickr_account_params
      params.require(:flickr_account).permit(:username)
    end
end
