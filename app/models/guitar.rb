class Guitar < ActiveRecord::Base
  belongs_to :order
  
  i18n_scope = [:models, :guitar]
  
  BODY_STYLES = {
    cutaway: [I18n.t('body_styles.cutaway', scope: i18n_scope), 10],
    full: [I18n.t('body_styles.full', scope: i18n_scope), 5],  
    half_cutaway: [I18n.t('body_styles.half_cutaway', scope: i18n_scope), 15]
  }
  
  # def self.method_missing(method, *args)
    # guitar_const = Guitar.const_get(method.upcase)
    # order_const.map{|k,v| v}
  # end
end
