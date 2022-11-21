require 'rails_helper'

RSpec.describe User, type: :model do
  it 'checks user email and password' do
    user = create(:user)
    expect(user)
  end

  it 'fails user email' do
    expect { create(:user, email: 'nope', password: '123456') }.to raise_error
  end

  it 'fails user password' do
    expect { create(:user, email: 'trav@gmail.com', password: '') }.to raise_error
  end
end
