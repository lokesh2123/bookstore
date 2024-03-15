pipeline {
     agent any

   environment {
	dockerhub_pwd=credentials('b54bbd4f-3b39-436e-8463-f4c78287286f')
  }		
    stages{
        stage('Building the app using maven') {
            steps {
                sh '''
                echo building the maven application
                mvn clean install
                '''
            }
        }
        stage('Building the docker image') {
            steps {
                sh '''
                ls -lrth
                docker build . -t bookstore:${BUILD_NUMBER}
		        docker tag bookstore:${BUILD_NUMBER} lokesh2123/bookstore:${BUILD_NUMBER}
                '''
            }
        }
        stage('Push Docker Image'){
            steps{
               sh ''' 
               set -x
	           echo ${dockerhub_pwd} | docker login -u lokesh2123 --password-stdin
               docker push lokesh2123/bookstore:${BUILD_NUMBER}
               '''
            }
        }
        stage('Containerizing the app') {
            steps {
            sh '''
            echo Creating the image on top of tomcat
            APP_NAME=`ls -lrt target/ | awk '{print $9}' | grep ".war" | awk -F"-" '{print $1}'`
            docker build . -t $APP_NAME:${BUILD_NUMBER}
            '''
            }
        } 
	    stage('Deploy to docker') {
	       steps {
           sh '''
	       docker run -it -d -p 8085:8080 lokesh2123/bookstore:${BUILD_NUMBER}
	       '''
        }
    }
  }    	    
}
