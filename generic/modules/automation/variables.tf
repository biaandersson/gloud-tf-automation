variable "instance_name" {
  description = "Name of the instance(s) to create"
  type        = set(string)
}

variable "instance_type" {
  description = "Type of the instance(s) to create"
  default     = "e2-medium"
  type        = string
}

variable "instance_image" {
  description = "Image of the instance(s) to create"
  default     = "ubuntu-os-cloud/ubuntu-2204-lts"
  type        = string
}

variable "instance_region" {
  description = "Region of the instance(s) to create"
  default     = "europe-north1"
  type        = string
}

variable "instance_zone" {
  description = "Zone of the instance(s) to create"
  default     = "europe-north1-a"
  type        = string
}

variable "instance_network" {
  description = "Network of the instance(s) to create"
  default     = "default"
  type        = string
}

variable "static_internal_ip_name" {
  description = "Static internal ip name of the instance(s) to create"
  default     = false
  type        = string
}

variable "network_tags" {
  description = "Network tags of the instance(s) to create"
  default     = ["allow-salt-master", "default-allow-ssh"]
  type        = list(string)
}

variable "instance_disk_size" {
  description = "Disk size of the instance(s) to create"
  default     = 20
  type        = number
}

variable "instance_disk_type" {
  description = "Disk type of the instance(s) to create"
  default     = "pd-ssd"
  type        = string
}

variable "instance_disk_auto_delete" {
  description = "Disk auto delete of the instance(s) to create"
  default     = true
  type        = bool
}

variable "instance_disk_device_name" {
  description = "Disk device name of the instance(s) to create"
  default     = "disk"
  type        = string
}

variable "instance_disk_boot" {
  description = "Disk boot of the instance(s) to create"
  default     = true
  type        = bool
}

variable "network_interface" {
  description = "Network interface of the instance(s) to create"
  default     = "nic0"
  type        = string
}

variable "salt_master" {
  description = "Used to determine if saltmaster or saltminion should be installed"
  type        = bool
}
