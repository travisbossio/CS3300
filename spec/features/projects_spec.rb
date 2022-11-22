require 'rails_helper'

RSpec.feature "Projects", type: :feature do
  context "Create new project" do
    before(:each) do
      user = create(:user)
      visit user_session_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log in"
      visit new_project_path
    end

    scenario "should be successful" do
      visit new_project_path
      fill_in "Title", with: "Test title"
      fill_in "Description", with: "Test description"
      click_button "Create Project"
      expect(page).to have_content("Project was successfully created")
    end

    scenario "should fail" do
      click_button "Create Project"
      expect(page).to have_content("Description can't be blank")
    end
  end

  context "Update project" do
    let(:project) { Project.create(title: "Test title", description: "Test content") }
    before(:each) do
      user = create(:user)
      visit user_session_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log in"
      visit edit_project_path(project)
    end

    scenario "should be successful" do
      within("form") do
        fill_in "Description", with: "New description content"
      end
      click_button "Update Project"
      expect(page).to have_content("Project was successfully updated")
    end

    scenario "should fail" do
      within("form") do
        fill_in "Description", with: ""
      end
      click_button "Update Project"
      expect(page).to have_content("Description can't be blank")
    end
  end

  context "Remove existing project" do
    let!(:project) { Project.create(title: "Test title", description: "Test content") }
    scenario "remove project" do
      user = create(:user)
      visit user_session_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log in"
      visit project_path(project)
      click_button "Destroy this project"
      expect(page).to have_content("Project was successfully destroyed")
      expect(Project.count).to eq(0)
    end
  end

  context "Check Project Attributes" do
    let!(:project) { Project.create(title: "Test title", description: "Test content") }
    scenario "Check Name" do
      visit project_path(project)
      expect(page).to have_content("Title: Test title")
    end
    scenario "Check Description" do
      visit project_path(project)
      expect(page).to have_content("Description: Test content")
    end
  end
end