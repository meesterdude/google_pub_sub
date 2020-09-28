# README

## Setup

1. copy the `config/google_pub_sub.yml.sample` file and populate with your project and credentials file, either via enviroment variables or via the file directly. You can also specify which queues/topics to use here. 
2. run `rake google_pub_sub:setup` to generate the queues listed in the YAML file within google pub/sub. This will also create a dead-letter `morgue` queue
3. run the worker manager (see below) to start/stop workers



## Start/Stop workers

Each worker creates a subscription to a topic on startup, and destroys it on shutdown. Each subscription will forward failed messages to the dead letter queue after 5 failed deliveries. 

```
$ bin/pub_sub_workers start          # start a worker for each queue defined in YAML. Run multiple times for multiple workers. 
$ bin/pub_sub_workers start default  # start a worker for only the default queue
$ bin/pub_sub_workers stop           # stop all workers
$ bin/pub_sub_workers stop default   # stop all workers in the default queue
```

## Exercising

After the workers are started, you can open up a rails console and use the `ArticleAppendTitleJob` to append text to an article's title. If you fail to start the workers beforehand, there will be no subscribers to the topic and the message will be lost. 

## Debug

On OSX, you may see an error containing the following
```
may have been in progress in another thread when fork() was called
```

if so, set this enviroment variable either in your terminal session or `.bash_profile`
```
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
```
