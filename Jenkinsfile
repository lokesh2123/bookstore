pipeline {
     agent any

   environment {
	dockerhub_pwd=credentials('e46de8fc-f720-401a-ab10-a42497edd7ef')
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
	    stage('Deploy to EKS Kubernetes cluster') {
	       steps {
           withAWS(credentials: 'aws-eks', region: 'ap-south-1')
           sh '''
	       #kubectl apply -f deployment.yaml
	       kubectl create deployment onlinebookstore --image onlinebookstore:${BUILD_NUMBER}
	       '''
        }
    }
  }    	    
}
