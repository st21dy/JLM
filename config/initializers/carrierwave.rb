require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
    config.storage :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory  = 'japanlacrossemiccle' # 作成したバケット名を記述
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: 'AKIA6QTDEB63VGBYPHCT', # 環境変数
      aws_secret_access_key: 'uL0JdeuPDZFVcf0lfPhW0g3j2xlS1STzpHFEr1cz', # 環境変数
      region: 'us-east-1',
      path_style: true
    }
end