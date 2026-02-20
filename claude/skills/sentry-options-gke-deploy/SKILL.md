---
name: sentry-options-gke-deploy
description: Deploy sentry-options test image to GKE sandbox and update ConfigMap. Use when deploying, building, or pushing sentry-options to the GKE test environment.
---

# sentry-options GKE Deploy

Deploy sentry-options test image to GKE sandbox and update ConfigMap.

## Prerequisites
- k8s tunnel running: `cd ~/code/terraform-sandboxes.private/personal-sandbox/env/sbx-hdeng-1/bringup-20--gke/ && python3 k8stunnel.py`
- gcloud authenticated: `gcloud auth login`

## Commands

### Build and push Docker image
```bash
cd ~/code/sentry-options
docker build --platform linux/amd64 -f examples/Dockerfile -t us-west1-docker.pkg.dev/eng-dev-sbx--hdeng-2/hdeng-images/sentry-options-test:latest .
docker push us-west1-docker.pkg.dev/eng-dev-sbx--hdeng-2/hdeng-images/sentry-options-test:latest
```

### Restart deployment (pick up new image)
```bash
HTTPS_PROXY=localhost:8888 kubectl rollout restart deployment/sentry-options-test
```

### Update ConfigMap values
Edit `examples/configs/sentry-options-testing/default/values.yaml`:
```yaml
options:
  example-option: "YOUR-VALUE"
  float-option: 0.5
  bool-option: true
```

Then apply:
```bash
cd ~/code/sentry-options
cargo run --bin sentry-options-cli -- write --schemas examples/schemas --root examples/configs --output-format configmap --namespace sentry-options-testing --target default | HTTPS_PROXY=localhost:8888 kubectl apply -f -
```

### Watch logs
```bash
HTTPS_PROXY=localhost:8888 kubectl logs -l app=sentry-options-test --tail=20 -f
```

### Check pod status
```bash
HTTPS_PROXY=localhost:8888 kubectl get pods -l app=sentry-options-test
```

## Key files
- Dockerfile: `~/code/sentry-options/examples/Dockerfile`
- Values: `~/code/sentry-options/examples/configs/sentry-options-testing/default/values.yaml`
- Deployment: `~/code/terraform-sandboxes.private/personal-sandbox/env/sbx-hdeng-1/k8s/deployment.yaml`

## Notes
- ConfigMap propagation takes ~1-2 minutes (kubelet sync period)
- Image uses `:latest` tag, so rollout restart is needed to pick up new images
- Tunnel must be running for all kubectl commands
