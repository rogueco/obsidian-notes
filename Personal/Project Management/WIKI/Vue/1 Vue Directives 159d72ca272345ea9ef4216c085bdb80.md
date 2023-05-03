# 1. Vue Directives

# 1. V-Bind:

```html
<p v-text="property1"></p>
<p v-html="property2"></p>
<a v-bind:href="property3">A link to somewhere </a>
```

```jsx
new Vue({
   el: '#anHTMLElement',
   data: {
     property1: "My Property!", 
     property2: 343,
     property3: "<https://www.alinksomwhere.com>" 
  }
});
```

```html
<!-- examples -->
<li v-bind:style="{color:item}" v-for="(item, index) in rainbow">{{ index }} - {{ item }}</li>
<a v-bind:href="property3">A link to somewhere </a>
```

Because ::v-bind::: is used so frequently, VueJS has a nice shorthand way to use this directive. To use the shorthand, you just need to use a single colon before any property which you would like to bind.

# 2. V-ON

```html
<div id="app">
  <h1 v-on:mouseover="functionToRun">Click Me!</h1>
</div>
```

Very much like the v-bind directive, v-on does have a shorthand which allows you to use this directive much easier. You just need to call the ::@:: before any parameter which you want to perform an action/method.

Common Directives are:
- Click
- Mouseover
- MouseEnter
- MouseLeave
- KeyPresss
- KeyDown
- ETC

You are also able to chain ::Event Modifiers:: on the back of the v-on directives - following are examples of modifiers which you can use

- .stop - <!— the click event’s propagation will be stopped —>
- .prevent - <!— the submit event will no longer reload the page —>
- .capture - <!-- modifiers can be chained -->
- .self - <!— just the modifier —>
- .once - <!— use capture mode when adding the event listener —>
- .passive - <!— only trigger handler if event.target is the element itself —>

# 3. V-SHOW

```html
<div id="app">
  <h1 v-show="propertyOnDataObject">Click Me!</h1> <!-- This element will be hidden until the value of "propertyOnDataObject" becomes true -->
</div>
```

```jsx
new Vue({
   el: '#app',
   data: {
     propertyOnDataObject: false
   }
});
```

# 4. V-FOR

```jsx
<div id="app">
     <ul>
       <li v-for="item in list">
         <p>{{ item }}</p>
       </li>
     </ul>
</div>
```

To loop through items without being contained within a div (Causes extra markup) you can use the syntax `<template v-for=""> </template>` - This does not output this to the browser