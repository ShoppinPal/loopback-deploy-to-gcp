# loopback-deploy-to-gcp
Sample loopback app which can be deployed to Google Cloud Platform (GCP)

1. `git clone https://github.com/pulkitsinghal/loopback-deploy-to-gcp.git`
2. `cd loopback-deploy-to-gcp`
3. `gcloud auth login`
4. `gcloud config set project loopbackers`
  1. replace loopbackers with you own project-id from GCP
5. `gcloud preview app run app.yaml`
6. `gcloud preview app deploy app.yaml`
  1. gcloud preview app deploy app.yaml --project <myProjectID> will also work. But if you've already set the project in a previous step, there isn't really any need for it.