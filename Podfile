# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'
source 'https://github.com/Cocoapods/Specs.git'

target 'DailyBookKeeping' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for DailyBookKeeping

  # Swift库
  pod 'SnapKit', '~> 5.6.0'
  pod 'SQLite.swift', '~> 0.14.1'
  pod 'IQKeyboardManagerSwift', '~> 6.5.11'
  pod 'RxSwift', '~> 6.5.0'
  pod 'SwifterSwift', '~> 5.2.0'
  
  # OC库
  pod 'RTRootNavigationController', '~> 0.8.0'
  pod 'MBProgressHUD', '~> 1.2.0'

end

target 'DailyBookKeepingWidgetExtension' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for DailyBookKeepingWidgetExtension

end

post_install do |installer|
  
  pod_Target_dir = Dir.pwd + "/Pods/Target\ Support\ Files"
  
  installer.aggregate_targets.each do |target|
    target.user_build_configurations.each do |key, name|
      #pod生成的xcconfig文件路径
      downcase_key = "#{key}".downcase #转换成小写key
      pod_xcconfig_path = "#{pod_Target_dir}/#{target}/#{target}.#{downcase_key}.xcconfig"
      original_target_name_length = "#{target}".length
      need_target_name = "#{target}"[5,original_target_name_length]

      #Testing对应Adhoc类型的证书
      if downcase_key == "testing"
        downcase_key = "adhoc"
      end
      custom_config_file_path = Dir.pwd + "/#{need_target_name}/Config/#{key}.xcconfig"
      if File::exists?(custom_config_file_path)
        #文件存在,以追加模式打开文件,并include对应的自定义xcconfig文件
        File.open(pod_xcconfig_path,"a") do |afile|
          afile.puts "#include \"#{custom_config_file_path}\""
        end
      else
        #文件不存在
      end
    end
  end
end
