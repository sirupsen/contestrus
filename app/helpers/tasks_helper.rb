module TasksHelper
  def submission_class(submission)
    case submission_status(submission)
    when "Pending"
      "info"
    when "Passed"
      "success"
    when "Failed"
      "error"
    end
  end

  def submission_status(submission)
    if pending?(submission)
      "Pending"
    elsif submission.passed?
      "Passed"
    else
      "Failed"
    end
  end

  def pending?(submission)
    submission.evaluations.count == 0
  end
end
