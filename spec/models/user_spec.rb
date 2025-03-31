require 'rails_helper'
RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:phone_number) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_uniqueness_of(:phone_number) }
    it { should allow_value('test@example.com').for(:email) }
    it { should_not allow_value('invalid-email').for(:email) }
    it { should allow_value('1234567811').for(:phone_number) }
    it { should_not allow_value('12345').for(:phone_number) }
  end

  describe 'associations' do
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
  end

  describe 'roles' do
    let(:user) { create(:user) }

    it 'assigns default role after creation' do
      expect(user.has_role?(:user)).to be_truthy
    end
  end

  describe '#avatar_url' do
    let(:user) { create(:user, avatar_public_id: 'sample_public_id') }

    it 'returns Cloudinary URL if avatar is uploaded' do
      expect(user.avatar_url).to include('sample_public_id')
    end

    it 'returns default avatar if no avatar is uploaded' do
      user.avatar_public_id = nil
      # expect(user.avatar_url).to include('imageavatar.jpg')
      expect(user.avatar_url).to match(/imageavatar.*\.jpg/)
    end
  end

  describe '#name' do
    let(:user) { build(:user, first_name: 'John', last_name: 'Doe') }

    it 'returns full name' do
      expect(user.name).to eq('John Doe')
    end
  end

  describe '#admin?' do
    let(:admin) { create(:user) }

    before { admin.add_role(:admin) }

    it 'returns true if user has admin role' do
      expect(admin.admin?).to be_truthy
    end

    it 'returns false if user does not have admin role' do
      user = create(:user)
      expect(user.admin?).to be_falsey
    end
  end

  describe 'callbacks' do
    let(:user) { build(:user) }

    it 'calls assign_default_role after create' do
      expect(user).to receive(:assign_default_role)
      user.run_callbacks(:create)
    end
  end

end
