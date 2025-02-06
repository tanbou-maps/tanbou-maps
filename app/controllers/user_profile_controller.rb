class UserProfileController < ApplicationController
  protect_from_forgery with: :null_session, only: %i[upload_background_picture upload_profile_picture]

  def show
    @user = current_user
    render json: @user
  end

  def new
    @user = current_user
    if @user
      # Rails.logger.debug { "Current user: #{@user.inspect}" }
      # Rails.logger.debug "User JSON: #{@user.to_json}"
      render :new
    else
      Rails.logger.debug "No current user found"
      render json: { error: 'User not found' }, status: :not_found
    end
  end

  def profileview
    @user = current_user
    render :profileview
  end

  def profileviewid
    @user = ApplicationUser.find(params[:id])
    render :profileviewid
  end

  def upload_background_picture
    if params[:file].present?
      uploaded_file = params[:file]
      upload_path = Rails.public_path.join('uploads')
      FileUtils.mkdir_p(upload_path) unless File.directory?(upload_path)
      file_name = "#{SecureRandom.uuid}_#{uploaded_file.original_filename}"
      file_path = upload_path.join(file_name)
      File.binwrite(file_path, uploaded_file.read)

      @user = current_user
      @user.update(background_picture_url: "/uploads/#{file_name}")

      render json: { message: 'File uploaded successfully', image_url: @user.background_picture_url }, status: :ok
    else
      render json: { message: 'No file uploaded' }, status: :unprocessable_entity
    end
  end

  def upload_profile_picture
    if params[:file].present?
      uploaded_file = params[:file]
      upload_path = Rails.public_path.join('uploads')
      FileUtils.mkdir_p(upload_path) unless File.directory?(upload_path)
      file_name = "#{SecureRandom.uuid}_#{uploaded_file.original_filename}"
      file_path = upload_path.join(file_name)
      File.binwrite(file_path, uploaded_file.read)

      @user = current_user
      @user.update(profile_picture_url: "/uploads/#{file_name}")

      render json: { message: 'File uploaded successfully', image_url: @user.profile_picture_url }, status: :ok
    else
      render json: { message: 'No file uploaded' }, status: :unprocessable_entity
    end
  end

  def update_nickname
    @user = current_user
    if @user.update(nickname_params)
      render json: { message: 'Nickname updated successfully' }, status: :ok
    else
      render json: { message: 'Nickname update failed' }, status: :unprocessable_entity
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
      render json: { message: 'Account deleted successfully' }, status: :ok
    else
      render json: { message: 'Account deletion failed' }, status: :unprocessable_entity
    end
  end

  private

  def nickname_params
    params.require(:application_user).permit(:nickname)
  end

  def favorite_spots_params
    params.require(:application_user).permit(:favorite_spots)
  end
end
