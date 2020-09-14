require "rails_helper"

describe HomeController, rspec_mocking: true do
  describe "GET index" do
    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe "GET orders" do
    it "has a 200 status code" do
      get :orders
      expect(response.status).to eq(200)
    end
  end

  describe "POST file_uplaod" do
    it "has invalid invoice records" do
      post :file_upload, :params => {file: "#{Rails.root}/spec/file_upload/medsage_csvs.zip"}
      expect(request.flash[:error] ).to_not be_nil
    end
  end

  describe "POST file_uplaod" do
    it "has valid invoice records" do
      post :file_upload, :params => {file: "#{Rails.root}/spec/file_upload/valid_medsage_csvs.zip"}
      expect(request.flash[:notice] ).to_not be_nil
    end
  end
end