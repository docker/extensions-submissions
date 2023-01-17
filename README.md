# Docker Extensions Submissions

## 👋 Welcome!

You have created a Docker Extension and now want to make it available to every Docker Desktop users? Great! This is the right place to submit your extension.

Maybe you are not ready yet but still are seeking feedback? Feel free to use the Show and tell category to share it with the community.

If you haven't created an extension yet, you can find more information on how to do it [here](https://docs.docker.com/desktop/extensions-sdk/).

## How to submit your extension

To submit your extension you need to create a new issue in this repository. Once the issue submitted, the extension 
will be automatically validated. If the validation is successful, someone from the @docker/extensions team will add 
a label and, some time later, your extension will be published and available in the Marketplace to all Docker Desktop 
users.

Under the hood, the validation is done by a GitHub Action. Essentially, it runs the `docker extension validate` 
command. To speed up the process and avoid failures, we recommend you to run this command locally before submitting your extension.

## How my extension can be reviewed

If you want your extension to be listed as reviewed in the Marketplace, you need to fill the form [here](https://www.docker.com/products/extensions/submissions/).
Note that the review process is significantly longer.

## My extension is marked as published but not yet visible on the marketplace

The Marketplace in Docker Desktop is updated when starting and every 12 hours. To force the update, you can restart Docker Desktop.

## My extension is marked as `validation/succeeded` but not published yet?

For the moment, a member of the @docker/extensions team needs to manually add the `publish/ready` label to your 
issue in order to be published automatically.