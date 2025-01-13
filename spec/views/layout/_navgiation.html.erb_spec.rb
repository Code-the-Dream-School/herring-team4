require 'rails_helper'

RSpec.describe "layouts/_navigation.html.erb", type: :view do

  let(:user_stub) { instance_double("User", email: "test@example.com", username: "stubbed_user", notification: nil) }

  before do
    allow(view).to receive(:current_user).and_return(user_stub)
    render
  end

  it "displays the link to 'My Entries'" do
    expect(rendered).to have_link('My Entries', href: entries_path)
  end

  it "displays link to 'My Friends'" do
    expect(rendered).to have_link('My Friends', href: friend_entries_path)
  end

  it "displays link to 'Settings'" do
    expect(rendered).to have_link("Settings", href:"#" )
  end


  it "displays the link to 'Sign out'" do
    expect(rendered).to have_link("Sign out", href: destroy_user_session_path)
  end

  it "displays the link to Profile" do
    expect(rendered).to have_link("Profile", href: profile_path)
  end

  it "displays the link to create a new notification" do
    expect(rendered).to have_link("Schedule", href: new_notification_path)
  end


end