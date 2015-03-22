class Guitar < ActiveRecord::Base
  belongs_to :order

  i18n_scope = [:models, :guitar]

  FINISHES = {
    gloss: [I18n.t('finishes.gloss', scope: i18n_scope), 5],
    raw: [I18n.t('finishes.raw', scope: i18n_scope), 10],
    sunburst: [I18n.t('finishes.sunburst', scope: i18n_scope), 15],
  }

  WOODS = {
    black_cherry: [I18n.t('woods.black_cherry', scope: i18n_scope), 5],
    cherry: ['Cherry', 10],
    ebony: ['Ebony', 10],
    mahogany: ['Mahogany', 5],
    oak: ['Oak', 5],
    pine: ['Pine', 10],
    spruce: ['Spruce', 15],
  }

  BODY_STYLES = {
    cutaway: [I18n.t('body_styles.cutaway', scope: i18n_scope), 10],
    full: [I18n.t('body_styles.full', scope: i18n_scope), 5],
    half_cutaway: [I18n.t('body_styles.half_cutaway', scope: i18n_scope), 15]
  }

  BODY_WOODS = WOODS.select{|k,v| [:cherry, :mahogany, :spruce].include?(k)}

  BODY_FINISHES = FINISHES.select{|k,v| [:gloss, :raw, :sunburst].include?(k)}

  FRETBOARD_WOODS = WOODS.select{|k,v| [:black_cherry, :ebony].include?(k)}

  FRETBOARD_FINISHES = FINISHES.select{|k,v| [:gloss, :raw].include?(k)}

  NECK_WOODS = WOODS.select{|k,v| [:oak, :pine].include?(k)}

  NECK_FINISHES = FINISHES.select{|k,v| [:gloss, :raw].include?(k)}

  TUNING_PEG_STYLES = {
    rounded: ['Rounded', 5],
    square: ['Square', 10],
  }

  TUNING_PEG_LAYOUTS = {
    both_sides: ['Both Sides', 5],
    one_side: ['One Side', 10],
  }

  STRING_TYPES = {
    nylon: ['Nylon', 5],
    steel: ['Steel', 10],
  }

  def self.method_missing(method, *args)
    guitar_const = Guitar.const_get(method.upcase)
    guitar_const.map{|_,v| v}
  end
end
