class SetSlug
  def before_create(slugable)
    slugable.slug ||= SecureRandom.hex(7)
  end
end
