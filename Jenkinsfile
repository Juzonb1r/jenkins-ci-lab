pipeline {
  agent none

  options { timestamps(); disableConcurrentBuilds() }

  stages {
    stage('Checkout') {
      agent any
      steps {
        checkout([$class: 'GitSCM',
          branches: [[name: '*/main']],
          userRemoteConfigs: [[url: 'https://github.com/Juzonb1r/jenkins-ci-lab.git']]
        ])
      }
      post { always { cleanWs() } }
    }

    stage('Build on app') {
      agent { label 'jim' }
      steps { sh './app/app.sh' }
      post { always { cleanWs() } }
    }

    stage('Test on test') {
      agent { label 'node-mac1' }
      steps { sh './tests/test.sh' }
      post { always { cleanWs() } }
    }
  }

  post {
    success { echo "Pipeline SUCCESS" }
    failure { echo "Pipeline FAILED" }
  }
}
