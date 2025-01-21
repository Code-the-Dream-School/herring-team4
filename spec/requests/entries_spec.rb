require 'rails_helper'

RSpec.describe EntriesController, type: :request do
  let(:user) do
    FactoryBot.create(:user).tap do |user|
      user.profile_picture.attach(
        io: File.open(Rails.root.join("spec/fixtures/files/default.png")),
        filename: "default.png",
        content_type: "image/png"
      )
    end
  end
  let!(:entry1) { create(:entry, user: user, text: 'I love cooking and working out.', emotion: 'Happy', location: ['Home'], company: ['Friends', 'Colleagues'], activity: ['Cooking', 'Working out']) }
  let!(:entry2) { create(:entry, user: user, text: 'Had a sad day at work.', emotion: 'Sad', location: ['Work'], company: ['Strangers', 'Colleagues'], activity: ['Working']) }
  let!(:entry3) { create(:entry, user: user, text: 'Relaxing at the park.', emotion: 'Calm', location: ['Park'], company: ['Pets', 'Myself'], activity: ['Meditating']) }
  let!(:entry4) { create(:entry, user: user, text: 'Excited about the new project!', emotion: 'Excited', location: ['Gym'], company: ['Colleagues', 'Family'], activity: ['Working']) }

  before do
    sign_in user
  end

  describe 'GET #search' do

    context 'when searching by text' do
      it 'returns entries that include the search term in text' do
        get search_entries_path, params: { query: 'cooking' }
        expect(assigns(:results)).to include(entry1)
        expect(assigns(:results)).not_to include(entry2, entry3, entry4)
      end

      it 'is case insensitive' do
        get search_entries_path, params: { query: 'COOKING' }
        expect(assigns(:results)).to include(entry1)
      end
    end

    context 'when searching by emotion' do
      it 'returns entries matching the emotion with * prefix' do
        get search_entries_path, params: { query: '*Happy' }
        expect(assigns(:results)).to include(entry1)
        expect(assigns(:results)).not_to include(entry2, entry3, entry4)
      end

      it 'is case insensitive' do
        get search_entries_path, params: { query: '*happy' }
        expect(assigns(:results)).to include(entry1)
      end
    end

    it 'returns entries matching the location tag with : prefix' do
      get search_entries_path, params: { query: ':Home' }
      expect(assigns(:results)).to include(entry1)
      expect(assigns(:results)).not_to include(entry2, entry3, entry4)
    end

    it 'returns entries matching the company tag with : prefix' do
      get search_entries_path, params: { query: ':Friends' }
      expect(assigns(:results)).to include(entry1)
      expect(assigns(:results)).not_to include(entry2, entry3, entry4)
    end

    it 'returns entries matching the activity tag with : prefix' do
      get search_entries_path, params: { query: ':Cooking' }
      expect(assigns(:results)).to include(entry1)
      expect(assigns(:results)).not_to include(entry2, entry3, entry4)
    end

    it 'returns no entries when no matching terms' do
      get search_entries_path, params: { query: 'nonexistent' }
      expect(assigns(:results)).to be_empty
    end

  end
end