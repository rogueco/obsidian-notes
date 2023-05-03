# How to Create a Merge Request

<aside>
💡 Use this template to describe the steps engineers should follow to create a merge request.

</aside>

### Checkout branch you wish to merge into

```bash
# If you have already made changes on the wrong branch use the following command
git stash

git checkout {branch}

```

### Create New branch

```bash
# Example branch name
git checkout -b 17055-column-headers-in-workprogram-view-overlapping

# Once you have moved onto the relevant branch use the following command if you stashed
# your changes
git stash pop
```

### Add changes (stage)

```bash
# Specific file
git add [fileName]

# All files
git add .
```

### Commit Changes

```bash
git commit -m "Ref #17055: Altered column width on workprogram view."
```

### Push changes

```bash
git push

# You may get an error asking you to set an 'upstream' copy & paste the command
# This should successfully push the code

```

### Create Merge Request (The good stuff)

```bash
# after you have run the above you should get something containing the following message

remote:   https://gitlab.com/inflo/audit/-/merge_requests/new?merge_request%5Bsource_branch%5D=17055-column-headers-in-workprogram-view-overlapping

# follow this link & you can create a merge request
```

<aside>
💡 Be sure you assign this to your scrum lead

</aside>

Ensure you have the latest branch 

```bash
git fetch

# This will show if you are up to date or behind on current branch
git status

# If you are behind use the following command
git pull
```