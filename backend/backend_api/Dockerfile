FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["./backend_api.csproj", "src/"]
RUN dotnet restore "src/backend_api.csproj"
COPY . .
WORKDIR "/src/"
RUN dotnet build "backend_api.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "backend_api.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
#ENTRYPOINT ["dotnet", "backend_api.dll"]
CMD ASPNETCORE_URLS=http://*:$PORT dotnet backend_api.dll
