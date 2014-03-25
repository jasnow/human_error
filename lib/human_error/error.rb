module  HumanError
module  Error
  def wrap(other)
    wrapped_error = new "#{other.class.name}: #{other.message}"
    wrapped_error.set_backtrace other.backtrace
    wrapped_error
  end
end
end
