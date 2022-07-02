require 'json'

query = "{query}"

repos = `/usr/local/bin/ghq list`.chomp.split("\n")

qs = query.split(/\s+/)
items = repos.filter{|r| qs.all?{|q| r.include?(q) } }.map{|r|
  {
    uid: r,
    title: r,
    arg: ["https://"+r],
  }
}

print(JSON.dump({items:items}))
