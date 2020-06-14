satya = User.create(email: 'satya@example', password: 'changeme', name: 'John')
mona = User.create(email: 'mona@example', password: 'changeme', name: 'Bob')
josh = User.create(email: 'josh@example', password: 'changeme', name: 'Josh')
jack = User.create(email: 'jack@example', password: 'changeme', name: 'Jack')
lee = User.create(email: 'lee@example', password: 'changeme', name: 'Jack')
admin = User.create(email: 'admin@example', password: 'changeme', name: 'Admin', admin: true)

year = Time.current.year
month = Time.current.month

User.all.each do |user|
  for day in 1..Time.current.day-1
    [6,11,12,17].each_with_index do |hour, index|
      time = Time.new(year, month, day, hour, 0, 0, Time.current.formatted_offset)
      event = user.events.create(occurred_at: time, event_type: (index+1).odd? ? :check_in : :check_out)
    end
  end
end
