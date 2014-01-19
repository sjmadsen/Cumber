##
# An extension of the String Class to include some helper methods
class String

  ##
  # Converts the string value of "true" to a boolean true and all other strings to false (case insensitive)
  def to_bool
    self.casecmp('true') == 0 || self.casecmp('1') == 0
  end
end