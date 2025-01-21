require "rails_helper"

RSpec.describe "dashboard/index.html.erb", type: :view do
  # let(:user_stub) { instance_double("User", email: "test@example.com", username: "stubbed_user", notification: nil) }

  let(:user) do
    FactoryBot.create(:user).tap do |user|
      user.profile_picture.attach(
        io: File.open(Rails.root.join("spec/fixtures/files/default.png")),
        filename: "default.png",
        content_type: "image/png"
      )
    end
  end

  include Devise::Test::ControllerHelpers

  before do
    allow(view).to receive(:current_user).and_return(user)
    allow(view).to receive(:user_signed_in?).and_return(true)
    render template: "dashboard/index", layout: "layouts/application"
  end


  it "displays the text 'How are you feeling right now?'" do
    expect(rendered).to have_content('How are you feeling right now?')
  end

  it "displays the spinner" do
    expect(rendered).to have_selector("div.dashboard__spinner")
  end

  it "displays the plus sign and the 'Check in' text" do
    expect(rendered).to have_link("﹢", href: new_entry_path, class: "dashboard__plus")
    expect(rendered).to have_selector("p", text: "Check in")
  end

  it "displays the 'Check in' text" do
    expect(rendered).to have_selector("p", text: "Check in")
  end

    it "displays the '_navigation' partial" do
      expect(view).to render_template(partial: "layouts/_navigation")
    end

end