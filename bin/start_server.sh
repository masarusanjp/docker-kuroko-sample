#!/bin/bash -x

set -ex

on_terminate() {
  cat /app/kuroko/tmp/pids/unicorn.pid | xargs kill -TERM
  cat /app/kuroko/tmp/pids/command-executor.pid  | xargs kill -TERM
  cat /app/kuroko/tmp/pids/job-scheduler.pid  | xargs kill -TERM
  cat /app/kuroko/tmp/pids/workflow-processor.pid  | xargs kill -TERM
}

bundle exec rake db:create
bundle exec rake db:migrate
trap 'on_terminate' TERM INT
bundle exec ./bin/rails runner Kuroko2::Servers::CommandExecutor.new.run
bundle exec ./bin/rails runner Kuroko2::Servers::JobScheduler.new.run
bundle exec ./bin/rails runner Kuroko2::Servers::WorkflowProcessor.new.run
bundle exec unicorn -c /app/kuroko/config/unicorn/production.rb -E $RAILS_ENV &
wait
