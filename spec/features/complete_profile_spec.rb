require 'rails_helper'
require 'capybara/rails'

RSpec.feature 'Feature test: create user profile', type: :feature do

	before {
		# populate test database with social links
		social_links = %w[Facebook Twitter Github Google-Plus Linkedin]
		i = 0
		5.times do
			SocialLink.create!(
					name: social_links[i]
			)
			i += 1
		end
	}

	scenario 'newly created user is directed to complete their profile' do
		@user = FactoryBot.create(:user)
		@user.confirmed_at = Time.now.utc
		@user.save
		visit new_user_session_path
		fill_in 'user_email', with: "#{@user.email}"
		fill_in 'user_password', with: "#{@user.password}"
		click_button "Sign in"

		expect(current_path).to eq "/users/#{@user.id}/edit"
		expect(page).to have_content('Edit your profile')

		fill_in 'user_bio', with: "Ruby on Rails developer with over ten years of experience"
		select 'Founder', from: 'user_role'
		fill_in 'user_user_skills_attributes_0_title', with: 'Ruby on Rails developer'
		fill_in 'user_user_skills_attributes_0_description', with: "I'm a professional Ruby on Rails developer with over eight years experience"
		select 'Twitter', from: 'user_social_links_attributes_0_name'
		fill_in 'user_social_links_attributes_0_url', with: "https://twitter.com/#{@user.first_name}"
		attach_file("user_main_image", Rails.root + "app/assets/images/logo.png")
		click_on "Update User"

		@user.reload
		expect(@user.bio).to eq "Ruby on Rails developer with over ten years of experience"
		expect(@user.role).to eq 'founder'
		expect(@user.social_links.last.name).to eq 'Twitter'
		expect(@user.social_links.last.url).to eq "https://twitter.com/#{@user.first_name}"
		expect(@user.user_skills.last.title).to eq "Ruby on Rails developer"
		expect(@user.user_skills.last.description).to eq "I'm a professional Ruby on Rails developer with over eight years experience"
	end

end