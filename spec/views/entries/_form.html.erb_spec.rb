require "rails_helper"

RSpec.describe "entries/_form.html.erb", type: :view do
  let(:user) { create(:user) }
  let(:entry) { build(:entry, user: user) }

  before do
    assign(:entry, entry)
    render partial: "entries/form"
  end

  it "renders the form" do
    expect(rendered).to have_selector("form")
  end

  it "sets the form's action to entries_path" do
    expect(rendered).to have_selector("form[action='#{entries_path}'][method='post']")
  end

  it "includes a select field for emotion with correct options" do
    emotions = %w[
      Connected Calm Good Thoughtful Relaxed Sad Bored Tired Meh Disappointed
      Excited Pleased Happy Cheerful Upbeat Angry Anxious Peeved Tense Irate
    ]
    expect(rendered).to have_select("entry[emotion]", options: emotions)
  end

  it "includes a select field for public" do
    assert_select "input[type=checkbox][name='entry[is_public]']"
  end

  it "has checkboxes for company tags" do
    companies = %w[Friends Family Pets Strangers Myself Colleagues]
    companies.each do |company|
      checkbox_id = "company_#{company.parameterize}"

      expect(rendered).to have_selector(
                            "input[type='checkbox'][name='entry[company][]'][id='#{checkbox_id}'][value='#{company}']")

      expect(rendered).to have_selector(
                            "label.entries__new-tag-label[for='#{checkbox_id}']", text: company)
    end
  end

  it "has checkboxes for activity tags" do
    activities = %w[
    Cooking Eating Working\ out Cleaning Journaling Meditating Working
    Dancing Water\ Aerobics
  ]
    activities.each do |activity|
      checkbox_id = "activity_#{activity.parameterize}"

      expect(rendered).to have_selector(
                            "input[type='checkbox'][name='entry[activity][]'][id='#{checkbox_id}'][value='#{activity}']")

      expect(rendered).to have_selector(
                            "label.entries__new-tag-label[for='#{checkbox_id}']", text: activity)
    end
  end

  it "has checkboxes for location tags" do
    locations = %w[Home Library School Work Park Outside Gym Restaurant Club]
    locations.each do |location|
      checkbox_id = "location_#{location.parameterize}"

      expect(rendered).to have_selector(
                            "input[type='checkbox'][name='entry[location][]'][id='#{checkbox_id}'][value='#{location}']"
                          )

      expect(rendered).to have_selector(
                            "label.entries__new-tag-label[for='#{checkbox_id}']", text: location
                          )
    end
  end

  it "has a text area for writing notes" do

    expect(rendered).to have_selector(
                          "textarea#entry_text[rows='10'][placeholder='Write your entry here...'][class='entries__new-text-field']"
                        )

    expect(rendered).to have_selector(
                          "label[for='entry_text']", text: "Write some notes about your day"
                        )
  end

  it "has a submit button" do
    expect(rendered).to have_button(class: "entries__new-submit-button")
  end
end