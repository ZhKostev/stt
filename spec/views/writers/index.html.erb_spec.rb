require 'rails_helper'

RSpec.describe "writers/index", type: :view do
  before(:each) do
    assign(:writers, [
      Writer.create!(
        name: "Name"
      ),
      Writer.create!(
        name: "Name"
      )
    ])
  end

  it "renders a list of writers" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
  end
end
