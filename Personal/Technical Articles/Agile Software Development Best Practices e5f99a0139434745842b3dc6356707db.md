# Agile Software Development Best Practices

Article Link: https://colin-but.medium.com/agile-software-development-best-practices-a164542fbcb2
Date Added: March 18, 2021 10:39 AM
Tag: Code Review

# **Agile Software Development Best Practices**

[Colin But](https://colin-but.medium.com/?source=post_page-----a164542fbcb2--------------------------------)

[May 20, 2019·7 min read](https://colin-but.medium.com/agile-software-development-best-practices-a164542fbcb2?source=post_page-----a164542fbcb2--------------------------------)

![https://miro.medium.com/max/875/1*-Jq5gr3Y9OEBLvhVVbWCRw.jpeg](https://miro.medium.com/max/875/1*-Jq5gr3Y9OEBLvhVVbWCRw.jpeg)

Here, I’m going to list some of what I believe are best practices in agile software development.

# **Do Code Reviews**

Assuming you’re not a one man (or woman) band writing software for your company/team/projects then it is very ideal to have ‘peer reviews’ i.e. have another developer or developers reviewing your code. It is always good to have an extra pair of eyes.

Ideally if possible, get your code reviewed by at least 2 other developers.

A good thing about Code Reviews is that sometimes you might get to learn some new stuff from other developers. They critique your code. If they do good code reviews then they probably suggest improvements to your code. And from there, you learn some new ideas. Which is always good. Right? Because learning is good! Always learning!

Another positive effect of code reviews is that it can spark good technical debate and discussions amongst developers if done correctly. Again, you learn ideas from others. You get to hear different opinions.

But care must be taken. One must ensure, code reviews don’t turn into what some people call PR Wars (Pull Request wars). This can happen if you have a team of 4 or 5 developers and every developer is reviewing one developers code… and you get conflicting sides of arguments. Yes, you get different ideas and you can learn from each other; and, at the same time having a tech discussion, but there’s danger of it being dragged on too long if some developers are not willing to compromise and always wanting to do stuff their way!

On the other hand, If no code reviews are done, with all your development process is more of a dictatorship style with work being assigned to you and you’re told what to do and how to do it… you’re not going to learn anything at all. Moreover, it is not going to help the codebase either. Because the codebase will always follow a particular style or way of coding (the style and way of coding of the person who tells you what & how to do your work). This is certainly no fun. In this scenario you are really just an Implementor. I always believe that as a Developer you should also be given the freedom to design your code. Yes, development can be engineering sometimes and there will always be perhaps one way of doing that thing, but more often than not, it is also an art. Any form of art requires creativity.

# **Avoid checking into main branch**

Personally, for me, this is a no-no. Not just because I don’t like it. But because…

Again, another assumption is you’re working your user stories on your ‘feature branches’ then you should really stick to this procedure regardless of what kind of work you checking in.

So, by whatever means, resist the temptation to commit directly into the main branch (whatever that is) in particular for quick bug hot fixes. This is because it allows what I mentioned above in **Do Code Reviews** section — to have an extra pair of eyes.

For sure, you can pair programming on your ‘quick fix’ and you can claim it’s being ‘reviewed’ by another developer. What I would say is, if you have a process in place then why break it. Yes, you can also say it’s pragmatic or claim that it’s needs must — due to the situation (delivery deadline to client for instance)…

… but doing this is like *going to the dentist and obey the dentist’s plea for non-sugary consumptions in order for better teeth only then some time later to violate them by eating sugary foods again*.

# **Prefer short staying branch over long-lived branches**

Speaking of ‘features branches’ … avoid creating feature branches that stay for a very long time.

How long is long?

Well… that’s for you to decide amongst your team.

The reason is, if you have long living branches, it is likely that other developers will be working on other features in parallel to you. They might finish their feature before you and their work would have been checked in to the main branch. This means… you feature branch will deviate from the main branch A LOT!

Imagine trying to merge the main branch onto your feature branch at that time to keep your branch up to date. It would be a nightmare. You possibly end up with numerous conflicts.

You really want to avoid ‘Merge Hell’

You might think this is not a big problem. With VCS like GIT you can “rebase” your branch onto the main branch. But this is not a guarantee to succeed. I’m not a massive fan of GIT rebase to be honest. I like that it is powerful and definitely handy. But use with caution. A comparison of ‘merge’ vs ‘rebase’ is beyond here so I will not go off into a tangent… You can find already many existing articles online which talks about the pros and cons of each approach.

All in All, I like short lived feature branches where I can dispose off once merged after I have finished my user story (feature).

I mean… why need to keep it hanging around?

Yes, you might need additional work on that (bug fixes, work not originally thought of etc.) when the user story heading back your way after QA testing.

I would ideally treat it as new feature. So create a new feature branch!

# **Always do a local build …**

before submitting Pull Request (PR) if you’re using GitHub/BitBucket etc. or Merge Requests (MR) if you’re using something like GitLab.

Just a sanity check really and it’s really good practice to do so too.

You really don’t want your CI build to fail after the merge when the failure can be prevented by double checking locally with a local build.

Just imagine that for a second.

1. You finish your work so you create a request for merge on your VCS.
2. It’s get reviewed. Reviewers fail to spot what could fail — just because you have reviewers checking your code doesn’t mean they can find every fault in your code.
3. It gets merged!
4. CI build kicks in.
5. Uh Oh! Big Red sign in your CI tool. Your build fails and all your team members get notified via email or messaging chat that you broke the build.
6. Yes! You!

You then realise your build doesn’t even build locally on your own machine. I mean, come on’

Have you been there before? Does above sounds familiar?

I confess, this happened numerous time throughout my career — to ME! I was the guilty party. Lessoned learned of course. Always double check your work as much as possible with a local build.

For sure, it can still fail on the CI build due to other reason, but at least you know it’s not because of your ‘faulty’ code — meaning you don’t really need to submit a new request to merge in a very very minor change that can be avoided.

—

Do note that a lot of VCS systems these days does a lot of good integration work with CI servers allowing you to kick of a build on the merge request when submitting a request meaning you can detect the problem early on.

But still, there’s no harm in doing a local build to check that it builds locally.

# **Writing Documentation to help others**

Of course, if you’re doing Agile Development, one must not believe Documentation is bad or is forbidden. They do exists within Agile. Agile usually means moving with agility, put aside the bureaucratic long winding processes but doesn’t necessary mean no documentation. Documentation still are helpful.

So, be a good citizen.

Help others. Help Yourself.

If there’s something you feel worth documenting, then document it. Put it on the project wiki if you have one. Other people can refer to that. And if you leave one day, new joiners will be able to use that as a handover guide or a reference manual to learn.

It will help others in the future.

# **Stay away from Shortcuts**

Try not to take short cuts. There will be times when pressure is on you.

I understand that deadlines are important.

I also understand that delivering business value is important.

But equally, as a Software Developer, Software Craftsmanship is just as important!

Deter away from that and you’re heading down a path for poor quality of code.

It is not just about getting it to work. I have personal experiences for big enterprise that business functionality is above everything. Delivering business features and satisfying the business is everything. That’s not good. What will happen is you end up with horrible codebases that no Software Developers like to work in.

Actually, I should really say … with horrible codebases that no Software Developers who cares about Software Craftsmanship like to work in…

Furthermore, don’t fall into the trap of believing making shortcuts in development are just pragmatic decisions. Yes, they may be pragmatic at the time. But constant pragmatism will highly likely to lead you to a point of no return.

# **Boy Scout Rule**

In programming, it means “Always leave the codebase a better place than before you visited it.”

These days, i take this rule close to my heart.

Whenever I see an opportunity to refactor the code in order to make it better then I do it. I don’t hesitate. Of course, I will be as sensible as I can and not make wholesale changes. That’s just ridiculous.

And if I see something that I consider bad or not so good. I clean it up in no time at all. I make it better. I don’t add to the ‘rubbish’. Because if you do, you would fall into the trap of the **Broken Windows** theory.

The idea is that if you see lots of broken windows on a building, then you’re very likely to break those windows more. Don’t be that person.

So don’t be that Developer.

# **Final Thoughts**

Above are just some of my own personal views of what I believe are best practices in agile software development.

If you like or agree, then please give me a few claps. Feel free to leave a comment or two if you disagree and have different views. I’m open to hear some opposing opinions on these.