require 'rails_helper'

RSpec.describe Project, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  
  # ユーザー単位では重複したプロジェクト名を許可しないこと
  
  it "does not allow duplicate project names per user"do
    
    user = User.create(
      first_name: "joe",
      last_name:  "Tester",
      email:      "tester@example.com",
      password:   "dottle-nouveau-pavilion-tights-furze",
      )
    
    user.projects.create(
      name:"Test Project",
      )
      
    new_project = user.projects.build(
      name: "Test Project",
      )
      
      new_project.valid?
      expect(new_project.errors[:name]).to include("has already been taken")
  end
  
  #二人のユーザーが同じ名前を使う事は許可すること
  it "allows two users to sheare a project name" do
    user = User.create(
      first_name: "Joe",
      last_name:  "Tester",
      email:      "joetester@example.com",
      password:   "dottle-nouveau-pavikion-tights-furuze",
      )
      
    user.projects.create(
      name: "Test Project",
      )
      
    other_user = User.create(
      first_name: "Jane",
      last_name:  "Tester",
      email:      "janetester@example.com",
      password:   "dottle-nouveau-pavikion-tights-furze",
      )
      
    other_project= other_user.projects.build(
      name: "Test Project",
      )
        
      expect(other_project).to be_valid
      
    end
end
