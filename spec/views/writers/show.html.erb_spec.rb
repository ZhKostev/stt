require 'rails_helper'

RSpec.describe "writers/show", type: :view do
  before(:each) do
    @writer = assign(:writer, Writer.create!(
      name: "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
