class Public::PhotosController < ApplicationController

  def index
    @photos = Photo.page(params[:page]).per(10)
  end

  def type_search
    @tag_list=Tag.all
    @camera_list=Camera.all
    @editing_app_list=EditingApp.all
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
    photo = Photo.new(photo_params)
    photo.customer_id=current_customer.id
    # 受け取った値を,で区切って配列にする
    tag_list=params[:photo][:name_tags].split(',')
    camera_list=params[:photo][:camera_tags].split(',')
    editing_app_list=params[:photo][:editing_app_tags].split(',')
    if photo.save
      photo.save_photo_tag(tag_list)
      photo.save_camera_tag(camera_list)
      photo.save_editing_app_tag(editing_app_list)
      redirect_to photo_path(photo.id),notice:'投稿完了しました:)'
    else
      render:new
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
    camera_list=params[:photo][:camera_tags].split(',')
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
         @photo.save_camera_tag(camera_list)
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
    redirect_to photos_path, notice: '削除完了しました:)'
  end

private
  def photo_params
    params.require(:photo).permit( :image,:introduction)
  end

end
