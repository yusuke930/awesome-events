class User < ApplicationRecord
  before_destroy :check_all_events_finished

  has_many :created_events, class_name: "Event", foreign_key: "owner_id"
  has_many :tickets, dependent: :destroy
  has_many :participating_events, through: :tickets, source: :event

  def self.find_or_create_auth_hash!(auth_hash)
    provider = auth_hash[:provider]
    uid = auth_hash[:uid]
    nickname = auth_hash[:info][:nickname]
    image_url = auth_hash[:info][:image]
    logger.debug "#{auth_hash}"

    User.find_or_create_by!(provider: provider, uid: uid) do |user|
      user.name = nickname
      user.image_url = image_url
    end
  end

  private

  def check_all_events_finished
    now = Time.zone.now

    if created_events.where("? < end_at", now ).exists?
      errors[:base] << "You have a event that are open to the public"
    end

    if participating_events.where("? < end_at", now ).exists?
      errors[:base] << "You have a uncompleted event to attend"
    end

    throw(:abort) unless errors.empty?
  end
end

# present? ではなく、exists? を使おう
# exists 式は条件に該当するレコードが1件でも存在すればDBがそこで探索を打ち切ってくれるので、無駄に全件を取ってくることはない。
# DBレベルで true または false で返してくれるのでオーバヘッドが最小で済む。



# find_or_create_by! : occuer ActiveRecord::RecordInvalid
# find_or_create_by : don't occuer error