if !Rails.env.production?
  require "active_record/fixtures"

  module FixtureHelpers
    # Ensure fixtures are identical each time the generator is run by defining a
    # seeded random number generator.
    Faker::Config.random = Random.new(666)

    # Use the same deterministic generator for any other random operations such
    # as Array#sample(random: rng)
    def rng
      Faker::Config.random
    end

    # The collection of systems we want to generate seeds for
    def systems
      %w[death_in_space mausritter mork_borg]
    end

    # The standard set of categories we should define on each system
    def categories
      ["Rules", "Classes", "Gear", "Monsters/NPCs", "Decor", "Adventures", "Etc.", "Tools", "Variants", "Conversions"]
    end

    def each_system_entry(&block)
      systems.each do |system|
        30.times do |index|
          block.call("#{system}_#{index}", system, index)
        end
      end
    end

    def entry_tags(system)
      [
        system_category_tags(system).sample(Faker::Number.between(from: 1, to: 3), random: rng),
        system_creator_tags(system).sample(Faker::Number.between(from: 1, to: 2), random: rng)
      ].flatten.join(", ")
    end

    def system_category_tags(system)
      categories.map(&:parameterize).map(&:underscore).map { |tag| "#{system}_#{tag}" }
    end

    def system_creator_tags(system)
      20.times.map { |index| "#{system}_creator_#{index}" }
    end
  end

  ActiveRecord::FixtureSet.context_class.include FixtureHelpers
end
