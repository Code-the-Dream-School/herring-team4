require 'rails_helper'

RSpec.describe "comments/new.html.erb", type: :view do
  let(:user) { FactoryBot.create(:user) }
  let(:entry) { FactoryBot.create(:entry, user: user) }
  let!(:comment) { FactoryBot.create(:comment, entry: entry) }

  context "web page text" do
    before do
      assign(:entry, entry)
      assign(:comment, comment)
      render
    end

    it "displays the new comment form" do
      expect(rendered).to have_selector("h1", text: "New comment")
      expect(rendered).to render_template(partial: "_form")
    end

    it "renders a link back to comments index" do
      expect(rendered).to have_link("Friends Entries", href: friend_entries_path)
    end
  end
end
