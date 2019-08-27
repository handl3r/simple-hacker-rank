# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Passlevel, type: :model do
  context 'validates tests' do
    common_data = { user_id: User.first.id, challenge_id: Challenge.first.id }
    it 'should ensure success of creating' do
      passlevel = Passlevel.new(common_data).save
      expect(passlevel).to eq(true)
    end
  end
end
