require "dsl_demo/version"

module DslDemo
  class Recipe
    @recipes = Hash.new do |hash, key|
      hash[key] = { ingredients: [], instructions: [] }
    end

    class << self
      def for(recipe_name)
        <<~RECIPE if @recipes.has_key?(recipe_name)
          #{recipe_name}

          Ingredients:
          #{@recipes[recipe_name][:ingredients].uniq * "\n"}

          Instructions:
          #{@recipes[recipe_name][:instructions].uniq * "\n"}
        RECIPE
      end

      def describe(&blk)
        instance_eval(&blk) if block_given?
      end

      private

        def ingredient(ingredient_name)
          @recipes[@recipe_name][:ingredients] << ingredient_name
        end

        def instruction(instruction_name)
          @recipes[@recipe_name][:instructions] << instruction_name
        end

        def recipe(recipe_name)
          @recipe_name = recipe_name
          yield if block_given?
        end
    end
  end
end
