class User < ActiveRecord::Base
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.nickname = auth["info"]["nickname"]
      user.image = auth["info"]["image"]
      user.token = auth["credentials"]["token"]
    end
  end

  def repos sort="pushed"
    response = HTTParty.get "https://api.github.com/user/repos?access_token=#{self.token}&sort=#{sort}"
    if response.code == 200
      return JSON.parse(response.body)
    end
  end

  def repo repo_url
    response = HTTParty.get "#{repo_url}?access_token=#{self.token}"
    if response.code == 200
      return JSON.parse(response.body)
    end
  end

  def commits repo_url
    response = HTTParty.get "#{repo_url}/commits?access_token=#{self.token}"
    if response.code == 200
      return JSON.parse(response.body)
    end
  end

  #/repos/:owner/:repo/commits/:sha
  def commit repo_url, sha
    self.commits(repo_url).each do |commit|
      return commit if commit['commit']['tree']['sha'] == sha
    end
  end
end
