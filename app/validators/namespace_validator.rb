class NamespaceValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, :taken_username) if value&.match?(PathRegex.full_namespace_path_regex)
  end
end
