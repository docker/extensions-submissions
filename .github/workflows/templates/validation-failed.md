:x: Validation failed with the following errors

> {{ .validation_output }}

Please fix the issues and check everything is ok locally with the following command:

```bash
docker extension validate -a -s -i {{ .extension }}
```

Then you can trigger the validation commenting `/validate` when you are ready.

See [https://docs.docker.com/desktop/extensions-sdk/extensions/validate/](https://docs.docker.com/desktop/extensions-sdk/extensions/validate/){:target="_blank"} for more information.
