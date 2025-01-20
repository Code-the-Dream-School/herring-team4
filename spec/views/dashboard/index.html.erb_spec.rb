require "rails_helper"

RSpec.describe "dashboard/index.html.erb", type: :view do
  let(:user_stub) { instance_double("User", email: "test@example.com", username: "stubbed_user", notification: nil) }
  include Devise::Test::ControllerHelpers

  before do
    allow(view).to receive(:current_user).and_return(user_stub)
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