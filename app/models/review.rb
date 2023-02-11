class Review < ApplicationRecord
  belongs_to :reviewer, class_name: "User", foreign_key: :reviewer_id
  belongs_to :reviewed, clas_name: "User", foreign_key: :reviewed_id
end
