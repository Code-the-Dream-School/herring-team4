require 'rails_helper'

RSpec.describe "comments/index.html.erb", type: :view do
let(:user) { FactoryBot.create(:user) }
let(:entry) { FactoryBot.create(:entry, user: user) }
let!(:comments) { FactoryBot.create_list(:comment, 2, entry: entry, user: user) }

before do 
    assign(:entry, entry)
    assign(:comments, comments)
    render 
  end

  it "displays the entry" do
  expect(rendered).to include(entry.text)
end

  it "displays all comments for that entry" do
    comments.each do |comment|
      expect(rendered).to include(comment.user.email)
      expect(rendered).to include(comment.text)
    end
  end

  it "displays a link back to the entry" do
    expect(rendered).to have_link("Back to entry", href: entry_path(entry))
  end

end
