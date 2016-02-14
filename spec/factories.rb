FactoryGirl.define do
  factory :user do
    username "Pekka"
    password "Foobar1"
    password_confirmation "Foobar1"
  end

  factory :rating do
    score 10
  end

  factory :rating2, class: Rating do
    score 20
  end

  factory :brewery do
    name ["Sinebrychoff", "Auran panimo", "Saimaan Juomatehdas", "Lapin Kulta", "Olvi", "Stadin Panimo",
          "Laitilan Wirvoitusjuomatehdas", "Nokian Panimo", "Teerenpeli", "Suomenlinnan Panimo"].sample
    year {rand(1900..2010)}
  end

  factory :beer do
    name {generate(:name)}
    style ["Weizen", "Lager", "Pale ale", "IPA", "Porter"].sample
  end

  sequence :name do |n|
    "Beer #{n}"
  end
end