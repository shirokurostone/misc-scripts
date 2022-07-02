require 'json'
require 'time'

class TimeWorkflow
  def initialize(time)
    @time = time
  end

  def run(query)
    items = []

    case query
    when "", "now"
      tm = @time.now
      items.push({
        title: "Copy unixtime : '#{tm.to_i}'",
        subtitle: tm.to_s,
        arg: [tm.to_i.to_s]
      })
      items.push({
        title: "Copy localtime : '#{tm.to_s}'",
        subtitle: tm.to_s,
        arg: [tm.to_s]
      })
    when /^\d+$/
      tm = @time.at(query.to_i)
      items.push({
        title: "Convert to localtime : '#{tm.to_s}'",
        subtitle: query,
        arg: [tm.to_s]
      })
    else
      begin
        tm = @time.parse(query)
        items.push({
          title: "Convert to unixtime : '#{tm.to_i}'",
          subtitle: tm.to_s,
          arg: [tm.to_i.to_s]
        })
      rescue ArgumentError
      end
    end

    {items:items}
  end
end

if __FILE__ == $0
  query = "{query}"
  result = TimeWorkflow.new(Time).run(query)
  print(JSON.dump(result))
end
