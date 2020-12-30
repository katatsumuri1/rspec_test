require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  
  #姓、名、メール、パスワードがあれば有効な状態であること
  it "is valid with a first name, last name, email, and password" do
    user = User.new(
      first_name: "Aaron",
      last_name:  "Sumner",
      email:      "tester@example.com",
      password:   "dottle-nouveau-pavilion-tights-furze",
    )
    expect(user).to be_valid
  end
      
  #名がなければ、無効な状態であること
  it "is invalid without a first name" do
    user = User.new(first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include("can't be blank")
  end
  
  #姓がなければ無効な状態であること
  it "is invalid without a last name" do
    user = User.new(last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include("can't be blank")
  end
    
  #メールアドレスがなければ無効な状態であること
  it "is invalid without an email address" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end
  
  #重複したメールアドレスなら無効な状態であること
  it "is invalid withe a duplicate email address" do
    User.create(
      first_name: "joe",
      last_name:  "Tester",
      email:      "tester@example.com",
      password:   "dottle-nouveau-pavilion-tights-furze",
    )
      
    user = User.new(
      first_name: "Jane",
      last_name:  "Tester",
      email:      "tester@example.com",
      password:   "dottele-nouveau-pavilion-tights-furuze",
    )  
      
      user.valid?
      
      expect(user.errors[:email]).to include("has already been taken")
    end
    
  
  #ユーザーのフルネームを文字列として返す事
  it "returns a user's full name as a string" do 
    user = User.new(
      first_name: "John",
      last_name:  "Doe",
      email:      "johndoe@example.com",
    )
    
    expect(user.name).to eq "John Doe"
  end
end