require 'rails_helper'

RSpec.describe Project, type: :model do
  
  #たくさんのメモがついていること
  it "can have many notes" do
    project = FactoryBot.create(:project, :with_notes)
    expect(project.notes.length).to eq 5
  end
  
  # ユーザー単位では重複したプロジェクト名を許可しないこと
  it "does not allow duplicate project names per user"do
    
    user = FactoryBot.create(:user)
    
    user.projects.create(
      name:"Test Project",
      )
      
    new_project = user.projects.build(
      name: "Test Project",
      )
      
      new_project.valid?
      expect(new_project.errors[:name]).to include("has already been taken")
  end
  #↑のテストをShouldaで書いた場合 
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:user_id)}
  
  #二人のユーザーが同じ名前を使う事は許可すること
  it "allows two users to sheare a project name" do
    user = FactoryBot.create(:user)
    user.projects.create(
      name: "Test Project",
      )
      
    other_user = FactoryBot.create(:user)
    other_project= other_user.projects.build(
      name: "Test Project",
      )
      
    expect(other_project).to be_valid
      
    end
  #遅延ステータス
  describe "late status" do
    #締め切り日がすぎていれば遅延していること
    it "is late when the due date is past today" do
      project = FactoryBot.create(:project, :due_yesterday)
      expect(project).to be_late
    end
  end
  #締め切り日が今日ならスケジュール通りであること
  it "is on time when the due date is today" do
    project = FactoryBot.create(:project, :due_today)
    expect(project).to_not be_late
  end
  
  # 締め切り日が未来ならスケジュール通りであること
  it "is on time when the due date is in the future" do
    project = FactoryBot.create(:project, :due_tomorrow)
    expect(project).to_not be_late
  end
end
