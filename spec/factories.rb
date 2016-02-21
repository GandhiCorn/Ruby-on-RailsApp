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
    name "anonymous"
    year 1900
  end
  
  factory :style do
    name "omnom"
    description "tosi hyvää"
  end
  
  factory :style2, class: Style do
    name "cheapo"
    description "tosi köyhää"
  end

  factory :style3, class: Style do
    name "mediocre"
    description "tosi keskinkertaista"
  end
  
  factory :beer do
    name "anonymous"
    brewery
    style
  end
end