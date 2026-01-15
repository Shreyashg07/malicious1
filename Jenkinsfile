pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('PyGuard Scan') {
            steps {
                sh '''
                docker run --rm \
                  -v "$PWD:/scan" \
                  -w /scan \
                  python:3.9-slim \
                  bash -c "
                    pip install --no-cache-dir sentence-transformers torch numpy scikit-learn pyyaml &&
                    python ci-integrity/pyguard_embedding.py .
                  "
                '''
            }
        }

        stage('Build') {
            steps {
                echo "Build runs only if PyGuard passes"
            }
        }
    }

    post {
        failure {
            echo "Pipeline blocked by PyGuard"
        }
        success {
            echo "Pipeline passed PyGuard scan"
        }
    }
}
