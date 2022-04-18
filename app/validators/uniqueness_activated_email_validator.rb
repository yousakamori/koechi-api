class UniquenessActivatedEmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, :taken_email) if User.activated.exists?(email: value)
  end
end
