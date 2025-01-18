require "rails_helper"

RSpec.describe "entries/show.html.erb", type: :view do
  let(:user) { create(:user) }

  let(:entry) do
    create(
      :entry,
      user: user,
      emotion: "Happy",
      energy_level: "8",
      private: "true",
      company: ['Friends', 'Family'].to_json,
      activity: ['Cooking', 'Dancing'].to_json,
      location: ['Home', 'Gym'].to_json,
      text: "Had a wonderful day!"
    )
  end

  let!(:comments) do
    [
      create(:comment, entry: entry, user: user, text: "Cool"),
      create(:comment, entry: entry, user: user, text: "That sucks!")
    ]
  end

  before do
    assign(:entry, entry)
    assign(:comments, comments)
    render
  end

  it "has the correct emotion label" do
    expect(rendered).to have_selector("p.entries__show-emotion-label", text: entry.emotion)
  end

  it "has the creation date in the correct format" do
    formatted_date = entry.created_at.strftime("%a %b %-d %l:%M %p")
    expect(rendered).to have_selector("div.entries__show-date-container p", text: formatted_date)
  end

  it "displays all company, activity, and location tags" do
    all_tags = JSON.parse(entry.company) + JSON.parse(entry.activity) + JSON.parse(entry.location)
    all_tags.each do |tag|
      expect(rendered).to have_selector("div.entries__show-tags-container p", text: tag)
    end
  end

  it "has the entry text" do
    expect(rendered).to have_selector("div.entries__show-entry-text-container p", text: "Entry")
    expect(rendered).to have_selector("div.entries__show-entry-text-container p", text: entry.text)
  end

  it "has a 'Private' button" do
    expect(rendered).to have_selector("div.entries__show-options-container button", text: "Private")
  end

  it "shows an 'Edit' link that directs to the edit entry path" do
    expect(rendered).to have_link("Edit", href: edit_entry_path(entry), class: "btn")
  end

  it "has all comments with user email and text" do
    comments.each do |comment|
      expect(rendered).to have_selector("div.entries__show-comment-container p", text: comment.user.email)
      expect(rendered).to have_selector("div.entries__show-comment-container p", text: comment.text)
    end
  end
end