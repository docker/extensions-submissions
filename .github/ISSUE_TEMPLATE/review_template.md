---
name: Extensions submission for review
description: Submit your extension to be manually reviewed by the @docker/extension team before it is published on the marketplace
labels: [submission/manual]
title: "[Review]: "
body:
    - type: markdown
      attributes:
        value: |
          Hi :wave:, 
          
          Speaking for the whole @docker/extensions, thank you for creating an extension and submitting it!
          
          First you have filled the following form and submit this issue. Then some automatic validations will run.
          
          :confused: If there are some issues, we will add the problems as comment and close the issue. Once you have fixed all the problems,
          re-open the issue and the process will start over.
          
          :+1: If everything goes well, a new label `validation/ok` will be added and the @docker/extensions will be pinged to start the review.
          We will send you our feedback via email. After the review process is done, we will add the `review/ok` which will trigger an automatic
          job to publish the extension on the marketplace. 
          
    - type: input
      id: repository
      attributes:
        label: Docker Hub repository link
        description: Provide the Docker Hub repo for your extension so that we can install it
        placeholder: https://hub.docker.com/r/docker/resource-usage-extension
      validation:
        required: true
---

