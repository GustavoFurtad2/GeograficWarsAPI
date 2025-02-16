FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src

COPY GeograficWarsAPI.csproj ./
RUN dotnet restore GeograficWarsAPI.csproj

COPY . ./
RUN dotnet build GeograficWarsAPI.csproj -c Release -o /app/build

RUN dotnet publish GeograficWarsAPI.csproj -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base

WORKDIR /app

COPY --from=build /app/publish .

EXPOSE 80

ENTRYPOINT ["dotnet", "GeograficWarsAPI.dll"]
