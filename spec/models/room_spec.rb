require 'spec_helper'

describe Room do
  let(:room) { FactoryGirl.create(:room) }
  let(:user) { FactoryGirl.create(:user) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  it 'subscribes user' do
    expect { room.subscribe user }.to change(Subscription, :count).by 1
  end

  it 'subscribes user as owner' do
    room.subscribe user, :owner
    expect(room.owner).to eq user
  end

  it 'does not subscribes user if he already subscribed (even for different role)' do
    room.subscribe user
    expect { room.subscribe user }.to change(Subscription, :count).by 0
    expect { room.subscribe user, :owner }.to change(Subscription, :count).by 0
  end

  it 'returns true if user subscribed' do
    room.subscribe user
    expect(room.subscribed? user).to be_true
  end

  it 'redeems user' do
    room.subscribe user
    expect { room.redeem user }.to change(Subscription, :count).by -1
  end

  it 'has users as players' do
    room.subscribe user
    expect(room.players.to_a).to eq [user]
  end
end
