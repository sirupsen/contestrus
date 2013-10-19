module Kernel
  if method_defined?(:gem_original_require)
    alias_method :require, :gem_original_require
  end
end

require_relative '../vendor/bundle/bundler/setup'
