# frozen_string_literal: true

module ApplicationHelper
  def error_message(obj, key)
    if obj.errors.messages.keys.include?(key)
       %Q(<small class="text-danger porra"> #{obj.errors.messages[key].join(', ')} </small>).html_safe
    end
  end
end
