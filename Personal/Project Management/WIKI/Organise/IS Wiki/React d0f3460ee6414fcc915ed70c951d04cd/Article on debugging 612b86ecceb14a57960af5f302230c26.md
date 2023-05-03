# Article on debugging

URL: [https://raygun.com/blog/react-debugging-guide/](https://raygun.com/blog/react-debugging-guide/)

## **How to debug React using the browser inspector**

The browser inspector contains many powerful tools, including a debugger. It can be activated from the code by using a `debugger;` statement. Writing `debugger;` is the same as if you were adding **a breakpoint** to your code using the browser. Here’s what debugging using the browser inspector looks like:

![https://raygun.com/blog/images/react-debugging/browser-inspector.png](https://raygun.com/blog/images/react-debugging/browser-inspector.png)

To get started with this, do the following:

1. Modify the code above so that you have a debugger; line within the Counter function. Place it after the line with const, for example.
2. Open the code inspector of your browser, if it isn’t open already.
3. Refresh the page.
4. Note that instead of running the application, the browser will stop the execution. You should see **Paused in debugger** or similar wording. Also, the inspector should point to your code now.

Now that the application is in a frozen state, you can inspect it in various ways. Consider the following examples:

- Hovering over an already executed statement should show you the current value.
- You can step through statements one by one and dive into the execution of functions if you prefer.
- The browser shows you the call stack, which reveals how the code arrived in the spot you’re currently debugging.

There’s functionality beyond this, including value watchers. But the above is enough to give you some idea of how powerful debugging within a browser can be.