# loopback-deploy-to-gcp

This is a sample on how to use container VMs for a loopback server. You can read more about containers on GCE [here](https://developers.google.com/compute/docs/containers).

There is 1 container that gets deployed into one VM:

  * A simple nodejs application (based on template project by loopback) that implements a basic REST interface.

## Launching
To launch simply have `gcloud compute` configured (see the [Cloud SDK](https://developers.google.com/cloud/sdk/)) with a GCE enabled project and your credentials.  There is no need to have Docker installed on your workstation/development machine.

Run the `start-containers.sh` shell script

This will create a new VM running the 1 container described above. It also opens up the firewall to just this VM so that you can reach the web server running on it.  The containers that are running in the VM are specified in `manifest.yaml`.  It may take a while to get up and running as the container image must be downloaded from the docker registry.

Just hit the `http://<public-IP>:8080/explorer` of the VM with your web browser to access the loopback REST interface.

## Restarting the containers
If you want to change the manifest and reload it, the easiest thing to do is to upload a new manifest and restart the VM hosting the containers.

Run the `restart-containers.sh` script.

## Cleaning up
To clean up the VM, simply run `stop-containers.sh`.  This will delete the VM and its root disk.  Any data on the VM will be lost!

## Modifying the application

  1. Have Docker installed on a development workstation.  You can use a GCE instance for this.  See instructions [here](http://docs.docker.io/installation/google/).
  1. Build your application with (this project should match where you plan to create the VM):

     ```
     docker build -t gcr.io/<your-project-id>/loopback-deploy-to-gce .
	 ```
  1. Push your application to the [Google Container Registry](https://gcr.io) with:

     ```
	 gcloud preview docker push gcr.io/<your-project-id>/loopback-deploy-to-gce
	 ```
  1. Modify `manifest.yaml` to refer to use `gcr.io/<your-project-id>/loopback-deploy-to-gce`.
  1. Start up a new VM with `start-containers.sh` or reload your existing one with `restart-containers.sh`.
