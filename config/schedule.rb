# Cron jobs to automate sync of dotfiles repo

every 1.day, :at => '8:45 am' do
  command "cd ~/home && git pull"
end

every 1.day, :at => '5pm' do
  command "cd ~/home && git add -A && git commit -m 'nightly auto-push' && git push"
end
