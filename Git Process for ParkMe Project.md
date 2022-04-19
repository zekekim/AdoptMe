# Git Process for ParkMe Project

**Creating a branch**

In this project, we will have two main branches. 
1) The ***release*** branch
    a) This branch can be seen as the development branch, where our features will be QA'd before merging into the main branch.
2) The **main**  branch
    a) This branch can be seen as the production branch, where there should be no bugs and should be merged with the release branch at the end of each sprint.
    
**Here are the steps when you are starting to develop a new feature...**
1) Checkout from the **release branch** using the Git command 
    - *git checkout -b feature/{name of your branch}*
        - Try to name the branch so that it is not too long, but we still know what that branch is for.

2) After creating the branch, start developing on that branch you just created in your local environment. Make sure to move your ticket to *In Progress* on the GitHub Project Board.
3) When you finish development in your local environment, test your changes locally. If all your changes are good, then add, commit, and push your branch. You can do that using the following commands...
    - ***git add .*** (if you want to add all the changes in your working directory) 
    - ***git commit -m "**{Add your commit message here describing the changes you made}"*
    - ***git push*** (to push your branch to the respository)
        - Sometimes when pushing a new branch, it may require a different command, but the terminal should tell you the command if you trying pushing a branch that isn't yet on the remote repository.

4) After verifying that your branch is on the Repo, make a Pull Request(PR) into release.
    a) Once the PR is approved by all members on the team, merge your branch into release.
    b) At this point, move your feature issue into the **QA** column to be checked by the other team members.
5) At the end of each sprint, we will then make a PR from the release branch into the main branch. Once this PR is approved by all team members, we will merge all our code from the sprint into the main branch.
