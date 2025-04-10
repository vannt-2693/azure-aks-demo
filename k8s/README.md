# Install chart

```bash
helm create app
helm install myapp ./myapp
```

### check chart
```bash
helm lint .

#reder chart
helm template .

helm install --dry-run --debug myapp ./myapp
helm unittest ./myapp
```

### install chart
```bash
helm install -n kaorium-development-phase-support-system-1232 sake-be ./sake-be -f sake-be/values-secrets.yaml
helm install -n kaorium-development-phase-support-system-1232 sake-fe ./sake-fe
```

### upgrade chart
```bash
helm upgrade -n kaorium-development-phase-support-system-1232 sake-fe ./sake-fe
```
