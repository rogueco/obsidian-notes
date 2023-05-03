# Building RESTful Web API's

This Wiki is direvied from Plursights course 'Designing RESTful Web API's'

# The Basics

## Acronyms

- RPC - Remote Procedure Call
- 

## Request

### verb

- get
- put
- post
- update
- delete
- option

### headers

Metadata about the request

- Content Type
    
    The format of the content
    
- Content Length
    
    Size of the content
    
- Authorization
    
    Who is making the call
    
- Accept
    
    What type(s) the call can accept
    
- Cookies
    
    Think of cookies as something which comes along for the ride - a passenger as such.
    

### content

Could be quite literall anything

- HTML, CSS, JavaScript, XML, JSON
- Content is not valid with some verbs
- information to help fulfill request
- Binary and blobs common (e.g. .jpg)

### Status Code

- 100-199 **Informational (*rare)***
- 200-299 **Success**
- 300-399 **Redirection**
- 400-499 **Client Errors**
- 500-599 **Server Errors**