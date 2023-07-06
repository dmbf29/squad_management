module FmInfoFormat
  extend ActiveSupport::Concern

  class_methods do
    attr_accessor :trained_at_club, :trained_at_nation

    def trained_at_club(string)
      return false if string == '-' || string.blank?

      string.match?(/club/)
    end

    def trained_in_nation(string)
      return false if string == '-' || string.blank?

      string.match?(/nation/) || string.match?(/club/)
    end

    def trained_at_date(string)
      return nil if string == '-' || string.blank?

      date_string = string.split(' (').first
      # Date.parse(date_string)
      # bc of month/year/date 🤯
      dates = date_string.split('/')
      Date.new(dates[2].to_i, dates[1].to_i, dates[0].to_i)
    end

    def on_loan(string)
      return false if string == '-' || string.blank?

      string.match?(/Out On Loan/)
    end

    def find_position(position)
      return nil if position == '-' || position.blank?

      Position.find_by(name: position)
    end
  end
end
