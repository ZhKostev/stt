require 'rails_helper'

RSpec.describe "writers/new", type: :view do
  before(:each) do
    assign(:writer, Writer.new(
      name: "MyString"
    ))
  end

  it "renders new writer form" do
    render

    assert_select "form[action=?][method=?]", writers_path, "post" do

      assert_select "input[name=?]", "writer[name]"
    end
  end
end
