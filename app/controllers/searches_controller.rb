class SearchesController < ApplicationController
  before_action :authenticate_user!

  def index
    searchable = params[:conditions].to_s
    if %w(Question Answer Comment User All).include? searchable
      if searchable == "All"
        searchable = "ThinkingSphinx"
      end
      @search = searchable.classify.constantize.search params[:search]
    end
    authorize! :index, @search
  end

end
