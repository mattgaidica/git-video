class PagesController < ApplicationController
  before_filter :require_login

  def index
    @user = current_user
    @repos = @user.repos
  end

  def login
  end

  def save
    Video.create(commit_sha: params[:sha], nimbb_guid: params[:guid])
    redirect_to "/commit/#{params[:sha]}?url=https://api.github.com/repos/#{params[:user]}/#{params[:repo]}"
  end

  def remove
    Video.where(commit_sha: params[:sha]).destroy_all
    redirect_to "/commit/#{params[:sha]}?url=#{params[:url]}"
  end

  def repo
    @user = current_user
    if !params[:url].nil?
      @repo = @user.repo(params[:url])
      @commits = @user.commits(params[:url])
    else
      redirect_to root_path
    end
  end

  def repos
    @user = current_user
    @repos = @user.repos
  end

  def commit
    @user = current_user
    if !params[:url].nil?
      @repo = @user.repo(params[:url])
      @commit = @user.commit(params[:url], params[:sha])
    else
      redirect_to root_path
    end
  end
end
