:x: Validation failed with the following errors

> {{ .validation_output }}

Please fix the issues and check everything is ok locally with the following command:

```bash
docker extension validate -a -s -i {{ .extension }}
```

Then you can trigger the validation commenting `/validate` when you are ready.

See https://docs.docker.com/desktop/extensions-sdk/extensions/validate/ for more information.

---
See [action]({{ .workflow_url }}) for more details.
