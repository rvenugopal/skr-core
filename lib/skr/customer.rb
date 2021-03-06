module Skr

    # Customers Companies (or individuals) you that purchase things from you.
    # They have both a billing and shipping address,
    # a gl account that payments should be applied against, and a payment term.
    class Customer < Skr::Model

        # Common code shared with {Vendor}
        include BusinessEntity

        belongs_to :gl_receivables_account, :class_name=>'GlAccount'
        export_associations :gl_receivables_account

        delegate_and_export  :gl_receivables_account_number
        validates :gl_receivables_account, :set=>true

        private

        def set_defaults
            self.gl_receivables_account ||= GlAccount.find_by_number( Skr::Core.config.default_gl_ar_account_number )
        end
    end

end # Skr module
