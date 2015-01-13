class OffersController < ApplicationController
  def index
  	@offers = Offer.all
  end

  def show
    @offers = Offer.find(params[:id])
  end

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(offer_params)
    if @offer.save
      redirect_to(:action => 'index')
    else
      render('new')
    end
  end

  def edit
    @offer = Offer.find(params[:id])
  end

  def update
    @offer = Offer.find(params[:id])
    if @offer.update_attributes(offer_params)
      redirect_to(:action => 'index', :id => @offer.id)
    else
      render('edit')
    end
  end

  def delete
    @offer = Offer.find(params[:id])
  end

  def destroy
    Offer.find(params[:id]).destroy
    redirect_to(:action => 'index')
  end
  
  private
#strong params! :code... for Rails 4!
  def offer_params
   	params.require(:offer).permit(:code, :title, :description, :house_rules, :deadline)
  end 
end
