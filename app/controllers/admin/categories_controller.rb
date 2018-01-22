module Admin
  class CategoriesController < AdminController
    before_action :find_category, only: %i(edit destroy update)
    before_action :check_parent_category, only: %i(destroy)
    before_action :check_cat_exist, only: %i(create update)

    def index
      @categories = Category.paginate page: params[:page],
        per_page: Settings.admin_categories_per_page
    end

    def new
      @category = Category.new
    end

    def create
      @category = Category.new category_params
      if @category.save
        flash[:success] = t ".add_success"
        redirect_to admin_categories_path
      else
        flash.now[:danger] = t ".add_failed"
        render :new
      end
    end

    def edit; end

    def update
      if @category.update_attributes category_params
        flash[:success] = t ".update_success"
        redirect_to admin_categories_path
      else
        flash.now[:danger] = t ".update_failed"
        render :edit
      end
    end

    def destroy
      if @category.destroy
        flash[:success] = t ".delete_success"
      else
        flash[:danger] = t ".delete_failed"
      end
      redirect_to admin_categories_path
    end

    private

    def category_params
      params.require(:category).permit :name, :type_id
    end

    def find_category
      @category = Category.find_by id: params[:id]
      return if @category
      flash[:danger] = t ".category_not_found"
      redirect_to admin_categories_path
    end

    def check_parent_category
      if @category.type_id == Settings.admin_parent_category
        flash[:danger] = t ".can_not_delete"
        redirect_to admin_categories_path
      end
    end

    def check_cat_exist
      @exist = Category.find_by name: params[:category][:name], type_id: params[:category][:type_id]
      return unless @exist
      flash[:danger] = t "admin.categories.exist"
      redirect_to new_admin_category_path
    end
  end
end
