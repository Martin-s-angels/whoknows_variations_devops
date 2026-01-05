# ¿Who Knows? - DevOps Transformation

**¿Who Knows?** is a search engine application originally built in 2009. This repository represents a modern DevOps transformation of that legacy application, migrating it from a legacy Python environment to a containerized Ruby/Sinatra architecture with a full CI/CD pipeline and monitoring stack.

## 📊 Build Status

| Workflow | Status |
| :--- | :--- |
| **Continuous Integration** | [![.github/workflows/continuous_integration.yml](https://github.com/Martin-s-angels/whoknows_variations_devops/actions/workflows/continuous_integration.yml/badge.svg)](https://github.com/Martin-s-angels/whoknows_variations_devops/actions/workflows/continuous_integration.yml) |
| **Full CD CD** | [![full_cd_cd](https://github.com/Martin-s-angels/whoknows_variations_devops/actions/workflows/full_cd_cd.yml/badge.svg)](https://github.com/Martin-s-angels/whoknows_variations_devops/actions/workflows/full_cd_cd.yml) |

---

## 🛠 Tech Stack

* **Application Framework:** Ruby (Sinatra)
* **Web Server:** Puma (App) / Nginx (Reverse Proxy)
* **Database:** PostgreSQL
* **Containerization:** Docker & Docker Compose
* **CI/CD:** GitHub Actions & GitHub Container Registry (GHCR)
* **Monitoring:** Prometheus & Grafana
* **Code Quality:** RuboCop

---

## 📂 Project Structure

This repository is divided into two main sections:

* **`who_knows/`**: The modernized Ruby application.
* **`legacy/`**: The original Python/Flask application (kept for reference).

---

## 🚀 Getting Started

### Prerequisites
* Docker & Docker Compose
* Ruby 3.4+ (if running locally without Docker)

### 1. Docker Development Environment (Recommended)

The project is configured to run fully containerized, including the app, Prometheus, and Grafana.

1.  **Build and run the stack:**
    ```bash
    docker compose -f who_knows/.devops/docker-compose.dev.yml up --build
    ```

2.  **Access the services:**
    * **Web App:** [http://localhost:8080](http://localhost:8080)
    * **Prometheus:** [http://localhost:9090](http://localhost:9090)
    * **Grafana:** [http://localhost:3000](http://localhost:3000)

### 2. Local Ruby Installation

If you prefer to run the application directly on your machine:

1.  **Navigate to the application directory:**
    ```bash
    cd who_knows
    ```

2.  **Install dependencies:**
    ```bash
    bundle install
    ```

3.  **Setup Environment Variables:**
    Create a `.env` file in `who_knows/.dotenv/` based on your needs (see `app/model/weather.rb` for usage).

4.  **Initialize the Database:**
    ```bash
    bundle exec ruby db/init_db.rb
    ```

5.  **Run the Application:**
    ```bash
    bundle exec rackup config/config.ru -p 8080
    ```

---

## 🔄 DevOps Pipeline

This repository utilizes GitHub Actions to manage the software lifecycle:

1.  **Continuous Integration (CI):**
    * Triggers on Pull Requests to `master`.
    * Runs dependency installation and controller tests.
2.  **Continuous Delivery (CD):**
    * Triggers on pushes to the `release` branch.
    * Builds Docker images using `who_knows/.devops/docker-compose.prod.yml` and pushes them to the GitHub Container Registry.
3.  **Continuous Deployment (CD):**
    * Triggers after a successful Delivery workflow.
    * Connects via SSH to the production server.
    * Transfers environment configurations (`.env`) and Docker Compose files.
    * Pulls the new image from GHCR and restarts the services.
4.  **Release Workflow:**
    * Triggers when a Pull Request with the label `ready-for-release` is merged.
    * Automatically merges changes from `master` to `release` to trigger the CD pipeline.

---

## 🧪 Testing & Quality

* **Tests:** We use `test-unit` and `rack-test` for controller testing. Run them locally via:
    ```bash
    sh scripts/controller-test.sh
    ```
* **Linting:** We use **RuboCop** for static code analysis.
    ```bash
    sh scripts/rubocop-check.sh
    ```

## 📝 License

This project is created for educational purposes within the Martin's Angels organization.
