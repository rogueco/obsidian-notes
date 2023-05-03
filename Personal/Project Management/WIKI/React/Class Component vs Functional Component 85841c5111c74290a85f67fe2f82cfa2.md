# Class Component vs Functional Component

Created: March 26, 2021 11:02 AM

- Difference between a Class Component and a functional Component
    - My understanding is that class components, can have state and it has lifecycle hooks. “componentDidMount” componentDidUpdate which essentially allows state to be mutated

They used to be the defacto in react - I can’t profess that I have used them an awful lot. The code base at Barbon was all in Class Components

The difference in functional Components, used to be known and I suppose they still are known as “dumb” components as they just receive props. That was, before React Released hooks. Which allows you to inject State into the component. And it is now really the go to way of creating a component.