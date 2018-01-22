module Admin
  module CategoriesHelper
    def parent_cat_name type_id
      if type_id == Settings.parent_cat
        Settings.parent_name
      else
        parent_cat = Category.find_by id: type_id
        return parent_cat.name if parent_cat
      end
    end

    def load_parent_cat parent_cat = []
      parent_cat << Category.new(id: Settings.parent_cat, name: Settings.parent_name)
      @parent_cats = Category.parent_categories
      @parent_cats.each do |cat|
        parent_cat << cat
        cat.load_childs.each do |child|
          parent_cat << child
        end
      end
      parent_cat
    end
  end
end
