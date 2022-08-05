require "rails_helper"

RSpec.describe WritersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/writers").to route_to("writers#index")
    end

    it "routes to #new" do
      expect(get: "/writers/new").to route_to("writers#new")
    end

    it "routes to #show" do
      expect(get: "/writers/1").to route_to("writers#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/writers/1/edit").to route_to("writers#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/writers").to route_to("writers#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/writers/1").to route_to("writers#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/writers/1").to route_to("writers#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/writers/1").to route_to("writers#destroy", id: "1")
    end
  end
end
