require "comedy"

class Submission < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  belongs_to :competition

  validates :source, presence: true
  validates :path, presence: true, if: :source
  validates :language, presence: true, if: :source

  serialize :body

  scope :passed, -> { where(:status => ["Partial", "Passed"]) }
  scope :partial, -> { where(:status => "Partial") }
  scope :completed, -> { where(:status => "Passed") }
  scope :pending, -> { where(:status => "Pending") }

  scope :for_task, ->(task) { where(task: task) }
  scope :during_competition, -> { where("submissions.competition_id IS NOT NULL") }

  before_validation :set_language
  def set_language
    self.language ||= Language.find_by_extension(extension).try(:key)
  end

  after_create :queue_evaluation, on: :create
  def queue_evaluation
    Comedy << EvaluationJob.new(self.id)
  end

  before_create :set_competition, on: :create
  def set_competition
    self.competition = task.competition if task.competition.open?
  end

  # FIXME: LOL
  def passed?
    ["Partial", "Passed"].include?(status)
  end
  alias_method :points?, :passed?

  def completed?
    status == "Passed"
  end

  def partial?
    status == "Partial"
  end

  # FIXME: LOL
  def points
    return 0 unless body
    body.inject(0) { |sum, group|
      if group[1].all? { |test| test[:status] == "Correct" }
        sum + TestGroup.find(group.first).points
      else
        sum
      end
    }
  end

  private
  def extension
    path.split(".").last if path
  end
end
