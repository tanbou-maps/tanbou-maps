class UserProfileController < ApplicationController
  protect_from_forgery with: :null_session, only: %i[upload upload_profile_picture]

# idを指定せずに表示するユーザープロフィールコントローラー
  def view
    @user = current_user
    render :view
  end

  def new
    @user = current_user
    render :new
  end

  def create
    @user = ApplicationUser.new(user_params)
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def upload
    if params[:file].present?
      uploaded_file = params[:file]
      upload_path = Rails.public_path.join('uploads')
      FileUtils.mkdir_p(upload_path) unless File.directory?(upload_path)
      file_path = upload_path.join(uploaded_file.original_filename)
      File.binwrite(file_path, uploaded_file.read)

      # ユーザーのbackground_picture_urlを更新
      @user = current_user
      @user.update(background_picture_url: "/uploads/#{uploaded_file.original_filename}")

      @image_url = @user.background_picture_url

      render json: { message: 'File uploaded successfully', image_url: @image_url }, status: :ok
    else
      render json: { message: 'No file uploaded' }, status: :unprocessable_entity
    end
  end

  def upload_profile_picture
    if params[:file].present?
      uploaded_file = params[:file]
      upload_path = Rails.public_path.join('uploads')
      FileUtils.mkdir_p(upload_path) unless File.directory?(upload_path)
      file_path = upload_path.join(uploaded_file.original_filename)
      File.binwrite(file_path, uploaded_file.read)

      # ユーザーのprofile_picture_urlを更新
      @user = ApplicationUser.find(params[:id])
      @user.update(profile_picture_url: "/uploads/#{uploaded_file.original_filename}")

      @image_url = @user.profile_picture_url

      render json: { message: 'File uploaded successfully', image_url: @image_url }, status: :ok
    else
      render json: { message: 'No file uploaded' }, status: :unprocessable_entity
    end
  end

  def update_nickname
    @user = current_user
    if @user.update(nickname_params)
      redirect_to user_profile_crud_path(@user), notice: 'ニックネームが更新されました。'
    else
      render :edit
    end
  end

  def update_text
    @user = current_user
    if @user.update(favorite_spots_params)
      render json: { message: 'Text updated successfully' }, status: :ok
    else
      render json: { message: 'Text update failed' }, status: :unprocessable_entity
    end
  end

  def destroy_account
    @user = current_user
    if @user.destroy
      redirect_to root_path, notice: 'アカウントが削除されました。'
    else
      redirect_to user_profile_path(@user), alert: 'アカウントの削除に失敗しました。'
    end
  end


# idを指定して表示するユーザープロフィールコントローラー
def show
  if params[:id].present?
    begin
      @user = ApplicationUser.find(params[:id])
      render :show
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, alert: 'ユーザーが見つかりませんでした。'
    end
  else
    redirect_to new_user_profile_path
  end
end

def view
  @user = ApplicationUser.find(params[:id])
  render :view
end

def create
  @user = ApplicationUser.new(user_params)
  if @user.save
    redirect_to @user, notice: 'User was successfully created.'
  else
    render :new
  end
end

def upload
  if params[:file].present?
    uploaded_file = params[:file]
    upload_path = Rails.public_path.join('uploads')
    FileUtils.mkdir_p(upload_path) unless File.directory?(upload_path)
    file_path = upload_path.join(uploaded_file.original_filename)
    File.binwrite(file_path, uploaded_file.read)

    # ユーザーのbackground_picture_urlを更新
    @user = ApplicationUser.find(params[:id])
    @user.update(background_picture_url: "/uploads/#{uploaded_file.original_filename}")

    @image_url = @user.background_picture_url

    render json: { message: 'File uploaded successfully', image_url: @image_url }, status: :ok
  else
    render json: { message: 'No file uploaded' }, status: :unprocessable_entity
  end
end

def upload_profile_picture
  if params[:file].present?
    uploaded_file = params[:file]
    upload_path = Rails.public_path.join('uploads')
    FileUtils.mkdir_p(upload_path) unless File.directory?(upload_path)
    file_path = upload_path.join(uploaded_file.original_filename)
    File.binwrite(file_path, uploaded_file.read)

    # ユーザーのprofile_picture_urlを更新
    @user = ApplicationUser.find(params[:id])
    @user.update(profile_picture_url: "/uploads/#{uploaded_file.original_filename}")

    @image_url = @user.profile_picture_url

    render json: { message: 'File uploaded successfully', image_url: @image_url }, status: :ok
  else
    render json: { message: 'No file uploaded' }, status: :unprocessable_entity
  end
end

def update_nickname
  @user = ApplicationUser.find(params[:id])
  if @user.update(nickname_params)
    redirect_to user_profile_crud_path(@user), notice: 'ニックネームが更新されました。'
  else
    render :edit
  end
end

def update_text
  @user = ApplicationUser.find(params[:id])
  if @user.update(favorite_spots_params)
    render json: { message: 'Text updated successfully' }, status: :ok
  else
    render json: { message: 'Text update failed' }, status: :unprocessable_entity
  end
end

def destroy_account
  @user = ApplicationUser.find(params[:id])
  if @user.destroy
    redirect_to root_path, notice: 'アカウントが削除されました。'
  else
    redirect_to user_profile_path(@user), alert: 'アカウントの削除に失敗しました。'
  end
end

  private

  def user_params
    params.require(:application_user).permit(:nickname, :email, :password, :password_confirmation, :account_type, :corporate_type,
                                             :profile_picture_url, :background_picture_url, :favorite_spots, :role, :user_id)
  end

  def nickname_params
    params.require(:application_user).permit(:nickname)
  end

  def favorite_spots_params
    params.require(:application_user).permit(:favorite_spots)
  end
end
