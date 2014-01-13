require 'test_helper'

class StaticPagesTest < ActionDispatch::IntegrationTest

   describe "Home page" do

    it "should have the content 'MMRC Helpdesk'" do
      visit '/static_pages/home'
      expect(page).to have_content('MMRC Helpdesk')
    end
  end

  describe "About page" do

    it "should have the content 'This is a ticketing system for MMRC Helpdesk issues'" do
      visit '/static_pages/about'
      expect(page).to have_content('This is a ticketing system for MMRC Helpdesk issues')
    end
  end

  describe "Contact page" do

    it "should have the content 'For questions see below contacts'" do
      visit '/static_pages/contact'
      expect(page).to have_content('For questions see below contacts')
    end
  end

  describe "Help page" do

    it "should have the content 'How to use'" do
      visit '/static_pages/help'
      expect(page).to have_content('How to use')
    end
  end

end
