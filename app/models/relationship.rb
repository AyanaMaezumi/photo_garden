class Relationship < ApplicationRecord

  # class_name: "Customer"でCustomerモデルを参照
  #フォローしたユーザーとフォローされたユーザーは同じCustomerモデルから持ってきたいが、belongs_to :customerとするとどっちがどっちのcustomerかわからなくなるので、followerとfollowedで分けている。
  #ただこのままだと、followerテーブルとfollowedテーブルを探しに行ってしまうので、class_name: "Customer"でcustomerテーブルからデータをとってきてもらうようにしている。
  belongs_to :follower, class_name: "Customer"
  belongs_to :followed, class_name: "Customer"
end
