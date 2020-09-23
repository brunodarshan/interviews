# frozen_string_literal: true

class ServiceBase
  attr_reader :success
  alias success? success

  def call
    raise 'must be implemented'
  end
end
