module FmInfoFormat
  extend ActiveSupport::Concern

  class_methods do
    attr_accessor :trained_at_club, :trained_at_nation

    def trained_at_club(string)
      string.match?(/club/)
    end

    def trained_in_nation(string)
      string.match?(/nation/)
    end

    def trained_at_date(string)
      return nil if string == '-' || string.blank?

      date_string = string.split(' (').first
      # Date.parse(date_string)
      # bc of month/year/date 🤯
      dates = date_string.split('/')
      Date.new(dates[2].to_i, dates[0].to_i, dates[1].to_i)
    end
  end
end
