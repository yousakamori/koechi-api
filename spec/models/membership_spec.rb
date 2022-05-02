require 'rails_helper'

RSpec.describe Membership, type: :model do
  it 'user_idとspace_idでユニークであること' do
    user = create(:user)
    space = create(:space)

    create(:membership, user_id: user.id, space_id: space.id)
    member = build(:membership, user_id: user.id, space_id: space.id)
    member.valid?

    expect(member.errors[:user_id]).to include('はすでに存在します')
  end
end
