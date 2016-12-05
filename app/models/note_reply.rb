class NoteReply < ApplicationRecord
  belongs_to :note
  belongs_to :user
end
