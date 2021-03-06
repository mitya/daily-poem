namespace :site do
  task :chdir do
    Dir.chdir "site"
  end

  task serve: :chdir do
    sh "bundle exec middleman serve"
  end

  task build: :chdir do
    sh "bundle exec middleman build --verbose"
  end

  task deploy: :build do
    sh "firebase deploy"
  end

  task :favicons do
    src = "../assets/app-icons/AppIcon-1024.png"

    %w(32 96 152).each do |size|
      dim = "#{size}x#{size}"
      sh "convert #{src} -resize #{dim} src/images/favicon-#{dim}.png"
    end

    sh "convert #{src} -resize 16x16 src/favicon.ico"

    mask = "-size 180x180 xc:none -fill green -draw 'roundRectangle 0,0 180,180 22,22'"
    sh "convert #{mask} #{src} -resize 180x180 -compose SrcIn -composite src/images/favicon-round.png"
  end

  task :screens do
    %w(01Poem 02Sidebar 03Favorites).each_with_index do |name, index|
      dst_1x = "src/images/screen-#{index + 1}.png"
      dst_2x = "src/images/screen-#{index + 1}@2x.png"
      cp "../assets/screenshots/ru/iPhone6-#{name}_framed.png", dst_2x
      sh "convert #{dst_2x} -resize 50% #{dst_1x}"
      sh "pngquant -f -o #{dst_1x} 24 #{dst_1x}"
      sh "pngquant -f -o #{dst_2x} 24 #{dst_2x}"
    end

    promo_src = "../assets/promo/promo-600.png"
    promo_2x = "src/images/promo@2x.png"
    promo_1x = "src/images/promo.png"
    sh "pngquant -f -o #{promo_2x} 10 #{promo_src}"
    sh "convert -resize 50% #{promo_src} #{promo_1x}"
    sh "pngquant -f -o #{promo_1x} 16 #{promo_1x}"
  end

  task :try_compression do
    force = '-f' if false
    src = "src/images/promo@2x.png"

    %w(256 128 64 32 20 16 12 10 8 6).each do |palette|
      sh "pngquant #{force} --ext -p#{palette}.png #{palette} #{src}" rescue true
    end

    # %w(20 30 40 50 60 70).each do |q|
    #   sh "pngquant #{force} --quality=#{q} --ext -q#{q}.png #{src}" rescue true
    #   sh "pngquant #{force} --quality=#{q}-#{q.to_i+20} --ext -q#{q}-#{q.to_i+20}.png #{src}" rescue true
    # end
    #
    # %w(10 20 30 40 50 60 70 80).each do |quality|
    #   sh "convert -quality #{quality} #{src} #{src.sub('.png', "-#{quality}.jpg")}"
    # end
  end
end
