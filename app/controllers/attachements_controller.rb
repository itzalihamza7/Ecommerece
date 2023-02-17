# frozen_string_literal: true

class AttachementsController < ApplicationController
  before_action :set_attachement, only: %i[destroy]
  before_action :authorize_user

  def destroy
    @attachement.purge
    if @attachement.destroyed?
      flash[:notice] = 'Attachement was successfully destroyed.'
    else
      flash[:alert] = 'Attachement was not destroyed.'
    end

    redirect_back(fallback_location: root_path)
  end

  private

  def authorize_user
    authorize @attachement, policy_class: AttachementPolicy
  end

  def set_attachement
    @attachement = ActiveStorage::Attachment.find(params[:id])
  end
end
