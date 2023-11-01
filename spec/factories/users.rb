FactoryBot.define do
    factory :user do 
        email { Faker::Internet.email }
        provider { 'Google' }
        token { '1234dfsdfg5324' }
        uid { '98765' }
    end 
end 