class FamesController < ApplicationController

  def destroy
    fame = Fame.find(params[:id])
    fame.destroy
    redirect_to feed_url
  end

end
