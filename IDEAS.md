Ideas
=====

This is stolen from @rimflores [](http://blog.rlmflores.me/blog/2013/07/16/ruby-patterns-webservice-object/)

```ruby
require 'faraday'
require 'faraday_middleware'

module Github
  class Client
    def initialize
      @connection = Faraday.new(:url => 'https://api.github.com') do |faraday|
        faraday.adapter  Faraday.default_adapter
        faraday.response :json, :content_type => /\bjson$/
      end
    end

    def get(url)
      @connection.get(url).body
    end
  end

  class Organization
    def initialize(organization)
      @organization = organization
    end

    def repos
      @repos ||= client.get(repos_url)
    end

    def info
      @info ||= client.get(info_url)
    end

    private

    def client
      @client ||= Github::Client.new
    end

    def repos_url
      "/orgs/#{@organization}/repos"
    end

    def info_url
      "/orgs/#{@organization}"
    end
  end
end

org = Github::Organization.new('github')

puts org.info['name']
org.repos.each do |repo|
  puts repo['clone_url']
end
```
