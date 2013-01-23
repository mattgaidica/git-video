class PagesController < ApplicationController
  before_filter :require_login

  def index
    @user = current_user
  end

  def login
  end

  def save
    Video.create(commit_sha: params[:sha], nimbb_guid: params[:guid])
    redirect_to :back
  end

  def remove
    Video.where(commit_sha: params[:sha]).destroy_all
    redirect_to :back
  end
end
