# Tom G

I've renamed the existing `BaseController` to `LegacyBaseController`, and extracted methods that don't depend on runtime dependencies into a new `BaseController`. This means that testing these controllers is much easier, since a given controller's dependencies are all all defined by the constructor (with a few exceptions).

Controllers should be updated to inherit from BaseController directly where refactoring is not too time consuming (I'm happy for leads to have the final judgement on this on an individual basis for now).

**PLEASE DO NOT ADD NEW METHODS TO THE NEW BaseController** (at least without checking with me). This controller is already too bloated as it is, and should only contain extremely basic foundational methods going forward. I intend to refactor much of this into helper classes (similar to UrlHelper etc). Most of the methods in the LegacyBaseController will end up in the ModelMapping project instead

I have updated our domain service tests to use XUnit rather than MSTest, and have moved much of the custom mocking code into a shared project, `Inflo.Testing.Shared`.

**XUnit** is an alternative testing framework, which provides a slightly better API for testing API controllers (and in general). I'm no expert, but xunit seems to be the industry standard at the moment (Microsoft use it for Asp.Net Core internally).
This has a few minor differences vs MSTest, but these should be obvious from looking at the ported tests. I have not yet added these to the other tests projects, but anyone should be able to do this if they need to write tests outside of Inflo.Services.Domain.Tests

**Inflo.Testing.Shared** contains a refactored version of our mock entity services. This features a more modular system of mocks, as well as a more ergonomic data seeding engine (See [EngagementPhaseDomainServiceTests.cs L34](https://gitlab.com/inflo/audit/-/blob/ccf0d73e9cfc07be09396360f6dca559d3bc1a4f/ION/src/Inflo.Services.Domain.Tests/Tests/EngagementPhaseDomainServiceTests.cs#L34) for an example of this).

This also includes the consolidation of many of the service creation methods in DomainServiceTestBase into a single `BuildService` method, that returns a 'special' `IServiceProvider`, which provides fast access to the service you're creating. This can be implicitly cast to the class in question, or be accessed via the `Instance` property.

The `Inflo.WebMS.Tests` project is for **Unit Tests**. (at the moment the tests in Inflo.Services.Domain look more like integration tests). This means that we don't use a mock data access, or in memory DB. Instead, we tell the `IEntityService` exactly what values to return. For example:

```
var entityService = MockEntityReadService.WithData(
  new EngagementWorkprogram { Id = engagementWorkprogramId, EngagementId = engagementId, },
  new EngagementWorkprogram { Id = engagementWorkprogramId + 1, EngagementId = engagementId, }
);

```

Note that this service does not deal with any kind of access restriction or deletion tests - the exact entities you give it are returned verbatim by `GetAll` (using `IEnumerable.AsQueryable()`). This also has the side effect that the mock service is not aware of navigation properties in any way - if you want these to 'work', you'll need to seed them explicitly. For example:

```
var entityService = MockEntityReadService.WithData(new EngagementWorkprogram 
{ 
    Id = engagementWorkprogramId, 
    EngagementId = engagementId, 
    Engagement = new Engagement(), // Initialize the navigation property because the tested code is going to reference it
});
```

I've updated the codebase to support unit testing of Inflo.WebMS. I've added a couple of examples of these, and you can start writing right now!

There were a few things that went into this - each of which deserves attention individually. As such, I'm going to post a string of messaging introducing them