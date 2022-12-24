class Photo < ApplicationRecord

  has_one_attached :image
  # バリデーション
  validate :validate_image

  belongs_to :customer

  has_many :photo_tags,dependent: :destroy
  has_many :tags,through: :photo_tags

  has_many :photo_cameras,dependent: :destroy
  has_many :cameras,through: :photo_cameras

  has_many :photo_editing_apps,dependent: :destroy
  has_many :editing_apps,through: :photo_editing_apps

  has_many :favorites, dependent: :destroy

  has_many :comments,dependent: :destroy
  
  
  #引数で渡されたユーザidがFavoritesテーブル内に存在（exists?）するかどうかを調べる。 存在していればtrue、存在していなければfalseを返すようにしている。
  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end


  #全ての中間タグを通して、タグを登録できるようにする
  def save_photo_tag(sent_tags)
  # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags

    # 古いタグを消す
    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end

    # 新しいタグを保存
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags << new_post_tag
    end
  end

  def save_camera_tag(sent_tags)
  # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.cameras.pluck(:name) unless self.cameras.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags

    # 古いタグを消す
    old_tags.each do |old|
      self.cameras.delete Camera.find_by(name: old)
    end

    # 新しいタグを保存
    new_tags.each do |new|
      new_post_tag = Camera.find_or_create_by(name: new)
      self.cameras << new_post_tag
    end
  end

  def save_editing_app_tag(sent_tags)
  # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.editing_apps.pluck(:name) unless self.editing_apps.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags

    # 古いタグを消す
    old_tags.each do |old|
      self.editing_apps.delete EditingApp.find_by(name: old)
    end

    # 新しいタグを保存
    new_tags.each do |new|
      new_post_tag = EditingApp.find_or_create_by(name: new)
      self.editing_apps << new_post_tag
    end
  end

  def validate_image
    errors.add(:image, :blank) unless image.attached?
  end

end
