FactoryGirl.define do
  factory :event_1, class: "Event" do
    action "goal"
    half 1
    second 285
    pos_x 235
    pos_y 552
  end

  factory :event_2, class: "Event" do
    action "foul"
    half 2
    second 752
    pos_x 124
    pos_y 369
  end

  factory :event_3, class: "Event" do
    action "free_kick"
    half 2
    second 787
    pos_x 164
    pos_y 469
  end

  factory :event_4, class: "Event" do
    action "foul"
    half 2
    second 987
    pos_x 174
    pos_y 769
  end

end
