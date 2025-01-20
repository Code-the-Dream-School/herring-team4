require "rails_helper"

RSpec.describe "entries/index.html.erb", type: :view do
  let!(:entries) { create_list(:entry, 2) }

  before do
    assign(:entries, entries)
    render
  end

  it "has the page header" do
    expect(rendered).to have_selector("h2", text: "My Entries")
  end

  it "shows all entries" do
    entries.each do |entry|
      expect(rendered).to have_selector(".entries__index-entry-container", count: entries.size)
      expect(rendered).to have_content(entry.created_at.strftime("%a %b %-d %l:%M %p"))
      expect(rendered).to have_content(entry.emotion)

      JSON.parse(entry.company).each { |tag| expect(rendered).to have_content(tag) }
      JSON.parse(entry.activity).each { |tag| expect(rendered).to have_content(tag) }
      JSON.parse(entry.location).each { |tag| expect(rendered).to have_content(tag) }
    end
  end
end

