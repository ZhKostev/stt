require 'rails_helper'

RSpec.describe "writers/edit", type: :view do
  before(:each) do
    @writer = assign(:writer, Writer.create!(
      name: "MyString"
    ))
  end

  it "renders the edit writer form" do
    render

    assert_select "form[action=?][method=?]", writer_path(@writer), "post" do

      assert_select "input[name=?]", "writer[name]"
    end
  end
end
