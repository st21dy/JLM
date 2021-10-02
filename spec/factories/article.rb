FactoryBot.define do
  factory :article do
    title { "testtitle" }
    body { "testbody" }
    caption { '#test' }
    video { Rack::Test::UploadedFile.new(File.join(Rails.root, '/spec/fixtures/JLM.jpg')) }
    user
  end
end