=begin
require 'spec_helper'

feature "An Admin Deletes A Student" do
	let!(:admin){Factory(:admin_user)}
	let!(:mentor){Factory(:mentor)}


	scenario "Admin deletes Student from Database" do
		sign_in_as!(admin)
		visit '/'
		page.should have_content("Mentors that still need mentees")
		click_link "Matt Tee"
		click_link "Delete"
		page.should have_content("Matt Tee has been removed from the database.")
	end

	scenario "If not an Admin, Mentors not Shown" do
		sign_in_as!(admin)
		visit '/'
		click_link 'Sign Out'
		visit '/'
		page.should have_content("Mentors that still need mentees")
	end
end
=end