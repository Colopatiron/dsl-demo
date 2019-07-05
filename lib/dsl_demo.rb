require "dsl_demo/version"

module DslDemo
  class Recipe
    attr_accessor :name, :ingredients, :instructions
    @cookbook = []

    def initialize(recipe_name:)
      @name = recipe_name
      @ingredients = []
      @instructions = []
    end

    class << self
      def [](key)
        @cookbook.find { |recipe| recipe.name == key }
      end

      def for(recipe_name)
        self[recipe_name]
      end

      def describe(&blk)
        instance_eval(&blk) if block_given?
      end

      private

        def ingredient(ingredient_name)
          @recipe.ingredients << ingredient_name
        end

        def instruction(instruction_name)
          @recipe.instructions << instruction_name
        end

        def recipe(name)
          return unless block_given?

          @recipe = Recipe.new(recipe_name: name)
          yield
          @cookbook << @recipe
        end
    end

    def to_s
      <<~RECIPE
        #{name}

         Ingredients:
        #{ingredients.uniq * "\n"}

         Instructions:
        #{instructions.uniq * "\n"}
      RECIPE
    end
  end
end
