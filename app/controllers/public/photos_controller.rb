class Public::PhotosController < ApplicationController

  def index
    #検索をかけたときの挙動
    if params[:photo].present?
      if params[:photo][:radio] == 'camera'
        #photoに紐づくcamerasの情報を使えるようにする（joins）。
        #camerasのnameが指定した文字列(photo_params[:search_name])と一致するものを引っ張り出す。
        #"cameras.name LIKE ?"どこの列から検索するか指定している。"%#{photo_params[:search_name]}%"実際の検索するキーワードを入れてる。
        @photos = Photo.joins(:cameras).where("cameras.name LIKE ?", "%#{photo_params[:search_name]}%").page(params[:page]).per(10)
      elsif params[:photo][:radio] == 'editing_app'
        #editing_app
        @photos = Photo.joins(:editing_apps).where("editing_apps.name LIKE ?", "%#{photo_params[:search_name]}%").page(params[:page]).per(10)
      else
        @photos = Photo.joins(:tags).where("tags.name LIKE ?", "%#{photo_params[:search_name]}%").distinct.page(params[:page]).per(10)
      end
    else
    #検索をかけていないときの挙動（初期表示）
      if params[:type] == 'editing'
        photo_ids = PhotoEditingApp.where(editing_app_id: params[:id]).pluck(:photo_id)
        @photos = Photo.where(id: photo_ids).page(params[:page]).per(10)
      elsif params[:type] == 'camera'
        photo_ids = PhotoCamera.where(camera_id: params[:id]).pluck(:photo_id)
        @photos = Photo.where(id: photo_ids).page(params[:page]).per(10)
      elsif params[:type] == 'tag'
        photo_ids = PhotoTag.where(tag_id: params[:id]).pluck(:photo_id)
        @photos = Photo.where(id: photo_ids).page(params[:page]).per(10)
      else
        @photos = Photo.all.page(params[:page]).per(10)
      end

    end

    # 関連先のレコードの個数の昇順でtagsを取得
    @tag_rankings = Tag.select('tags.*', 'count(photos.id) AS photos')
                       .left_joins(:photos).group('tags.id').order('photos desc').first(5)
  end

  def type_search
    @camera_list = []
    @editing_app_list = []
    @tag_list = []
    #binding.pry
    if params[:type] == 'camera'
      @camera_list = Camera.all
    elsif params[:type] == 'editing'
      @editing_app_list = EditingApp.all
    elsif params[:type] == 'tag'
      @tag_list = Tag.all
    end
     # 関連先のレコードの個数の昇順でtagsを取得
      @tag_rankings = Tag.select('tags.*', 'count(photos.id) AS photos')
                         .left_joins(:photos).group('tags.id').order('photos desc').first(3)
  end

  def show
    @photo = Photo.find(params[:id])
    @name_tags = @photo.tags
    @camera_tags = @photo.cameras
    @editing_app_tags = @photo.editing_apps
    @comment = Comment.new
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.customer_id=current_customer.id
    # 受け取った値を,で区切って配列にする
    tag_list=params[:photo][:name_tags].split(',')
    camera = @photo.cameras.new(name: params[:photo][:camera_tags])
    editing_app_list=params[:photo][:editing_app_tags].split(',')
    if @photo.save
      @photo.save_photo_tag(tag_list)
      camera.save
      @photo.save_editing_app_tag(editing_app_list)
      redirect_to photo_path(@photo.id),notice:'投稿に成功しました:)'
    else
      render:new,notice:'投稿に失敗しました'
    end
  end

  def edit
    @photo = Photo.find(params[:id])
    # pluckはmapと同じ意味です！！
    @tag_list=@photo.tags.pluck(:name).join(',')
  end

  def update
    @photo = Photo.find(params[:id])
    #入力されたタグを受け取る
    tag_list=params[:photo][:name_tags].split(',')
    camera_tags=params[:photo][:camera_tags].split(',')
    editing_app_list=params[:photo][:editing_app_tags].split(',')
    #もしphotoの情報が更新されたら
    if @photo.update(photo_params)
      #if params[:photo][:status]== "公開"
    # このphoto_idに紐づいていたタグを@oldに入れる
       @old_relations=PhotoTag.where(photo_id: @photo.id)
    # それらを取り出し、消す。消し終わる
        @old_relations.each do |relation|
        relation.delete
        end
         @photo.save_photo_tag(tag_list)
         @photo.save_camera_tag(camera_tags)
         @photo.save_editing_app_tag(editing_app_list)
        redirect_to photo_path(@photo.id), notice: '更新完了しました:)'
      #else redirect_to photo_path, notice: '下書きに登録しました。'
      #end
    else
      render :edit
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to photos_path, notice: '削除完了しました'
  end

private
  def photo_params
    params.require(:photo).permit( :image,:introduction, :search_name, :radio)
  end

end
