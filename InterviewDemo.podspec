Pod::Spec.new do |s|
  s.name         = "InterviewDemo"    #存储库名称
  s.version      = "0.0.1"      #版本号，与tag值一致
  s.summary      = "block测试"  #简介
  s.description  = <<-DESC
  "block测试"  #描述
                   DESC

  s.homepage     = "https://github.com/wei3715/InterviewDemo"      #项目主页，不是git地址
  s.license      = { :type => "MIT", :file => "LICENSE" }   #开源协议
  s.author       = { "zww" => "zwei_ios@163.com" }  #作者
  s.platform     = :ios, "8.0"                  #支持的平台和版本号
  s.source       = "https://github.com/wei3715/InterviewDemo.git" #存储库的git地址，以及tag值
  s.source_files  = "InterviewDemo/InterviewDemo/TestBlock.m" #需要托管的源代码路径
  s.requires_arc  = true #是否支持ARC

end
