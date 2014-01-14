##
# An extension of the String Class to include some helper methods
class String

  ##
  # Converts the string value of "true" to a boolean true and all other strings to false (case sensitive)
  def to_bool
    self == 'true'
  end
end