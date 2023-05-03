
As part of our migration to git, we are moving our package hosting to GitHub as well. (The rest of the code base will be migrated later.) As part of how GitHub authenticates package downloads, each dev will need a GitHub account registered under the DotGolf organisation, and a PAT (Personal Access Token) with at least `packages:read` scope to be able to download and install the packages.First things first, you need a GitHub account (unless you already have one). Go to [https://github.com/signup](https://github.com/signup) to get started. Just enter your email and fill out the form.Please slack me your username so I can add it to our organisation.Instead of using your password, you will need a Personal Access Token (PAT) for authentication when downloading or installing a package for a build. First, you will need to verify your email address, if you haven't already:1. Click your profile photo in the top bar and click settings.  
2. Go to the Access -> Emails section of your settings.  
3. Click the "(re)send verification email" button.  
4. Wait for the email and follow the confirmation link.Once your email is authenticated, you can start generating PATs. You may need a new PAT for different tasks, as each PAT has a different set of permissions. So just follow these steps whenever you need to create a new PAT.1. Click your profile photo in the top bar and click settings.  
2. Go to Developer Settings -> Personal Access Tokens -> Generate New Token  
3. Give the token a descriptive name.  
4. Set the token expiry to something reasonable, depending on the use case.  
5. Select the permissions for this PAT. (In this case, to access packages, select `packages:read`.)  
6. Click Generate TokenYou will be see the new token you've just generated, copy it to your clip-board now, once it is closed you won't be able to see the token again. Paste your new PAT into notepad before you close the page.Once you have a PAT with at **least** `packages:read` permissions, the last steps are to add the GitHub package source to your local machine. Replace `TOKEN` and `USERNAME` in the following commands with the PAT and your username:

```bash
dotnet nuget add source -u rogueco -p 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 -n github --store-password-in-clear-text "https://nuget.pkg.github.com/resilientcode/index.json"
dotnet restore --ignore-failed-sources
```

Note: You need the `dotnet` command installed and in your PATH.See also:* [Verifying your email](https://docs.github.com/en/get-started/signing-up-for-github/verifying-your-email-address)  
* [Creating a PAT](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)  
* [Working with NuGet](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-nuget-registry) (edited)