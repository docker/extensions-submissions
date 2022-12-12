---
name: Extensions submission for publishing
description: Submit your extension to be automatically validated and published on the marketplace
labels: [submission/automatic]
title: "[Submission]: "
body:
    - type: markdown
      attributes:
        value: |
          Hi :wave:, 
          
          Speaking for the whole @docker/extensions, thank you for creating an extension and submitting it!
          
          The process is almost automatic. Once you have filled the following form and submitted this issue, some automatic validations will run.
          
          :+1: If everything goes well, a new label `validation/ok` will be added and the @docker/extensions will be pinged. Later, someone from
          the team will add the `review/ok` which will trigger an automatic job to publish the extension on the marketplace. 
          
          :confused: If there are some issues, we will add the problems as comment and close the issue. Once you have fixed all the problems,
          re-open the issue and the process will start over.
    - type: input
      id: repository
      attributes:
        label: Docker Hub repository link
        description: Provide the Docker Hub repo for your extension so that we can install it
        placeholder: https://hub.docker.com/r/docker/resource-usage-extension
      validation:
        required: true
---

