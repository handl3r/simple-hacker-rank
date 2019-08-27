# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Language, type: :model do
  common_data = { name: 'testname' }
  context 'validates tests' do
    it 'should ensure name is presence' do
      language = Language.new(common_data.merge(name: nil)).save
      expect(language).to eq(false)
    end
    it 'should ensure name is uniqueness' do
      Language.new(common_data).save
      language = Language.new(common_data).save
      expect(language).to eq(false)
    end
    it 'should ensure success of creating' do
      language = Language.new(common_data).save
      expect(language).to eq(true)
    end
  end
end
