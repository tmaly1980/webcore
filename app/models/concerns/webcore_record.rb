module Concerns
	module WebcoreRecord
		extend ActiveSupport::Concern

		included do
		
		end


			def age(dob) # Shows months if less than a year
			  return nil if dob.blank?
			  now = Time.now.utc.to_date

			  years_months = date_diff(dob,now)
			  years = years_months[0]
			  months = years_months[1]

			  if(years == 1)
			  	return years + " year old"
			  elsif(years > 1)
			  	return years + " years old"
			  elsif (months == 1)
			  	return months + " month old"
			  elsif (months > 1)
			  	return months + " months old"
			  else
			  	return "< 1 month old"
			  end
			end

			def date_diff(date1,date2)
		  		month = (date2.year * 12 + date2.month) - (date1.year * 12 + date1.month)
		  		month.divmod(12)
			end
			
		module ClassMethods
		end
	end
end