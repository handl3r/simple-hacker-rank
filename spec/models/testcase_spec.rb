# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Testcase, type: :model do
  context 'validates tests' do
    common_data = { input: '[x, y, z]', output: '[a, b, c]',
                    challenge_id: Challenge.first.id }
    it 'should ensure input is presence' do
      testcase = Testcase.new(common_data.merge(input: nil)).save
      expect(testcase).to eq(false)
    end
    it 'should ensure output is presence' do
      testcase = Testcase.new(common_data.merge(output: nil)).save
      expect(testcase).to eq(false)
    end
    it 'should ensure success of creating' do
      testcase = Testcase.new(common_data).save
      expect(testcase).to eq(true)
    end
  end
end
