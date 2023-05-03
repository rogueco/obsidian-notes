# Squash all commits

Checkout the branch that you want to squash.

```markdown
git checkout my-random-feature
```

If you do a soft reset, you can keep all of your changes locally, whilst getting the head of the branch you're rebasing off.

```markdown
git reset --soft random-job-to-rebase-off
```

Then you can just commit like normal, FYI this will revert all of your previous commits. So it'll be the first commit on the branch.