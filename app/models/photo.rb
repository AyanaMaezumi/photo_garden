class Photo < ApplicationRecord

  has_one_attached :image
  # バリデーション
  validate :validate_image

  belongs_to :customer

  has_many :photo_tags,dependent: :destroy
  has_many :tags,through: :photo_tags,dependent: :destroy

  has_many :photo_cameras,dependent: :destroy
  has_many :cameras,through: :photo_cameras,dependent: :destroy

  has_many :photo_editing_apps,dependent: :destroy
  has_many :editing_apps,through: :photo_editing_apps,dependent: :destroy

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
  def save_photo_tag(tag_names)
    #中間テーブル一旦リセットする。既存の中間テーブルすべて消す（updateの時に使う）
    self.photo_tags.destroy_all
    tag_names.each do |name|
      # find_or_create_by 新規である、又は、既存である加工アプリ名を検索。新規だった場合は、そのnameで加工アプリレコードを一件作成する。をeachで繰り返す。
      tag = Tag.find_or_create_by(name: name)
      # 新規の中間テーブルを作成する（createとupdateの時に使う）。一番後ろのtagは、43行目のtagのこと。(tag_id: tag.id) photo_id: self.id
      # PhotoTag.create(tag_id: tag.id, photo_id: self.id)
      self.photo_tags.create(tag: tag)
    end
  end

  def save_camera_tag(camera_name)
  # find_or_create_by 新規である、又は、既存であるカメラ名を検索。新規だった場合は、そのnameでカメラレコードを一件作成する。
    camera = Camera.find_or_create_by(name: camera_name)
  # self モデルでselfというワードを書くと、モデルのインスタンス変数のことを指す。photo_controllerの@photo=selfということ。
  # 既存の中間テーブルすべて消す（updateの時に使う）
    self.photo_cameras.destroy_all
  # 新規の中間テーブルを作成する（createとupdateの時に使う）。一番後ろのcameraは、60行目のcameraのこと。
    self.photo_cameras.create(camera: camera)
  
  end

  def save_editing_app_tag(editing_app_names)
    #中間テーブル一旦リセットする。既存の中間テーブルすべて消す（updateの時に使う）
    self.photo_editing_apps.destroy_all
    editing_app_names.each do |name|
      # find_or_create_by 新規である、又は、既存である加工アプリ名を検索。新規だった場合は、そのnameで加工アプリレコードを一件作成する。をeachで繰り返す。
      editing_app = EditingApp.find_or_create_by(name: name)
      # 新規の中間テーブルを作成する（createとupdateの時に使う）。一番後ろのediting_appは、74行目のediting_appのこと。
      self.photo_editing_apps.create(editing_app: editing_app)
    end
  end

  def validate_image
    errors.add(:image, :blank) unless image.attached?
  end

end
