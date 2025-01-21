require 'rails_helper'

RSpec.describe "comments/edit.html.erb", type: :view do
  let(:user) { FactoryBot.create(:user) }
  let(:entry) { FactoryBot.create(:entry, user: user) }
  let!(:comment) { FactoryBot.create(:comment, entry: entry, user: user, text: "Test comment") }

  context "web page text" do
    before do
      assign(:entry, entry)
      assign(:comment, comment)
      render
    end

    it "displays the heading" do
      expect(rendered).to have_selector("h1", text: "Edit comment")
    end

    it "renders the form to edit comment" do
      expect(rendered).to have_selector("form[action='#{entry_comment_path(entry, comment)}'][method='post']")
    end

    it "pre-fills the text area with the current comment" do
      expect(rendered).to have_selector("textarea[name='comment[text]']", text: comment.text)
    end

    it "displays the submit button" do
      expect(rendered).to have_selector("input[type='submit'][value='Update']")
    end

  end
end
