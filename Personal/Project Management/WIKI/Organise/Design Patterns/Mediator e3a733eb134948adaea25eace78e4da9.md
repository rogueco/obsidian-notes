# Mediator

Description: The Mediator pattern gives us separation of concerns between our API controllers and our Application logic. Our API endpoints need to know nothing about the app logic and are simply responsible for passing an object to the Mediator handler and getting an object back which can be returned to the client. This keeps our API controllers very thin. I appreciate there is an element of duplication here but each handler is its own self contained component that can be tested independently and can be updated independently without worrying about the impact on other handlers.


The Mediatr pattern is used here for testability of our code. Our handlers are separate pieces of code and all we need to test is that when we receive an object in we send the correct object out. If we had static methods we would then need to test our controllers along with our handlers and this is not ideal.