class Category < ApplicationRecord
  has_many :book_categories, dependent: :destroy
  has_many :books, through: :book_categories
  has_many :childs, foreign_key: "type_id", class_name: Category.name, dependent: :destroy

  validates :name, presence: true, length: {maximum: Settings.max_name_cat}
  validate :not_found_parent_cat

  scope :parent_categories, ->{where type_id: Settings.parent_cat}
  scope :not_itself, ->(id){where("id != #{id}")}

  def load_category_ids
    childs_array = []
    childs.all.find_each do |child|
      childs_array << child.id
      childs_array << child.find_childs
    end
    childs_array.flatten
  end

  def load_childs step = Settings.step
    childs_array = []
    step += Settings.step_plus
    childs.all.find_each do |child|
      child.name = Settings.childs_name * step << child.name
      childs_array << child
      childs_array << child.load_childs(step)
    end
    childs_array.flatten
  end

  private

  def not_found_parent_cat
    return if (type_id != id) && ((Category.find_by id: type_id) || type_id == Settings.parent_cat)
    errors.add(:type_id, I18n.t("admin.categories.category_not_found"))
  end
end
