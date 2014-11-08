Time::DATE_FORMATS[:time_utc] = '%R UTC'
Time::DATE_FORMATS[:datetime] = "%B %d, %Y at %I:%M%P"

#dddd, MMMM Do YYYY, h:mm:ss a
# Sunday, October 15th, 2001, 12:04:01am
Time::DATE_FORMATS[:ffn] = "%B %d, %Y at %I:%M%P"

Rails::Timeago.default_options :limit => proc { 2.years.ago }
