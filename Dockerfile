stage('PyGuard Scan') {
    steps {
        sh '''
        docker run --rm \
          -v "$PWD:/scan" \
          -w /scan \
          python:3.9-slim \
          bash -c "
            pip install sentence-transformers torch numpy scikit-learn pyyaml &&
            python backend/ci-integrity/pyguard_embedding.py .
          "
        '''
    }
}

