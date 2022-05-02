require 'rails_helper'

RSpec.describe Note, type: :model do
  it '更新時にtitleがあれば有効' do
    note = create(:note, :initial_note)

    expect { note.update!(title: 'new title') }.not_to raise_error
  end

  it '更新時にtitleがなければ無効' do
    note = create(:note, :initial_note)

    expect { note.update!(title: '', body_text: 'new body') }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it '更新時に本文がなければ無効' do
    note = create(:note, :initial_note)

    expect { note.update!(title: 'new title', body_text: 'a' * 40_000) }.not_to raise_error
    expect { note.update!(title: 'new title', body_text: 'a' * 40_001) }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
