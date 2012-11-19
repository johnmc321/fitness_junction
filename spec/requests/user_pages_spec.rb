require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1',    text: "Sign Up, it's FREE!") }
    it { should have_selector('title', text: 'Sign Up') }
  end

  describe "profile page" do
  let(:user) { FactoryGirl.create(:user) } # Code to make a user variable, let creates a local variable, FactoryGirl is defined in Factories.rb
  before { visit user_path(user) }

  it { should have_selector('h1',    text: user.name) }
  it { should have_selector('title', text: user.name) }
end
end