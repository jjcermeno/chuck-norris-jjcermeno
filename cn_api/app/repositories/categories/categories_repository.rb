module Categories
  class CategoriesRepository

    def category_exists?(id)
      Category.where(id: id).first.present?
    end

    def category_exists_by_name?(name)
      Category.where(category_name: name).first.present?
    end

    def read(id)
      category = Category.find(id)
      DataResult.new(data: map_to_dto(category))
    end

    def read_by_name(name)
      category = Category.find(name)
      DataResult.new(data: map_to_dto(category))
    end

    def save(dto)
      category = get_category(dto)

      if category.blank?
        category = Category.new
        if dto.category_name.present?
          category.category_name = dto.category_name
        else
          error_list = [ { title: "Category #{dto.category_name.to_s} could not be created"} ]
          return DataResult.new(errors: StandardError.new("Category #{dto.category_name.to_s} could not be created"))
        end
      end

      mapping_result = map_from_dto(dto, category)
      return mapping_result
    end

    def update(dto, category_id)
      if Category.find(category_id).present?
        category = Category.find(category_id)
      else
        error_list = [ { title: "Category not found: id #{category_id.to_s}"} ]
        return DataResult.new(errors: StandardError.new("Category not found: id #{category_id.to_s}"))
      end
      mapping_result = map_from_dto(dto, category)
      return mapping_result
    end

    def add_new_categories(categories)
      categories.each do |category|
        add_new_category(category)
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

    private

    def get_category(dto)
      return nil unless dto.present?
      return Category.where(category_name: dto.category_name.to_s).first
    end

    def map_to_dto(category)
      category.reload
      dto = CategoryDto.map_to_dto(category)
      dto
    end

    def map_from_dto(dto, category)
      category = CategoryDto.map_from_dto(dto, category)
      DataResult.new(data: map_to_dto(category))
    end

  end
end