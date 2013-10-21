class PagesController < ApplicationController
  def instructions
    @languages = Language.languages.values
  end
end
