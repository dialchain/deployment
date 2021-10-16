resource "google_cloud_run_service" "this" {
  name     = lower(var.container-name)
  location = var.region

  connection {}

  template {
    spec {
      containers {
        image = lower(var.container-image)
        ports {
          container_port = var.ports.port
        }
        env {
          name = "APP_PORT"
          value = "9092"
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.this.location
  project     = google_cloud_run_service.this.project
  service     = google_cloud_run_service.this.name

  policy_data = data.google_iam_policy.noauth.policy_data
}


