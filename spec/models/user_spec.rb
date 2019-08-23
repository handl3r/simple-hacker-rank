require 'rails_helper'

RSpec.describe User, type: :model do
  common_data = { name: 'test_name', email: 'test_email@gmail.com',
                  admin: false, password_digest: '111111' }
  context 'validates test' do
    it 'should ensure name is presence' do
      user = User.new(common_data.merge(name: nil)).save
      expect(user).to eq(false)
    end
    it 'should ensure name is unique' do
      User.new(common_data).save
      user = User.new(common_data.merge(email: 'test_email1@gmail.com')).save
      expect(user).to eq(false)
    end
    it 'should ensure email is presence' do
      user = User.new(common_data.merge(email: nil)).save
      expect(user).to eq(false)
    end
    it 'should ensure email is unique' do
      User.new(common_data).save
      user = User.new(common_data.merge(name: 'test_name1')).save
      expect(user).to eq(false)
    end
    it 'should ensure email must has true regex' do
      user = User.new(common_data.merge(email: '71hruehfehu...')).save
      expect(user).to eq(false)
    end
    it 'should ensure admin is presence' do
      user = User.new(common_data.merge(admin: nil)).save
      expect(user).to eq(false)
    end
    it 'should ensure password_digest is presence' do
      user = User.new(common_data.merge(password_digest: nil)).save
      expect(user).to eq(false)
    end
    it 'should ensure password_digest has minimum length is 6 character' do
      user = User.new(common_data.merge(password_digest: '111')).save
      expect(user).to eq(false)
    end
  end
end
