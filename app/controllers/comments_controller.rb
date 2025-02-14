class CommentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found

before_action :authenticate_user!
before_action :set_entry
before_action :set_comment, only: [:show, :edit, :update, :destroy]
before_action :authorize_friend!, only: [:create, :new]

  def index
    @comments = current_user.comments
  end

  def show

  end

  def new
    @comment = @entry.comments.build
  end

  def edit
  end

  def create
    @comment = @entry.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to friend_entry_show_path(@entry), notice: 'Comment was successfully created.'
    else
      render :new, alert: 'Unable to save comment.'
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to friend_entry_show_path(@entry), notice: 'Comment was successfully updated.'
    else
      render :edit, alert: 'Unable to update comment.'
    end
  end 

  def destroy
    if @comment.user == current_user || current_user.friend_of?(@entry.user) || @entry.user == current_user
      @comment.destroy
      redirect_to friend_entry_show_path(@entry), notice: 'Comment was successfully deleted.'
    else
      redirect_to friend_entry_show_path(@entry), alert: 'You are not authorized to delete comment.'
    end
  end

  def destroy_another
    @comment = @entry.comments.find_by(id: params[:id])
    if @comment.user == current_user || @entry.user == current_user
      @comment.destroy
       flash[notice:] = 'Comment was successfully deleted.'
    else
       flash[alert:] = 'You are not authorized to delete comment.'
    end
     redirect_to request.referer || entry_path(@entry)
  end

  private

  def authorize_friend!
    unless current_user.friend_of?(@entry.user)
      redirect_to @entry, alert: 'You are not authorized to comment on entry.'
    end
  end

  def comment_params
    params.require(:comment).permit(:text)
  end 

  def set_comment
    @comment = @entry.comments.find(params[:id])
  end

  def set_entry
    @entry = Entry.find(params[:entry_id])
  end

  def catch_not_found(e)
    Rails.logger.debug("We had a not found exception.")
    flash.alert = e.to_s
    redirect_to root_path
  end

end
