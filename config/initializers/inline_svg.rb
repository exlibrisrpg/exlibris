InlineSvg.configure do |config|
  config.asset_file = InlineSvg::CachedAssetFile.new(
    paths: [
      "#{Rails.root}/public/assets/svg"
    ],
    filters: /\.svg/
  )
end
