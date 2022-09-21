class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ edit update destroy ]

  def index
    respond_to do |format|
      format.html do
        @q = Category.order(:id).ransack(params[:q])
        @pagy, @categories = pagy(@q.result)
      end
      format.csv { send_data Category.as_csv }
    end
  end

  def new
    @category = Category.new
  end

  def edit; end

  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_path, notice: I18n.t('successfully_created', model: I18n.t('activerecord.models.category.one')) }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to categories_path, notice: I18n.t('successfully_updated', model: I18n.t('activerecord.models.category.one')) }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url, notice: I18n.t('successfully_destroyed', model: I18n.t('activerecord.models.category.one')) }
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
