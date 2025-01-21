require 'rails_helper'

RSpec.describe "entries/entries_dashboard.html.erb", type: :view do
  before do
    render template: "entries/entries_dashboard"
  end

  it "displays the dashboard container" do
    expect(rendered).to have_selector("section.entries__dashboard-container")
  end

  it "displays the dashboard options" do
    expect(rendered).to have_selector("div.entries__dashboard-options")
  end

  it "has a 'View Entries' option" do
    expect(rendered).to have_selector("div.entries__view-entries[data-url='#{entries_path}']")
    expect(rendered).to have_selector("div.entries__view-entries", text: "View Entries")
  end

  it "has a 'Search Entries' option" do
    expect(rendered).to have_selector("div.entries__search-entries[data-url='#{search_entries_path}']")
    expect(rendered).to have_selector("div.entries__search-entries", text: "Search Entries")
  end

end