module ResqueSchedule
  class CommissionTransfer 
    extend Resque::Plugins::Retry
    @queue = :high

    @retry_limit = 3
    @retry_delay = 60

    def self.perform
      commissions = Commission.group_by_commissionable.pending
      commissions.each do |c|
        c.commissionable.transfer!(c.total_cents)
      end
    end
  end
end