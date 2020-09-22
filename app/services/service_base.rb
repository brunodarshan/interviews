# frozen_string_literal: true

class ServiceBase
  attr_reader :success

  def call
    raise 'must be implemented'
  end
end
