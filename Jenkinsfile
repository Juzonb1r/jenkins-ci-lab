pipeline {
  agent none

  options {
    timestamps()
    disableConcurrentBuilds()
  }

  environment {
    REPO_URL = 'https://github.com/Juzonb1r/jenkins-ci-lab.git'
    BRANCH   = 'main'
    STASH    = 'src'
  }

  stages {

    stage('Checkout + Stash') {
      // делаем checkout на одном агенте и сохраняем код в stash
      agent any
      steps {
        checkout([$class: 'GitSCM',
          branches: [[name: "*/${env.BRANCH}"]],
          userRemoteConfigs: [[url: env.REPO_URL]]
        ])

        sh '''
          set -e
          echo "Make scripts executable"
          chmod +x app/app.sh tests/test.sh
          ls -la app tests
        '''

        // сохраняем ВСЁ (кроме .git обычно не надо)
        stash name: env.STASH, includes: '**/*', useDefaultExcludes: false
      }
      post {
        always { cleanWs() }
      }
    }

    stage('Build') {
      agent { label 'jim' }
      steps {
        deleteDir()          // чистим workspace на агенте
        unstash env.STASH    // забираем исходники

        sh '''
          set -e
          echo "Build stage on jim"
          chmod +x app/app.sh
          ./app/app.sh
        '''
      }
      post {
        always { cleanWs() }
      }
    }

    stage('Test') {
      agent { label 'node-mac1' }
      steps {
        deleteDir()
        unstash env.STASH

        sh '''
          set -e
          echo "Test stage on node-mac1"
          chmod +x tests/test.sh
          ./tests/test.sh
        '''
      }
      post {
        always { cleanWs() }
      }
    }
  }

  post {
    success { echo "Pipeline SUCCESS" }
    failure { echo "Pipeline FAILED" }
    always  { echo "Pipeline FINISHED" }
  }
}
