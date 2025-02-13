## Docker / .NET CI
An application development team has written some code in .NET and they need you
to write a Dockerfile to build a production-quality container image as well as a CI
pipeline to execute the build.
Don’t worry if you’re not familiar with .NET - the build process is very
straightforward and it’s fairly realistic to get asked CI questions about a language
you’re not an expert in!
You will need to install the .NET CLI (https://dotnet.microsoft.com/en-us/download)
onto your machine and run the following commands to set up a dummy project:
``` 
cd /wherever
dotnet new sln --name Interview
dotnet new console -o ConsoleApp
dotnet new nunit -o Tests
dotnet sln add ./Tests/Tests.csproj ./ConsoleApp/ConsoleApp.csproj
``` 
You should then be able to compile the dummy project via dotnet build and run it via
``` 
dotnet run --project ConsoleApp
``` 

Once you’ve got that working, write a Dockerfile that performs the following:
- Installs all the dependencies via dotnet restore.
- Runs the test project via dotnet test.
- Compiles the application and produces a production-quality binary via dotnet publish.
- Produces a runnable docker image at the end of the build that contains only the build artifacts required to run the  application (i.e. not the test files). This image should use an appropriate runtime image as a base (i.e. you don’t
need to include the .NET build tools).

You should research and decide on appropriate base image(s) to use in your Dockerfile.
When you have a working Dockerfile, create a simple CI pipeline to build the image, tag it with an appropriate tag, and push it to a container registry (don’t worry about getting an actual account on a registry to push your image to, including the command(s) you would run and leaving them commented out is fine). You can use any CI platform of your choice for this, however the pipeline MUST be
written in YAML.
Consider how you will store secrets like the credentials used to push the final image
to the registry
If you don’t have access to a CI platform to actually test the pipeline for any reason,
don’t worry, just write the YAML file as best you can and submit it. We won’t mark
you down for typos/syntax errors - we just want to see how you’d structure things.
