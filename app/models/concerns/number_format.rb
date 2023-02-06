module NumberFormat
  extend ActiveSupport::Concern

  class_methods do
    attr_accessor :format_price

    def format_price(string_number)
      # changing "£2.5M - £5.4M" or "£5.4K" to an integer
      highest_num = string_number.split(' - ').last
      case highest_num[-1]
      when 'M' then highest_num[1..-2].to_f * 1000000
      when 'K' then highest_num[1..-2].to_f * 1000
      else
        highest_num[1..-1].to_i
      end
    end
  end
end
