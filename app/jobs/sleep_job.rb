class SleepJob
  def initialize(time)
    @time = time
  end

  def perform
    sleep @time
  end
end
