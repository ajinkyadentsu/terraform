variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region to deploy resources"
  type        = string
  default     = "us-central1"
}

variable "bucket_name" {
  description = "The name of the Cloud Storage bucket for function code"
  type        = string
}

variable "function_name" {
  description = "The name of the Cloud Function"
  type        = string
}

variable "runtime" {
  description = "The runtime environment for the Cloud Function"
  type        = string
  default     = "python39"
}

variable "entry_point" {
  description = "The entry point to the Cloud Function"
  type        = string
}

variable "function_source_path" {
  description = "Path to the ZIP file containing the Cloud Function code"
  type        = string
}
