class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image
  
  has_many :photos
  has_many :favorites, dependent: :destroy
  has_many :likes, through: :favorites, source: :photo
  
  # フォローをした、されたの関係
  #relationshipsとreverse_of_relationshipsがあるが、わかりにくいため名前をつけているだけ。
  #class_name: "Relationship"でRelationshipテーブルを参照する。
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  # 一覧画面で使う
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  has_many :comments
  
  
  #画像の表示
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
  
  
  #フォローしたときの処理
  #find_or_create_by => フォロー1回以上を阻止する。
  def follow(customer_id)
    relationships.find_or_create_by(followed_id: customer_id)
  end
  
  #フォローを外すときの処理
  #(a)&.destroy => 既に外す対象が削除されているにも関わらず、削除のリクエストを送ってしまうことを阻止する。
  def unfollow(customer_id)
    relationships.find_by(followed_id: customer_id)&.destroy
    #follow = relationships.find_by(followed_id: customer_id)
    #follow.destroy if follow
  end
  
  #フォローしているか判定
  def following?(customer)
    followings.include?(customer)
  end


end
