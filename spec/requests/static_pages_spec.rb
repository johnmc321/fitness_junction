require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path } # visit is a Capybara function that simulates visiting the specified URL

    it { should have_selector('h1', text: 'Fitness Junction') }
    it { should have_selector('title', text: 'Fitness Junction | Home') }
  end



  describe "About Page" do

    it "should have h1 'How It Works'" do
      visit about_path                 
      page.should have_selector('h1', text: 'How It Works')   # run 'bundle exec rspec spec/requests/static_pages_spec.rb' to run this test
    end

    it "should have title 'About'" do
      visit about_path                 
      page.should have_selector('title', text: 'Fitness Junction | About')   # run 'bundle exec rspec spec/requests/static_pages_spec.rb' to run this test
    end
  end
end

