class SkillsController < ApplicationController
  respond_to :json
  
  def index
    @skills = Skill.all.distinct.to_json(:only => :name)
    respond_with @skills
  end
end
