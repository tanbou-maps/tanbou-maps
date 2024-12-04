class ContactsController < ApplicationController
  # before_action :ensure_logged_in

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.valid?
      # ContactMailer.contact_email(@contact).deliver_now
      render json: { redirect_url: complete_contacts_path }, status: :ok
    else
      render json: { errors: @contact.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def complete
    render :complete
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
