module Kernel
  if method_defined?(:gem_original_require)
    alias_method :require, :gem_original_require
  end

  def gem(*)
    # no-op
  end
end

$:.unshift File.expand_path("../vendor/environment/lib", __dir__)
