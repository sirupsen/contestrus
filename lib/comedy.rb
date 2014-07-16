require "thread"

module Comedy
  mattr_accessor :inline

  class Job < ActiveRecord::Base
    self.table_name = "comedy_jobs"

    def perform
      obj = class_name.constantize.allocate
      JSON.parse(ivars).each do |k, v|
        obj.instance_variable_set("@#{k}", v)
      end
      obj.perform
    end
  end

  def self.<<(job)
    if inline
      job.perform
    else
      class_name = job.class.to_s
      ivars = JSON.dump(Hash[job.instance_variables.map { |ivar|
        [ivar.to_s.sub("@", ""), job.instance_variable_get(ivar)]
      }])
      Job.create!(class_name: class_name, ivars: ivars)
    end
  end
end
