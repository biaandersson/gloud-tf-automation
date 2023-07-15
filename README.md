# GCP Terraform Automation

## Table of Contents

- [About](#about)
- [Getting Started](#getting_started)
- [Usage](#usage)

## About <a name = "about"></a>

Terraform module to create GCP instance infrastructure and install saltstack on the instance.

## Getting Started <a name = "getting_started"></a>

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See [deployment](#usage) for notes on how to deploy the project on a live system.

### Prerequisites

What things you need to install the software and how to install them.

```bash
git clone git@github.com:biaandersson/gloud-tf-automation.git
cd gcloud-tf-automation
```

### Infrastructure

Change the hostname in the `main.tf` file to your own instance name. You'll have to create a service account key in GCP and download the json file. Then change the `GOOGLE_CREDENTIALS` secret in the GitHub repo to the contents of the json file.

You also need to have your own ssh key pair. Change the `ssh-keys` secret in the GitHub repo to the contents of your public key. The private key will be used to ssh into the instance. Remember to change the `generic/modules/automation/scripts/` to set your onw ssh keys.

```bash
module "automation" {
  source        = "./generic/modules/automation"
  instance_name = ["test-example01", "test-example02"]
  salt_master   = false
}
```

If you are creating a salt master, change the `salt_master` variable to `true`.

```bash

module "automation" {
  source        = "./generic/modules/automation"
  instance_name = ["test-saltmaster01"]
  salt_master   = true
}
```

## Usage <a name = "usage"></a>

Upon commit to the main branch, the CI/CD pipeline will run and create the infrastructure in GCP.
It will install the following software on the instance:

- [x] Saltstack Master
- [x] Configure the master config file
- [x] Install the salt-minion(if not a salt master)
- [x] clone the saltstack repo
