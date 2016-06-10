#Description
The scripts will either start or stop windows services.

#$services
Simply add the services you want to interact with.
```
$services = "Service1", "Service2", "Service3"
```
The function will run through all the services and starts / stops them.
It will also wait until a services has stopped or started instead of just triggering the action.
This way, you will get an in-time feedback and can also see how long each interaction takes.
