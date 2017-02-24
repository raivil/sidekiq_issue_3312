## TODO
- Update Gemfile with user/pass for sidekiq-ent
- Run bundle to update gems

## How to Run
- Run Redis
- Run sidekiqswarm with 4 workers.
COUNT=4 bundle exec sidekiqswarm -q critical -q default -q medium -q low

- Run Rails console and rails server

```
bundle exec rails s
bundle exec rails c
```

- Enqueue jobs specifying how many subjobs should exist.

```
Jobs::Temp::ExampleBatchJob.perform_async(1)
Jobs::Temp::ExampleBatchJob.perform_async(10)
Jobs::Temp::ExampleBatchJob.perform_async(100)
Jobs::Temp::ExampleBatchJob.perform_async(1_000)
Jobs::Temp::ExampleBatchJob.perform_async(10_000)
Jobs::Temp::ExampleBatchJob.perform_async(100_000)
Jobs::Temp::ExampleBatchJob.perform_async(1_000_000)


Jobs::Temp::ExampleLongBatchJob.perform_async(1)
Jobs::Temp::ExampleLongBatchJob.perform_async(10)
Jobs::Temp::ExampleLongBatchJob.perform_async(100)
Jobs::Temp::ExampleLongBatchJob.perform_async(1_000)
Jobs::Temp::ExampleLongBatchJob.perform_async(10_000)
Jobs::Temp::ExampleLongBatchJob.perform_async(100_000)
Jobs::Temp::ExampleLongBatchJob.perform_async(1_000_000)
```
