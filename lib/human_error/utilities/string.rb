class   HumanError
module  Utilities
class   String
  def self.underscore(other)
    word = other.to_s.gsub('::', '/')
    word.gsub!(/(?:([A-Za-z\d])|^)(?=\b|[^a-z])/) { "#{$1}#{$1 && ''}" }
    word.gsub!(/([A-Z\d]+)([A-Z][a-z])/,'\1_\2')
    word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
    word.tr!("-", "_")
    word.downcase!
    word
  end
end
end
end
