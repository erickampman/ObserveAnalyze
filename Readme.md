# Purpose of ObserveAnalyze and ObserveAnalyze2

In order to better understand how the Observation macros work,
ObserveAnalyze manually expands the macros so I/you can
- anaylze the code
- step through the code in un-macroized form

ObserveAnalyze2 (hopefully) is the same project but it relies on the macros.

## Documentation
### Macros involved:
- [@Observable](https://developer.apple.com/documentation/Observation/Observable())
- [@ObservationTracked](https://developer.apple.com/documentation/observation/observationtracked()/)
- [@ObservationIgnored](https://developer.apple.com/documentation/observation/observationignored()/)
- @storageRestrictions -- Apple documentation not available

### Related protocols:
- [Observable](https://developer.apple.com/documentation/observation/observable)
- [ObservationRegistrar](https://developer.apple.com/documentation/observation/observationregistrar)

### More
- [withMutation](https://developer.apple.com/documentation/observation/observationregistrar/withmutation(of:keypath:_:)
- [ReferenceWritableKeyPath](https://developer.apple.com/documentation/swift/referencewritablekeypath)


## Investigation Notes
### ObservationRegistrar
- access -- source code says: "Registers access to a specific property for observation."
	- access redirection -- Looks like Observable macro causes access of properties to go via the observationRegistrar for the object. This is done by adding the `internal nonisolated func access<Member>` method. Via this method, calls to access are directed to the observationRegistrar for the object.
    - willSet redirection -- Looks like Observable macro causes willSets of properties to go via the observationRegistrar for the object. This is done by added the `internal nonisolated func withMutation<Member, MutationResult>` method. So when the property is modified, this method is called, which causes the call `_$observationRegistrar.withMutation(of: self, keyPath: keyPath, mutation)`

- general note: Since I have not found a way to expand the @Bindable or @Binding macros in Xcode, I'm unable to complete the picture of how ObservationRegistrar is used to notify SwiftUI views that the underlying data has changed. I'd really like to know how this works. 
- There is general info on property wrappers in [The Swift Programming Language](https://books.apple.com/us/book/the-swift-programming-language-swift-5-7/id881256329) book, available via the Apple Book Store. This is really informative, but doesn't go into the particulars of the @Binding and @Bindable property wrappers.
         

##Caveats
- I'm aware there are issues checking out books on iPhones. These projects are illustrating aspects of observability and fixing this is left as an exercise for the reader. 
