#! /usr/bin/ruby
# -*- coding: utf-8

# ログインユーザの情報を格納するクラス
class LoginUser

  @@user_id

  def set_userid( user_id )
      @@user_id = user_id
      p @@user_id
  end

  def get_userid
    return @@user_id
  end

end
