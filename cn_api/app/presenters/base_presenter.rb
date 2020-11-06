# frozen_string_literal: true

class BasePresenter

  attr_reader :resource
  
  def initialize(resource)
    @resource = resource
  end
end
