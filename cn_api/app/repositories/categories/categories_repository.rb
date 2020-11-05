module Categories
  class CategoriesRepository

    def category_exists?(id)
      Category.where(id: id).first.present?
    end

    def category_exists_by_name?(name)
      Category.where(category_name: name).first.present?
    end

    def read_by_name(name)
      Category.where(category_name: name).first
    end

    def add_new_categories(categories)
      categories.each do |category|
        add_new_category(category) unless category_exists_by_name?(category)
      end
    end

    def add_new_category(category_name)
      category = Category.create(category_name: category_name)
      category.save
    end

    def get_all_categories()
      CollectionPresenter.new(
        Category.all,
        Api::V1::CategoryPresenter
      )
    end

    def get_current_categories_by_name
      Category.all.map{|category| category.category_name}
    end

  end
end