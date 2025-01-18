require 'rails_helper'

RSpec.describe "comments/index.html.erb", type: :view do
  include Devise::Test::ControllerHelpers
  
  let(:user) { FactoryBot.create(:user) }
  let(:entry) { FactoryBot.create(:entry, user: user) }
  let!(:comments) { FactoryBot.create_list(:comment, 2, entry: entry, user: user) }

  context "web page text" do
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
        expect(rendered).to include(comment.user.username)
        expect(rendered).to include(comment.text)
      end
    end

    it "displays a link back to the entry" do
      expect(rendered).to have_link("Friends Entries", href: friend_entries_path)
    end
  end
end
