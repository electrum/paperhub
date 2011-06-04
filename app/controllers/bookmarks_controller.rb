class BookmarksController < ApplicationController
  def index
    @bookmarks = @session_user.bookmarks
  end
end
