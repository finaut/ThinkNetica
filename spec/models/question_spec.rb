# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  # после подключения максросов shoulda
  it { validate_presence_of :title }
  it { validate_presence_of :body }

  # спеки без исаользование валидации
  it 'check validate presence title' do
    expect(Question.new(body: 'da da da')).to_not be_valid
  end

  it 'check validate presence body' do
    expect(Question.new(title: 'net net net')).to_not be_valid
  end
end
