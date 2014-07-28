require "spec_helper"

module PivotalAuth
  describe SessionsController do
    routes { PivotalAuth::Engine.routes }

    describe "#new" do
      it "responds ok" do
        get :new
        expect(response).to be_success
      end

      context "when the authentication failed" do
        it "sets the flash message" do
          OmniAuth.config.mock_auth[:google_apps] = :invalid_credentials
          get :new, {message: "invalid creds"}
          flash[:error].should_not be_nil
        end
      end
    end

    describe "#create" do
      def set_request_envs
        request.env["omniauth.auth"] = {
          :uid => "fozzybear@MUPPETS.com"
        }
      end

      before do
        set_request_envs
      end

      it "stores the user's email" do
        expect { post :create }.to change { session[:email] }.to("fozzybear@muppets.com")
      end

      it "redirects to the apps page" do
        post :create
        response.should redirect_to '/'
      end
    end

    describe "#destroy" do
      it "destroys the session" do
        session[:email] = "bar@example.com"
        delete :destroy

        session[:email].should be_nil
      end

      it "redirects to the login page" do
        delete :destroy
        response.should redirect_to login_path
      end

      it "sets the flash message" do
        delete :destroy
        flash[:notice].should eq "Successfully logged out."
      end
    end
  end
end
