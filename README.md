<p align="center">
  <a href="" rel="noopener">
 <img width=600px height=250px src="https://miro.medium.com/v2/resize:fit:1400/1*I1tkE4KvxSfShAZDllAGBA.png" alt="Project logo"></a>
</p>

<h3 align="center">Terraform Automation</h3>

<div align="center">

[![Status](https://img.shields.io/badge/status-active-success.svg)]()
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](/LICENSE)

</div>

---

<p align="center"> Terraform Automation, a project to automate the creation of infrastructure in Cloud, using Terraform and GitHub Actions.
    <br> 
</p>

## Table of Contents

- [About](#about)
- [Getting Started](#getting_started)
- [Usage](#usage)

## About <a name = "about"></a>

This project is a simple example of how to use Terraform and GitHub Actions to automate the creation of infrastructure in Cloud. It will create a VM instance in GCP and install Saltstack on it. It will also clone a saltstack repo and configure the master and minions config files.

## Getting Started <a name = "getting_started"></a>

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See [deployment](#usage) for notes on how to deploy the project on a live system.

### Prerequisites

What things you need to install the software and how to install them.

```bash
git clone git@github.com:biaandersson/gloud-tf-automation.git
cd gcloud-tf-automation
```

### Preparing the environment

You'll have to create a service account key in GCP and download the json file. Then create the `GOOGLE_CREDENTIALS` secret in the GitHub repo to the contents of the json file.

Change the GitHub Actions workflow yaml to be `main` branch instead of `staging`. This is located in the `.github/workflows/terraform.yml` file.

You'll have to change the `project_id` variable in the `variables.tf` file to your own project id. This is located in the `generic/modules/automation/variables.tf` file.

```bash
variable "project_id" {
  description = "Project id of the instance(s) to create"
  default     = "quickstart-terraform"
  type        = string
}
```

You also need to have your own ssh key pair. Change the `ssh-keys` secret in the GitHub repo to the contents of your public key. The private key will be used to ssh into the instance. Remember to change the `generic/modules/automation/scripts/` to set your onw ssh keys.

```bash
ssh-keygen -t ecdsa -f <key-name>
```

### Creating the infrastructure

Change the hostname in the `main.tf` file to your own instance name.

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
