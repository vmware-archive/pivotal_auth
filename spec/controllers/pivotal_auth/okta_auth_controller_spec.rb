require 'spec_helper'

module PivotalAuth
  describe OktaAuthController do
    routes { PivotalAuth::Engine.routes }

    describe "#consume" do
      def make_request
        post :consume, SAMLResponse: 'saml_response'
      end

      before do
        allow(Onelogin::Saml::Response).to receive(:new).
          with('saml_response').
          and_return { double(:response, :settings= => '', is_valid?: true, name_id: 'email@example.com') }
      end

      it "stores email in session" do
        make_request
        expect(session[:email]).to eq 'email@example.com'
      end

      it "does not store a cookie for 'remember_token'" do
        make_request
        expect(cookies.signed[:remember_token]).to be_nil
      end

      context "when a return_to url is set" do
        before { session[:return_to] = '/foo' }

        it "redirects to the return_to url" do
          make_request
          expect(response).to redirect_to '/foo'
        end
      end

      context "when a return_to url is not set" do
        it "redirects to root" do
          make_request
          expect(response).to redirect_to '/'
        end
      end
    end

    describe "#init" do
      def make_request
        get :init
      end

      before do
        allow(Onelogin::Saml::Authrequest).to receive(:new).
          and_return { double(:settings, create: '/redirect/url') }
      end

      it "responds successfully" do
        make_request
        expect(response).to redirect_to('/redirect/url')
      end
    end
  end
end
