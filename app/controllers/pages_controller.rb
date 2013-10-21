class PagesController < ApplicationController
  skip_before_filter :require_user

  def instructions
    @languages = Language.languages.values
  end
end
