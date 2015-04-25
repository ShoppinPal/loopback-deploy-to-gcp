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
7. View it at: http://<version>.loopbackers.appspot.com/explorer/

# Setting up CI with Jenkins
https://cloud.google.com/tools/repo/push-to-deploy?hl=en_US&_ga=1.107528961.260942391.1429898500#connect_your_git_repository_to_the_cloud_repository

1. Get gcloud from https://cloud.google.com/sdk/#Quick_Start
2. On your terminal run `gcloud auth login`
2. Get the name and version number of the most recent Bitnami Jenkins image. 
`gcloud compute images list --project bitnami-launchpad | grep jenkins`
3. Run the following to create the Jenkins VM (password is what's used for the Jenkins admin console, and feel free to pick a higher config VM based on values defined in https://cloud.google.com/compute/docs/machine-types).

  ```
    gcloud compute \
        instances create bitnami-jenkins \
        --project double-platform-92304 \
        --image-project bitnami-launchpad \
        --image bitnami-jenkins-1-610-0-linux-debian-7-x86-64  \
        --zone us-central1-a \
        --machine-type n1-standard-4 \
        --metadata "bitnami-base-password=gN3wu1X9tLv9" \
                   "bitnami-default-user=user" \
                   "bitnami-key=jenkins" \
                   "bitnami-name=Jenkins" \
                   "bitnami-url=//bitnami.com/stack/jenkins" \
                   "bitnami-description=Jenkins." \
                   "startup-script-url=https://dl.google.com/dl/jenkins/p2dsetup/setup-script.sh" \
        --scopes "https://www.googleapis.com/auth/userinfo.email" \
                 "https://www.googleapis.com/auth/devstorage.full_control" \
                 "https://www.googleapis.com/auth/projecthosting" \
                 "https://www.googleapis.com/auth/appengine.admin" \
        --tags "bitnami-launchpad"
  ```
4. Locate the VM under Compute Engine > VM instances in the GCP dashboard. Click on the IP address and allow HTTP and HTTPS traffic. Optionally CloudFlare (or similar service to assign a domain name - for now we have jenkins.shoppinpal.com). 
5. Go to http://jenkins.shoppinpal.com/jenkins/manage > manage plugins and pick Git Plugin, GitHub Authn Plugin, GitHub plugin. One or more of these maybe already installed which is fine. Pick the option to install without restart. 
6. Login to the Jenkins console and choose 'create new job'. Ignore the tooling env settings, doesn't matter since it just seems to be a way to have separate thread executors based on language. 
7. Under 'Source Code Management' pick the Git Repo option and give the full URL (the one you'd use for cloning), for e.g. `https://github.com/pulkitsinghal/loopback-deploy-to-gcp.git`. Creds are not needed if its a public repo. 
8. Set the Repo Browser to 'Auto'. 
9. Build Trigger > select 'when a change is pushed to GitHub'. 
10. Setup github webhook linking to Jenkins along the lines of Step5 here http://fourword.fourkitchens.com/article/trigger-jenkins-builds-pushing-github
