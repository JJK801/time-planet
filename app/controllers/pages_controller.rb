class PagesController < ApplicationController

  def home
  end

  def vision
  end

  def legal
  end

  def become_associate
    @associates_update = AssociatesUpdate.first
  end
end
