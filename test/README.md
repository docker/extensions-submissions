# How to test the workflows locally?

## Prerequisites

You must install [act](https://github.com/nektos/act)

## Run the workflows locally

The test folder contains json files for each scenario you want to test. 
You can run any of the scenarios by running the following command:

```bash
act <event> -e test/<scenario>.json
```

## Use tests.bats

You can also run tests using [bats](https://github.com/bats-core/bats-core).

```node
npm install
npm run test
```
