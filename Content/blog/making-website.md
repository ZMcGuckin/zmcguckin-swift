---
date: 2021-07-06 15:40
description: How I recreated my personal website using Swift.
tags: blog, mobile, swift, web
---
# "Swift"ly removing my HTML

## Background
I created my personal website back in 2016 just for fun mostly. I recently had gotten a Raspberry Pi and wanted to try and self host a website on it. I created a basic one page site that linked to my social media's and called it done. In 2020 I got tired of maintaining the Pi and instead moved it over to Firebase (more on hosting later) and it started the spark of wanting to redo my website to host more things like a blog. I was coding in Swift at my day job at the time and recently a well known Swift developer had just opensourced a project called [Publish](https://github.com/JohnSundell/Publish). Publish is a static site generator built in Swift, that utilizes a few other projects like [Plot](https://github.com/JohnSundell/Plot) to also allow you to theme your projects in Swift's coding language as well. As a huge fan of Swift and not a huge fan of plain HTML, this sounded like a lot of fun. Fast forward to 2021 and some free time, and here we are.

## Goal of the site
My main goal was to basically say I coded my website in Swift, anyone who knows about Swift knows it's for creating iOS and MacOS apps so to hear a developer say their site was made using Swift is pretty cool. In terms of the site itself I wanted to still have the personal links on the home page, but wanted to get a little deeper in being able to host a blog and my personal projects. I don't plan on writing weekly or probably even monthly, but when I get time I'd like to write down my thoughts on the current tech world and see how my throughts change over time. I think hosting a blog portion on the site to store these thoughts is a great way of achieving that and also seeing what creativity maybe stems from it. I also wanted to be able to host my Github projects as a way to showcase things that I've worked on. Nothing flashy, just a list of public projects I've created or worked on.

## Getting started
The best part about coding is solving the puzzle. It's also my favorite part about using open source frameworks like Publish that I used to create this website. You start with a blank state of knowledge, you read the documentation for about 30 seconds, and then you dive in. I installed publish, created a new project, ran publish, and 💥 a blank static site was generated! Now for the fun part, how does it work and how do I turn it into what I want it to be. I'm the type of learner that learns best by doing instead of reading. I could read all the documentation about Publish and maybe get a good overall understanding, or I could start breaking it and manipulating and watch what happens and trace my steps to figure out where and why things happen the way they do. I chose the latter and got to breaking it. It was really refreshing being able to write in Swift again, I haven't been doing much Swift at my current company and my side projects have been slightly lagging behind so getting back into Swift was a nice change of pace. I've never been much of an HTML or markup style language fan. I think they're kind of ugly to look at and code, and also leave a lot to be desired in terms of simplicity. That's one thing I really appreciated about being able to write Swift for web was because I was able to get all the things I loved about Swift and also still have it interpreted into web.

### Homepage
<img src="../../images/homePage.png" alt="homePage" width="400"/>

### Code (Plot)
<img src="../../images/homePageCode.png" alt="code" width="400"/>

## Setting up Github Actions
After getting the code to a place where I wanted it, it was time to figure out how to make deploying easier. There's two commands that need to be ran for deploying my site `publish generate` which creates the site, and then `firebase deploy` in order to send the new files to my firebase hosting. This was surprisingly easy to create the workflows and I was not only able to create the deploy automation for each PR merged into main, but I was also able to get a easy preview site up for PRs while they're pending (to make sure everything looks good before merging).

## What's next
As of today the site is in a pretty good state for my wants and goals. When I get more time I'd like to clean up the styling for the pages that aren't the home page. I made the home page how I wanted to look and made the rest functional, but making the other pages look good is also important and my main next step. After that it will be exploring the best way of creating articles. As of now I'm writing the markdown in Xcode, but I could also easily create/edit files on Github directly too (especially on devices without the repo on it). So I'll be figuring out if Github is good enough for editing or if I'd like to move it somewhere else.
