require 'csv'

address = "8.8.8.8"
request_count = 5

data = File.read("./servers.csv")
csv = CSV.new(data, col_sep: ";")

results = []

result = CSV.open("./results.csv", "w", col_sep: ";")

results = csv.map do |line|
  ping_result = `ping #{address} -c #{5}`
  average_response_time = ping_result.scan(/min\/avg\/max\/stddev\s\=\s\d+\.\d+\/(\d+\.\d+)\//).flatten[0].to_f
  result << [line[0], "#{average_response_time} ms"]
end
