require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have h1 'Fitness Junction'" do
      visit '/static_pages/home'                 # visit is a Capybara function that simulates visiting the specified URL
      page.should have_selector('h1', :text => 'Fitness Junction')   # run 'bundle exec rspec spec/requests/static_pages_spec.rb' to run this test
    end

    it "should have title 'Home'" do
      visit '/static_pages/home'                 # visit is a Capybara function that simulates visiting the specified URL
      page.should have_selector('title', :text => 'Fitness Junction | Home')   # run 'bundle exec rspec spec/requests/static_pages_spec.rb' to run this test
    end
  end

  describe "About Page" do

    it "should have h1 'How It Works'" do
      visit '/static_pages/about'                 # visit is a Capybara function that simulates visiting the specified URL
      page.should have_selector('h1', :text => 'How It Works')   # run 'bundle exec rspec spec/requests/static_pages_spec.rb' to run this test
    end

    it "should have title 'About'" do
      visit '/static_pages/about'                 # visit is a Capybara function that simulates visiting the specified URL
      page.should have_selector('title', :text => 'Fitness Junction | About')   # run 'bundle exec rspec spec/requests/static_pages_spec.rb' to run this test
    end
  end
end

