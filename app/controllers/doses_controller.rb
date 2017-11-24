class DosesController < ApplicationController
  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new
  end

  def create
    @dose = Dose.new(dose_params)
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose.cocktail = @cocktail
    # @ingredient = Ingredient.find(params[:dose][:ingredient_id])
    # @dose.ingredient = @ingredient
    # raise
    if @dose.save
      redirect_to cocktail_path(@dose.cocktail.id)
    else render :new
    end
  end

  def destroy
    set_dose
    @dose.destroy
    redirect_to cocktail_path(@dose.cocktail.id)
  end

  private
  def set_dose
    @dose = Dose.find(params[:id])
  end

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
    # if I forget :ingredient_id and add lines above then my @dose dose_params
    # doesn't contain the ingredient and I get a Rails error for nil ingredient
    # instead of getting the can't be blank user error
  end
end
