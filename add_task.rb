#! /usr/bin/ruby
# -*- coding: UTF-8 -*-


require 'erb'
require 'rubygems'
require './data_model.rb'
require 'digest/md5'
require './my_ruby_library/weather.rb'
require './my_ruby_library/login_data.rb'
require 'cgi'
require 'cgi/session'

# CGIを発行
cgi = CGI.new
session = CGI::Session.new(cgi)

# タスクが既に入っているかどうかを調べる
# 0:新規タスク 1:既存タスク
task_name_frag = 0
task_name_id = 0
task_name = Task_name.where(user_id: session['user_id'])
task_name.each do |row|

  if(row.task_name == cgi['task_name'])

    task_name_frag = 1
    task_name_id = row.task_name_id

  end

end

if(task_name_frag == 0)

  # テーブルにデータを追加する
  # category_idは一旦保留で1を挿入する事にしている
  Task_name.create(task_name_id: nil, user_id: "#{session['user_id']}", task_name: "#{cgi['task_name']}", count: 1)

  # 処理の結果を表示する
  # ERBを、ERBHandlerを経由せずに直接呼び出して利用している
  template = ERB.new( File.read('index.erb') )
  puts cgi.header({ 'Content-Type' => 'text/html'})
  print template.result( binding )

else

  # 処理の結果を表示する
  # ERBを、ERBHandlerを経由せずに直接呼び出して利用している
  template = ERB.new( File.read('failed_add_task.erb') )
  puts cgi.header({ 'Content-Type' => 'text/html'})
  print template.result( binding )

end
