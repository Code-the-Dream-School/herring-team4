class EntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_entry, only: [:show, :edit, :update, :destroy]

  def index
    @entries = current_user.entries.all
  end

  def show
  end

  def new
    @entry = current_user.entries.build
  end

  def edit
  end

  def create
    @entry = current_user.entries.build(entry_params)

    if @entry.save
      redirect_to @entry, notice: 'Entry created.'
    else
      render :new
    end
  end

  def update
    if @entry.update(entry_params)
      redirect_to @entry, notice: 'Entry updated.'
    else
      render :edit
    end
  end

  def destroy
    @entry.destroy
    redirect_to entries_url, notice: 'Entry destroyed.'
  end

  def friends_entries
    @entries = Entry.where(user: current_user.friends)
    @entries = Entry.includes(:comments).where(user: current_user.friends)
    @comment = Comment.new
  end

  private

  def set_entry
    @entry = current_user.entries.find_by(id: params[:id])
    unless @entry
      redirect_to entries_url, alert: 'Entry not found.'
    end
  end

  def entry_params
    params.require(:entry).permit(:text, :emotion, :location, :people, :activity, :energy_level)
  end
end