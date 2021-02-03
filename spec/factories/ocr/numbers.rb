# frozen_string_literal: true

FactoryBot.define do
  factory :numbers, class: Ocr::Number do
    line_1 { '' }
    line_2 { '' }
    line_3 { '' }

    initialize_with { Ocr::Number.new(attributes.values) }

    trait :zero do
      line_1 { ' _ ' }
      line_2 { '| |' }
      line_3 { '|_|' }
    end

    trait :one do
      line_1 { ' ' }
      line_2 { '|' }
      line_3 { '|' }
    end

    trait :two do
      line_1 { ' _ ' }
      line_2 { ' _|' }
      line_3 { '|_ ' }
    end

    trait :three do
      line_1 { '_ ' }
      line_2 { '_|' }
      line_3 { '_|' }
    end

    trait :four do
      line_1 { '   ' }
      line_2 { '|_|' }
      line_3 { '  |' }
    end

    trait :five do
      line_1 { ' _ ' }
      line_2 { '|_ ' }
      line_3 { ' _|' }
    end

    trait :six do
      line_1 { ' _ ' }
      line_2 { '|_ ' }
      line_3 { '|_|' }
    end

    trait :seven do
      line_1 { '_ ' }
      line_2 { ' |' }
      line_3 { ' |' }
    end

    trait :eight do
      line_1 { ' _ ' }
      line_2 { '|_|' }
      line_3 { '|_|' }
    end

    trait :nine do
      line_1 { ' _ ' }
      line_2 { '|_|' }
      line_3 { '  |' }
    end
  end
end
