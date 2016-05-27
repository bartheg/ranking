class ReportComment < ActiveRecord::Base
  belongs_to :report
  belongs_to :profile

end
