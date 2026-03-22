module ResultsHelper
  def format_time(seconds)
    return "00:00" if seconds.nil? || seconds.zero?

    "%02d:%02d" % [ seconds / 60, seconds % 60 ]
  end

  def side_label(side)
    side == "debit" ? "借方" : "貸方"
  end
end
