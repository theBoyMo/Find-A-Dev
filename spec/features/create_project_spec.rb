require 'rails_helper'

Warden.test_mode!

RSpec.feature "create project" do
	let!(:user) {FactoryBot.create(:user, confirmed_at: Time.now.utc)}

	after {Warden.test_reset!}

	scenario "a user can create an project" do
		login_as user, scope: :user
		visit new_project_path
		fill_in "project_title", with: "Looking for talent"
		fill_in "project_description", with: "Looking to build the next Amazon!"
		fill_in "project_project_skills_attributes_0_title", with: "Fullstack development"
		fill_in "project_project_skills_attributes_0_description", with: "Looking for that rockstar with....."
		# click_link "Add skill"
		# fill_in "project_project_skills_attributes_1_title", with: "Team Leader"
		# fill_in "project_apportunity_skills_attributes_1_description", with: "Your a team leader, having..."
		click_on "Create Project"

		expect(current_path).to eq projects_path
		expect(page).to have_content "Looking to build the next Amazon!"
		# expect(page).to have_content "Fullstack development"
		# expect(page).to have_content "Looking for that rockstar with....."
	end
end
