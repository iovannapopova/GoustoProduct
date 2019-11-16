# GoustoProduct

## The entry point

The entry point for the application is the AppDelegate.init method. In this method we are creating the main objects of our application, such as data store, controller, router and network client. The controller has a reference to the data store in order to trigger the update when UI appears on the screen. The data store also has a reference to the controller in order to notify the controller about background updates, so the controller can then update the UI.

We are also creating the network client and give it a reference to the data store, so, when the network client fetches the data from the server it can update the data store with the new data. The data store job is to be the main source of data in the application and to keep the data in a consistent state while handling the updates from the network client.

We also have an instance of Router class which is responsible for creating and presenting view controllers in the application, as well as setting up their dependencies (for example, Controller).

## Controller

This class prepares viewModels from model objects for displaying UI in different screens, and implements some protocols because this class has to update UI when viewcontrollers appear, when row is selected and when dataStore updates.


## WebService

WebService service is inspyred by [obc.io](https://talk.objc.io/episodes/S01E133-tiny-networking-library-revisited). Resource struct represents the single endpoint on the backend. We put everything we need to make a request to the server and to parse a response in this struct.

## DataStore

I realised DataStore using this protocols because it doesn't matter which way of storing I will use. I just should to update storage (DataStoreUpdating), to get data (DataStoreProtocol), and have an observer for update actions (DataStoreObserver)

As I understood, I should have chosen what would be the best way for storing data locally, not Core Data specifically.
I used plists since Core Data (or sqlite for that matter) is a little bit overhead for this task:

- the setup is more complicated
- we're rewriting the whole store each time anyway, so we wouldn't gain much from using relational database or object persistence framework, otherwise we'll have to match remote objects with existing ones


