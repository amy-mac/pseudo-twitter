
FactoryGirl.define do
  factory :tweet do
    tweet_text "I'm tweeting something about the lunch that I ate today because people are lame."
    user_id 4

    factory :invalid_tweet do
      tweet_text "Dolore occaecat qui fugiat qui eiusmod adipisicing magna elit adipisicing velit. Magna elit ex nisi excepteur sit sit proident aliqua culpa adipisicing. Consectetur elit quis consequat minim minim mollit laborum anim cupidatat et cillum sit deserunt. Excepteur labore quis commodo tempor id duis aliqua cupidatat anim occaecat fugiat consectetur. Aute et fugiat labore do est excepteur est."
      user_id nil
    end
  end
end
