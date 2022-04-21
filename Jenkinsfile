pipeline{

  agent {label 'master'}
  
  triggers {
    pollSCM('*/2 * * * *')
  }

  stages {
      
    stage('gitclone') {
      steps {
        git branch: '3.2',
          url: 'https://github.com/mach1el/docker-opensips-cp.git'
      }
    }

    stage('Build') {

      steps {
        sh 'docker build -t mich43l/opensips-cp:3.2 .'
      }
    }

    stage('Login') {
      steps {
        withCredentials([
          usernamePassword(
            credentialsId: 'dockerhub', 
            usernameVariable: 'USER', 
            passwordVariable: 'PASS'
            )]) {
          sh '''
          docker login -u ${USER} -p ${PASS}
          '''
        }
      }
    }

    stage('Push') {

      steps {
        sh 'docker push mich43l/opensips-cp:3.2'
      }
    }

    stage('Clean') {

      steps {
        sh 'docker rmi mich43l/opensips-cp:3.2'
      }
    }
  }

  post {
    always {
      sh 'docker logout'
    }
  }

}