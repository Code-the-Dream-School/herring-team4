require 'rails_helper'

RSpec.describe "comments/show.html.erb", type: :view do
  let(:user) { FactoryBot.create(:user) }
  let!(:friend) { FactoryBot.create(:user) }
  let(:entry) { FactoryBot.create(:entry, user: friend) }
  let!(:comment) { FactoryBot.create(:comment, entry: entry, user: user, text: "Test comment") }

  context "web page text" do
    before do
      assign(:entry, entry)
      assign(:comment, comment)
      render
    end

    it "displays the comment" do
      expect(rendered).to include("Test comment")
    end

    it "renders the partial for the comment" do
      expect(rendered).to include(comment.user.username)
      expect(rendered).to include(comment.text)
    end

    it "displays the edit link" do
      expect(rendered).to have_link("Edit", href: edit_entry_comment_path(entry, comment))
    end

    it "renders the delete button" do
      expect(rendered).to have_selector("button.delete-comment-btn")
    end

  end
end
