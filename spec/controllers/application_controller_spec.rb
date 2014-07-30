require 'spec_helper'

class AnyAppController < ApplicationController
end

describe ApplicationController do
  controller(AnyAppController) do
    before_filter :authenticate_user!

    def index
      head :ok
    end
  end

  describe "#user_signed_in?" do
    subject { controller.user_signed_in? }

    it "returns true when user is signed in" do
      session[:email] = "pivot@pivotallabs.com"
      expect(subject).to be_true
    end

    it "returns false when user is not signed in" do
      session[:email] = nil
      expect(subject).to be_false
    end
  end

  describe "#current_user_email" do
    it "returns the email address when user is signed in" do
      session[:email] = "pivot@pivotallabs.com"
      expect(subject.current_user_email).to eq("pivot@pivotallabs.com")
    end

    it "returns nil when user is not signed in" do
      session[:email] = nil
      expect(subject.current_user_email).to be_nil
    end
  end

  describe "requests where login is required" do
    context "when not logged in" do
      it "redirects to login screen" do
        get :index
        expect(response).to redirect_to '/login'
      end

      context "when requesting json" do
        it "returns a 401 Unauthorized" do
          get :index, :format => :json
          expect(response.status).to eq(401)
        end
      end

      context "when requesting xml" do
        it "returns a 401 Unauthorized" do
          get :index, :format => :xml
          expect(response.status).to eq(401)
        end
      end
    end

    context "when logged in" do
      before do
        session[:email] = 'user@example.com'
      end

      it "redirects to requested url" do
        get :index
        expect(response.status).to eq(200)
      end
    end
  end
end
