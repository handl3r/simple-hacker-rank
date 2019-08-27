require 'rails_helper'

RSpec.describe Groupchallenge, type: :model do
  context 'validates tests' do
    common_data = { level: 1, name: 'test_name' }
    it 'should ensure level is presence' do
      group_challenge = Groupchallenge.new(common_data.merge(level: nil)).save
      expect(group_challenge).to eq(false)
    end
    it 'should ensure level is uniqueness' do
      Groupchallenge.new(common_data).save
      group_challenge = Groupchallenge.new(common_data.merge(name: 'test_name1'))
                                      .save
      expect(group_challenge).to eq(false)
    end
    it 'should ensure name is presence' do
      group_challenge = Groupchallenge.new(common_data.merge(name: nil)).save
      expect(group_challenge).to eq(false)
    end
    it 'should ensure level is uniqueness' do
      Groupchallenge.new(common_data).save
      group_challenge = Groupchallenge.new(common_data.merge(level: 2))
                                      .save
      expect(group_challenge).to eq(false)
    end
  end
end
