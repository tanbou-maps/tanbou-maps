class CorporateProfileController < ApplicationController
  def new
    @user = current_user
    render :new
  end

  def view
    @user = current_user
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
      @user = current_user
      @user.update(background_picture_url: "/uploads/#{uploaded_file.original_filename}")

      @image_url = @user.background_picture_url

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

  private

  def user_params
    params.require(:application_user).permit(:nickname, :email, :password, :password_confirmation, :account_type, :corporate_type,
                                             :profile_picture_url, :background_picture_url, :favorite_spots, :role, :user_id)
  end

  def nickname_params
    params.require(:application_user).permit(:nickname)
  end
end
