$LOADED_FEATURES << "rubygems"

module Kernel
  if method_defined?(:gem_original_require)
    alias_method :require, :gem_original_require
  end

  def gem(*)
    # no-op
  end
end

require_relative '../vendor/bundle/bundler/setup'
