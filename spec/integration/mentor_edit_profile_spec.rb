require 'spec_helper'

feature "An Admin Edits a Mentor Profile" do
	let!(:admin){Factory(:admin_user)}
	let!(:mentor){Factory(:mentor)}

	scenario "Admin deletes Mentor from Database" do
		visit '/'
		click_link 'Admin'
		sign_in_as!(admin)
		page.should have_content("Mentors that still need mentees")
		click_link "Butler Price"
		click_link "Edit"

		# Form that needs to be changed
		fill_in "personal_first_name", :with => "John"
		fill_in "personal_last_name", :with => "Thomas"
		fill_in "personal_why_mentor", :with => "Because I'm great"
		fill_in "personal_knowledge_impart", :with => "Great knowledge"

		fill_in "career_information", :with => "Some Information"
		fill_in "career_job_title", :with => "CEO"
		fill_in "career_company_private", :with => "Octomania"
		select "Startup", :from => "mentor_career_company_type"

		fill_in 'experience_university', with: "Bom"
		fill_in 'experience_degree', :with => "Master Ninja"
		fill_in 'experience_other_degree', :with => "Seahorse Riding"

		select 'Very Able', :from => 'mentor_mentee_skills_developer'
		select 'Somewhat Able', :from => 'mentor_mentee_skills_html_css'
		select 'Not Able', :from => 'mentor_mentee_skills_javascript'
		select 'Very Able', :from => 'mentor_mentee_skills_java'
		select 'Somewhat Able', :from => 'mentor_mentee_skills_cplusplus'
		select 'Very Able', :from => 'mentor_mentee_skills_c'
		select 'Somewhat Able', :from => 'mentor_mentee_skills_ruby'
		select 'Not Able', :from => 'mentor_mentee_skills_python'
		select 'Not Able', :from => 'mentor_mentee_skills_php'
		select 'Very Able', :from => 'mentor_mentee_skills_net'
		select 'Not Able', :from =>'mentor_mentee_skills_coffeescript'
		fill_in 'mentee_skills_other_coding', :with => "asdfdas"

		choose 'mentor_skills_career_advice_3'
		choose 'mentor_skills_development_4'
		choose 'mentor_skills_coding_question_tactics_5'
		choose 'mentor_skills_soft_skills_4'
		choose 'mentor_skills_interview_coaching_3'
		choose 'mentor_skills_job_search_5'
		choose 'mentor_skills_resume_development_3'
		choose 'mentor_skills_github_account_development_3'
		choose 'mentor_skills_selling_idea_4'
		choose 'mentor_mentee_gender_n'
		fill_in 'mentee_extra_info', :with => 'Other info'

		click_button "Update Profile"
		page.should have_content("John Thomas's profile has been updated")
		page.should have_content("John Thomas")
		page.should have_content("Because I'm great")
		page.should have_content("Some Information")
		page.should have_content("Octomania")
		page.should_not have_content("Butler Price")
	end
end