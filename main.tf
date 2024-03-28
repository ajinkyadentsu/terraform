provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_storage_bucket" "bucket" {
  name     = var.bucket_name
  location = var.region
}

resource "google_cloudfunctions_function" "function" {
  name                  = var.function_name
  description           = "Triggered by Cloud Storage"
  runtime               = var.runtime
  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.function_code.name
  trigger_event_type    = "google.storage.object.finalize"
  trigger_resource      = google_storage_bucket.bucket.id
  entry_point           = var.entry_point
}

resource "google_storage_bucket_object" "function_code" {
  name   = "${var.function_name}-code.zip"
  bucket = google_storage_bucket.bucket.name
  source = var.function_source_path
}

resource "google_storage_bucket_iam_binding" "invoker" {
  bucket = google_storage_bucket.bucket.name
  role   = "roles/storage.objectViewer"

  members = [
    "serviceAccount:${google_cloudfunctions_function.function.service_account_email}",
  ]
}
