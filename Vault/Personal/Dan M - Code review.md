
Nothing major bud, just some bits that I'd be looking at,

In your solution, you've got your solution folders, but you haven't create them in your actual folder structure. You're solution folders will only show in VS or Rider. In VSC or just in the github repo your seperation isn't shown.

I'd proabaly rename, your folders to 'Battlefield.Core' / 'Battlefield.Infrasructure' - it just adds that bit of polish.

Also, I'd place everything you have within a src folder - It's something I do for when Im creating anything that isn't "for fun" and it's something that I'm going to iterrate from.

I'm not sure with your react application tbh bud. I know it's the .NET template for it but you're giving away swagger and a few other things. I'd just stick with having your API in a API layer and then having a seperate folder for your client application. 

This is my old tech test that I did for inflo, there's quite a bit that I would do differenty, but it should give you an idea on how I consumed an API in react. 

You can use create-react-app to create your app (I used typscript for type safety)

https://github.com/rogueco/infloTech
