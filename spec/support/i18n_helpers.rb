require 'yaml'

module I18nHelpers
  PLURALIZATION_KEYS = %w[
    zero
    one
    two
    few
    many
    other
  ]

  def load_locales
    base_i18n_files.each do |file|
      locale = File.basename(file, ".*")
      hash = YAML.load_file(file)[locale]
      locales_to_keys[locale] = get_flat_keys(hash)
    end
  end

  def base_i18n_files
    Dir["config/locales/*.yml"].select { |x| File.basename(x).match(/\A\w\w.yml\Z/) }
  end

  def locales_to_keys
    @locales_to_keys ||= {}
  end

  def locales_to_documents
    @locales_to_documents = locales_to_keys.keys.inject({}) do |hash, locale|
      # E.g. [ "terms" ]
      documents = Dir["config/locales/documents/*.#{locale}.*"].map { |file| File.basename(file, ".#{locale}.markdown") }
      hash.merge locale => documents
    end
  end

  def unique_keys
    locales_to_keys.values.flatten.uniq.sort
  end

  def unique_documents
    locales_to_documents.values.flatten.uniq.sort
  end

  def get_flat_keys(hash, path = [])
    hash.map do |k, v|

      new_path = path + [ k ]

      # Ignore any pluralization differences.
      if v.is_a?(Hash) && looks_like_plural?(v)
        v = "Pretend it's a leaf."
      end

      case v
      when Hash
        get_flat_keys(v, new_path)
      when String
        new_path.join(".")
      else
        raise "wtf? #{ v }"
      end
    end.flatten
  end

  def looks_like_plural?(hash)
    hash.keys.length > 1 && hash.keys.all? { |k| PLURALIZATION_KEYS.include?(k) }
  end
end
