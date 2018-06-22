class UserEmailsController < ApplicationController
	include SessionsHelper

	before_action :set_user_email, only: [:edit, :update]
	before_action :set_fax_number, only: [:new]
	before_action :verify_is_client_manager_or_admin, only: [:new, :create]

	def new
		if authorized?(@fax_number.client, :client_manager_id)
			@user_email = UserEmail.new(client_id: @fax_number.client_id)
			@existing_emails = @fax_number.emails
			render :new
		else
			flash[:alert] = "Permission denied."
			redirect_to root_path
		end
	end

	def create
		@fax_number = FaxNumber.find(params[:user_email][:fax_number_id])
		if @fax_number && authorized?(@fax_number.client, :client_manager_id)
			@user_email = UserEmail.new(user_email_params)
			if @user_email.valid?
				@fax_number.user_emails << @user_email
				flash[:notice] = "Email successfully created."
				redirect_to client_path(id: @fax_number.client.id)
			else
				flash[:alert] = @user_email.errors.full_messages.pop
				render :new
			end
		else
			flash[:alert] = @fax_number.errors.full_messages.pop
			render :new
		end
	end

	def edit
	end

	def update
		if @user_email.update_attributes(user_email_params)
			flash[:notice] = "Email successfully edited."
			redirect_to client_path(@user_email.client)
		else
			flash[:notice] = @user_email.errors.full_messages.pop
			redirect_to :edit
		end
	end

	private
		def set_user_email
			@user_email ||= UserEmail.find(params[:id])
		end

		def set_fax_number
			@fax_number ||= FaxNumber.find(params[:id])
		end

		def user_email_params
			params.require(:user_email).permit(:id, :email_address, :client_id, :caller_id_number, :user_id)
		end

		def invite_client_manager_params
			params.require(:user_email).permit(:id, :client_id, :email_address)
		end

		def verify_is_client_manager_or_admin
			unless is_client_manager? && authorized?(@user_email.client, :client_manager_id)
				flash[:alert] = "Permission denied."
				redirect_to root_path
			end
		end
end