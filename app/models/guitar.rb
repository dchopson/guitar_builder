class Guitar < ActiveRecord::Base
  belongs_to :order

  FINISHES = {
    gloss: 25,
    raw: 0,
    sunburst: 35
  }

  WOODS = {
    black_cherry: 50,
    cherry: 40,
    ebony: 70,
    mahogany: 65,
    oak: 35,
    pine: 25,
    spruce: 30
  }

  BODY_STYLES = {
    cutaway: 40,
    full: 20,
    half_cutaway: 30
  }

  BODY_WOODS = WOODS.select{|k,v| [:cherry, :mahogany, :spruce].include?(k)}

  BODY_FINISHES = FINISHES.select{|k,v| [:gloss, :raw, :sunburst].include?(k)}

  FRETBOARD_WOODS = WOODS.select{|k,v| [:black_cherry, :ebony].include?(k)}

  FRETBOARD_FINISHES = FINISHES.select{|k,v| [:gloss, :raw].include?(k)}

  NECK_WOODS = WOODS.select{|k,v| [:oak, :pine].include?(k)}

  NECK_FINISHES = FINISHES.select{|k,v| [:gloss, :raw].include?(k)}

  STRING_TYPES = {
    nylon: 8,
    steel: 10
  }

  TUNING_PEG_LAYOUTS = {
    both_sides: 15,
    one_side: 20
  }

  TUNING_PEG_STYLES = {
    rounded: 15,
    square: 15
  }

  def self.method_missing(method, *args)
    guitar_const = Guitar.const_get(method.upcase)
    guitar_const.map do |k,v|
      [
        "#{I18n.t("#{method}.#{k}", scope: [:models, :guitar])} - $#{v}",
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
