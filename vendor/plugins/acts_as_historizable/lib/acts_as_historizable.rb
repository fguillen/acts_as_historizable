# ActsAsCommentable
module Fguillen
  module Acts #:nodoc:
    module Historizable #:nodoc:

      def self.included(base)
        base.extend ClassMethods  
      end

      module ClassMethods
        def acts_as_historizable
          has_many  :histories, 
                    :as => :historizable, 
                    :dependent => :destroy, 
                    :order => 'created_at DESC'
                    
          before_save :update_history
                    
          include Fguillen::Acts::Historizable::InstanceMethods
          # extend Fguillen::Acts::Historizable::SingletonMethods
        end
      end
      
      # This module contains class methods
      module SingletonMethods
        # def find_histories_for(obj)
        #   historizable = ActiveRecord::Base.send(:class_name_of_active_record_descendant, self).to_s
        #  
        #   Comment.find(:all,
        #     :conditions => ["historizable_id = ? and historizable_type = ?", obj.id, historizable],
        #     :order => "created_at DESC"
        #   )
        # end
        
        # # Helper class method to lookup comments for
        # # the mixin commentable type written by a given user.  
        # # This method is NOT equivalent to Comment.find_comments_for_user
        # def find_comments_by_user(user) 
        #   commentable = ActiveRecord::Base.send(:class_name_of_active_record_descendant, self).to_s
        #   
        #   Comment.find(:all,
        #     :conditions => ["user_id = ? and commentable_type = ?", user.id, commentable],
        #     :order => "created_at DESC"
        #   )
        # end
      end
      
      # This module contains instance methods
      module InstanceMethods
        # # Helper method to sort comments by date
        # def comments_ordered_by_submitted
        #   Comment.find(:all,
        #     :conditions => ["commentable_id = ? and commentable_type = ?", id, self.type.name],
        #     :order => "created_at DESC"
        #   )
        # end
        # 
        # # Helper method that defaults the submitted time.
        # def add_comment(comment)
        #   comments << comment
        # end
        

        
        protected
          def update_history
            if self.changed? && !self.new_record?
              historizable = self.class.to_s
                # ActiveRecord::Base.send(
                #   :class_name_of_active_record_descendant, 
                #   self
                # ).to_s

              history = 
                History.create!(
                  :historizable_type => historizable,
                  :historizable_id   => self.id
                )
                
              self.changed.each do |field_changed|
                was, actual = self.send( "#{field_changed}_change" )
                history_line = 
                  HistoryLine.create!(
                    :history_id         => history.id,
                    :field_name         => field_changed,
                    :field_value_was    => was.to_s,
                    :field_value_actual => actual.to_s
                  )
              end
            end
          end
      end
      
    end
  end
end
