require 'rails_helper'

RSpec.describe "Statuses", type: :request do
  describe "GET /status" do
    # pending "add some examples (or delete) #{__FILE__}"
    it "return json status ok" do
      get '/status'
      assert_response(:success) # confirm status of response
      assert_equal({ status: "ok" }.to_json, @response.body)
      assert_equal("application/json", @response.media_type) # レスポンスのMIMEタイプが"applicatiom/json"であること
    end
  end
end
