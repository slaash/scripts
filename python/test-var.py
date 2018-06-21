ip = "1.1.1.1"
print("""SELECT from_iso8601_timestamp(time) AT TIME ZONE 'Europe/Bucharest' as time, client_ip, elb_status_code, request_processing_time+target_processing_time+response_processing_time AS total_time, request_verb, substr(request_url,1,70) as request_url, user_agent \
FROM alb_logs \
WHERE from_iso8601_timestamp(time) > date_add('minute', -10, now()) and elb_status_code = '200' and client_ip = '{}' \
ORDER BY time DESC """.format(ip))
