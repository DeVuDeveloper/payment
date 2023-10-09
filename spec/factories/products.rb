
FactoryBot.define do
  factory :product do
    name { 'Surly Midnight' }
    description { 'Midnight special shines on pot-holed, deteriorating pavement and the occasional long stretch of gravel.
                   Its 650b road plus tyres eat up road chatter and absorb all the bumps in the road like the champion it was designed to be.'}
    
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'images', 'bike.jpg')) }
  end
end
