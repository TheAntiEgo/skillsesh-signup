class Course < ActiveRecord::Base
  
  ##
  # Validations
  ##
  validates_presence_of :name, :goal, :how

  ##
  # Associations
  ##
  
  belongs_to :user
  has_and_belongs_to_many :skills
  
  ##
  # Instance methods
  ##
  def add_skills_from_str(p)
    str = p[:skills]
    list = str.split(/\,/).map {|s| s.downcase.strip}
    list.each do |s|
      unless Skill.exists?(:name => s)
        self.skills << Skill.new(:name => s)
      else
        self.skills << Skill.find_by(:name => s)
      end
    end      
  end
end
