require 'rails_helper'

RSpec.feature "Projects", type: :feature do
  #ユーザーは新しいプロジェクトを作成する
  scenario"user creates a new project" do
    user = FactoryBot.create(:user)
    sign_in user
    
    visit root_path
  end
end