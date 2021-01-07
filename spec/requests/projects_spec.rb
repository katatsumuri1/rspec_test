require'rails_helper'


RSpec.describe "Projects", type: :request do
  #認証済みユーザーとして
  context "as an authenticated user" do
    before do
      @user = FactoryBot.create(:user)
    end
  
    #有効な属性値の場合
    context "withe valid attributes" do
      #プロジェクトを追加できること
      it "add a project" do
      project_params = FactoryBot.attributes_for(:project)
      sign_in @user
      expect {
        post projects_path, params: {project: project_params}
      }.to change(@user.projects, :count).by(1)
      end
    end  
    #無効な属性値の場合
    context "withe invalid attributes" do
      #プロジェクトを追加できないこと
      it "does not add a project" do
        project_params = FactoryBot.attributes_for(:project, :invalid)
        sign_in @user
        expect{
          post projects_path, params: {project: project_params}
        }.to_not change(@user.projects, :count)
      end
    end
  end
end