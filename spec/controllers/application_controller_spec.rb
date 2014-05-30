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

    it "returns true when a user is signed in" do
      session[:emails] = ["pivot@pivotallabs.com"]
      expect(subject).to be_true
    end

    it "returns true when more than one user is signed in" do
      session[:emails] = ["pivot@pivotallabs.com", "bob@example.com"]
      expect(subject).to be_true
    end

    it "returns false when user is not signed in" do
      session[:emails] = []
      expect(subject).to be_false
    end
  end

  describe "#current_user_emails" do
    it "returns the email address when users are signed in" do
      session[:emails] = ["pivot@pivotallabs.com", "ben@example.com"]
      expect(subject.current_user_emails).to eq(["pivot@pivotallabs.com", "ben@example.com"])
    end

    it "returns [] when user is not signed in" do
      session[:emails] = nil
      expect(subject.current_user_emails).to be_empty
    end
  end

  describe "requests where login is required" do
    context "when not logged in" do
      it "redirects to google auth" do
        get :index
        expect(response).to redirect_to '/login'
      end
    end

    context "when logged in" do
      before do
        session[:emails] = ['user@example.com']
      end

      it "redirects to requested url" do
        get :index
        expect(response.status).to eq(200)
      end
    end
  end
end
