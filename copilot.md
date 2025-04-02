#create a very basic flask app for 'hello world':
1) take cardif-poc as variable and insert in each name of resources invoked with this variable.
2) create the terraform file to create a resource group called ${cardif-poc}-RG, the app service called ${cardif-poc}-app, in region us-south-central, SKU basic in Azure.
3) create the dockerfile to contenerize this application.
4) create the path and github action file to run the terraform commands, docker commands, and deploy commands.