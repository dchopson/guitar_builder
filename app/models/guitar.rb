class Guitar < ActiveRecord::Base
  belongs_to :order

  FINISHES = {
    gloss: 5,
    raw: 10,
    sunburst: 15
  }

  WOODS = {
    black_cherry: 5,
    cherry: 10,
    ebony: 10,
    mahogany: 5,
    oak: 5,
    pine: 10,
    spruce: 15
  }

  BODY_STYLES = {
    cutaway: 10,
    full: 5,
    half_cutaway: 15
  }

  BODY_WOODS = WOODS.select{|k,v| [:cherry, :mahogany, :spruce].include?(k)}

  BODY_FINISHES = FINISHES.select{|k,v| [:gloss, :raw, :sunburst].include?(k)}

  FRETBOARD_WOODS = WOODS.select{|k,v| [:black_cherry, :ebony].include?(k)}

  FRETBOARD_FINISHES = FINISHES.select{|k,v| [:gloss, :raw].include?(k)}

  NECK_WOODS = WOODS.select{|k,v| [:oak, :pine].include?(k)}

  NECK_FINISHES = FINISHES.select{|k,v| [:gloss, :raw].include?(k)}

  STRING_TYPES = {
    nylon: 5,
    steel: 10
  }

  TUNING_PEG_LAYOUTS = {
    both_sides: 5,
    one_side: 10
  }

  TUNING_PEG_STYLES = {
    rounded: 5,
    square: 10
  }

  def self.method_missing(method, *args)
    guitar_const = Guitar.const_get(method.upcase)
    guitar_const.map do |k,v|
      [
        I18n.t("#{method}.#{k}", scope: [:models, :guitar]),
        k,
        {data: {price: v}}
      ]
    end
  end

  # @return [Integer] the total price of all selected options
  def total_of_selected
    BODY_STYLES[body_style.to_sym] +
    BODY_WOODS[body_wood.to_sym] +
    BODY_FINISHES[body_finish.to_sym] +
    FRETBOARD_WOODS[fretboard_wood.to_sym] +
    FRETBOARD_FINISHES[fretboard_finish.to_sym] +
    NECK_WOODS[neck_wood.to_sym] +
    NECK_FINISHES[neck_finish.to_sym] +
    TUNING_PEG_STYLES[tuning_peg_style.to_sym] +
    TUNING_PEG_LAYOUTS[tuning_peg_layout.to_sym] +
    STRING_TYPES[string_type.to_sym]
  end
end
