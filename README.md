# NewsApp

Simple News app which uses http://newsapi.org/ to retrieves data. The base architecture of the app is MVVM. Also, it is used coordinator pattern to configure MVVM stack and make dependency injection. Carthage is used as a Dependency manager for more information https://github.com/Carthage/Carthage. The business logic moved to a separated target and presented as a Dynamic framework. This framework approach isolates business logic and helps to run Unit test faster.
