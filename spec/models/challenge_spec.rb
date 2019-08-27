# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Challenge, type: :model do
  common_data = { title: 'title1', content: 'content1', question: 'question1',
                  groupchallenge_id: Groupchallenge.first.id }
  context 'validates tests' do
    it 'should ensure title is presence' do
      challenge = Challenge.new(common_data.merge(title: nil))
      expect(challenge).to eq(false)
    end
    it 'should ensure content is presence' do
      challenge = Challenge.new(common_data.merge(content: nil))
      expect(challenge).to eq(false)
    end
    it 'should ensure question is presence' do
      challenge = Challenge.new(common_data.merge(question: nil))
      expect(challenge).to eq(false)
    end
    it 'should ensure success of creating' do
      challenge = Challenge.new(common_data)
      expect(challenge).to eq(true)
    end
  end
end
