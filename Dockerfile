
#  Adding the .NET image mcr.microsoft.com/dotnet/sdk:8.0 which is the latest version with full support, can be found here https://learn.microsoft.com/en-us/dotnet/architecture/microservices/net-core-net-framework-containers/official-net-docker-images
# Specifying the base image
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src

# Copy everything
COPY . ./

# Restore as distinct layers
RUN dotnet restore

# Running tests
RUN dotnet test

# Build and publish a release
RUN dotnet publish -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "ConsoleApp.dll"]

