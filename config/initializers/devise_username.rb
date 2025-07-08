module Devise
  module Models
    module Validatable
      def email_required?
        false
      end

      def will_save_change_to_email?
        false
      end
    end
  end
end
