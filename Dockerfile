
#  Adding the .NET image mcr.microsoft.com/dotnet/sdk:8.0 which is the latest version with full support, can be found here https://learn.microsoft.com/en-us/dotnet/architecture/microservices/net-core-net-framework-containers/official-net-docker-images
# Specifying the base image
# update: updated the docker image. did some research and found that for a lighter version we can use the alpine images
# which will make it a lighter image
FROM mcr.microsoft.com/dotnet/sdk:8.0-alpine AS build

WORKDIR /src

# Copy everything
COPY . ./

# Restore as distinct layers
RUN dotnet restore

# Running tests
RUN dotnet test

# Build and publish a release
RUN dotnet publish --configuration Release -o /app/publish

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "ConsoleApp.dll"]

