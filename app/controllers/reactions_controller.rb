class ReactionsController < ApplicationController

  def create
    @reaction = Reaction.new(reaction_params)
    @reaction.user = current_user

    if @reaction.save
      redirect_to request.referer, notice: 'Reaction added'
    else
      redirect_to request.referer, alert: 'Could not add reaction.'
    end
  end

  private

  def reaction_params
    params.require(:reaction).permit(:entry_id, :emote)
  end

end
