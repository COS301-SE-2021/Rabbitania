FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["NotificationService_api/NotificationService_api.csproj", "NotificationService_api/"]
RUN dotnet restore "NotificationService_api/NotificationService_api.csproj"
COPY . .
WORKDIR "/src/NotificationService_api"
RUN dotnet build "NotificationService_api.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "NotificationService_api.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "NotificationService_api.dll"]
