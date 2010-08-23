module UsersHelper
  def display_errors(errors)
    if( errors.class == Array )
      errors.join(", ");
    elsif( errors.class == String )
      errors
    end
  end
end
