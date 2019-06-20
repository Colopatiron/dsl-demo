RSpec.describe DslDemo do
  it "has a version number" do
    expect(DslDemo::VERSION).not_to be nil
  end

  describe ".for" do
    let!(:bacon_surprise) do
      <<~RECIPE
        Bacon Surprise

        Ingredients:
        3 strips of bacon
        1 ampalaya
        1 egg
        1 chili pepper

        Instructions:
        Mince egg
        Cube ampalaya
        Strip bacon
        Sprinkle pepper
        Call 911
      RECIPE
    end

    let!(:hard_boiled_egg) do
      <<~RECIPE
        Hard Boiled Egg

        Ingredients:
        1 Egg
        1L Water

        Instructions:
        Place water in container
        Place egg in water container
        Boil water
      RECIPE
    end

    before do
      described_class::Recipe.describe do
        recipe "Hard Boiled Egg" do
          ingredient "1 Egg"
          ingredient "1L Water"
          instruction "Place water in container"
          instruction "Place egg in water container"
          instruction "Boil water"
        end

        recipe "Bacon Surprise" do
          ingredient "3 strips of bacon"
          ingredient "1 ampalaya"
          ingredient "1 egg"
          ingredient "1 chili pepper"
          instruction "Mince egg"
          instruction "Cube ampalaya"
          instruction "Strip bacon"
          instruction "Sprinkle pepper"
          instruction "Call 911"
        end
      end
    end

    it "prints a recipe for Bacon Surprise" do
      expect(described_class::Recipe.for("Bacon Surprise")).to eq bacon_surprise
    end

    it "prints a recipe for Hard Boiled Egg" do
      expect(described_class::Recipe.for("Hard Boiled Egg")).to eq hard_boiled_egg
    end
  end
end
