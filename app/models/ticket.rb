class Ticket < ApplicationRecord
  # optional: trueとは、アソシエーションによって紐づけられた外部キーの値が存在しない値やnilの場合でも、
  # データベースに保存することができるオプションです。通常、外部キーの値が存在しない値やnilであればバリデーションで弾かれてしまいます。
  belongs_to :user, optional: true
  belongs_to :event

  validates :comment, length: { maximum: 30 }, allow_blank: true
end
