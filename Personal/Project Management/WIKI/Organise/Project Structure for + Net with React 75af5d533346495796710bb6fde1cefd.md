# Project Structure for + .Net with React

<aside>
💡 This 'Article' is to be used in reference on how to create an application in [ASP.NET](http://asp.NET) (3.0) with React.

</aside>

# Walking Skeleton

### Create folders

- Create SLN using
    
    ```bash
    dotnet new sln
    ```
    
- API
    
    ```bash
    dotnet new webapi -n API
    ```
    
- Application
    
    ```bash
    dotnet new classlib -n Application
    ```
    
- Client-App
- Domain
    
    ```bash
    dotnet new classlib -n Domain
    ```
    
- Persistence
    
    ```bash
    dotnet new classlib -n Persistence
    ```
    

# Add References

Add References to the solution

```bash
dotnet sln add Domain/
dotnet sln add Persistence/
dotnet sln add API/
dotnet sln add Application/
```

Application References

```bash
cd Application/
dotnet add reference ../Domain/
dotnet add reference ../Persistence/
```

API References

```bash
cd API/
dotnet add reference ../Application/
```

Persistence References

```bash
cd Persistence/
dotnet add reference ../Domain/
```