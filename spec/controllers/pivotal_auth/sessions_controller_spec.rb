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
      before do
        request.env["omniauth.auth"] = {
          :uid => 123,
          :info => {:email => "fozzybear@MUPPETS.com"}
        }
      end

      it "stores the user's email" do
        expect { post :create }.to change { session[:emails] }.to(["fozzybear@muppets.com"])
      end

      it "redirects to the apps page" do
        post :create
        response.should redirect_to '/'
      end
    end

    describe "#destroy_all" do
      before do
        session[:emails] = ["foo@example.com", "bar@example.com"]
        delete :destroy_all
      end

      it "removes all emails from the session" do
        session[:emails].should be_empty
      end

      it "redirects to the login page" do
        response.should redirect_to login_path
      end

      it "sets the flash message" do
        flash[:notice].should eq "Successfully logged out."
      end
    end

    describe "#destroy" do
      before do
        session[:emails] = ["foo@example.com", "bar@example.com"]
        delete :destroy, email: "bar@example.com"
      end

      it "removes the specified email from the session" do
        session[:emails].should eq(["foo@example.com"])
      end

      it "redirects to the login page" do
        response.should redirect_to login_path
      end

      it "sets the flash message" do
        flash[:notice].should eq "Successfully logged out bar@example.com."
      end
    end
  end
end
