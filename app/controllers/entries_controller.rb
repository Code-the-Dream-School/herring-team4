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
    @entries = Entry.public_entries.where(user: current_user.friends.entries)
    @entries = Entry.public_entries.includes(:comments).where(user: current_user.friends)
    @comment = Comment.new
  end

  def friend_entry_show
    @entry = Entry.find_by(id: params[:id])

  end

  def dashboard
    render :entries_dashboard
  end

  def search
    if params[:query].present?

      @results = []
      current_user.entries.all.each do |entry|
        params[:query].split(' ').each do |term|

          location_tags = JSON.parse(entry.location || "[]")
          company_tags = JSON.parse(entry.company || "[]")
          activity_tags = JSON.parse(entry.activity || "[]")

          if term[0] == ":"
            tag_query = term[1..]

            if company_tags.include?(tag_query) || location_tags.include?(tag_query) || activity_tags.include?(tag_query)

              @results << entry
            end

          elsif term[0] == "*"
            emotion_query = term[1..]

            if entry.emotion.downcase == emotion_query.downcase
              @results << entry
            end

          else
            if entry.text.downcase.include?(term.downcase)
              @results << entry
            end

          end

        end
      end
    end

    render :search
  end

  private

  def set_entry
    @entry = current_user.entries.find_by(id: params[:id])
    unless @entry
      redirect_to entries_url, alert: 'Entry not found.'
    end
  end

  def entry_params
    params.require(:entry).permit(:text, :emotion, :energy_level, :private, :is_public, company: [], activity: [], location: [])
  end
end