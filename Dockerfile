# Sử dụng hình ảnh cơ bản từ Microsoft
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app

# Sử dụng SDK để build
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# Copy toàn bộ mã nguồn vào container
COPY . .

# Restore các dependency
RUN dotnet restore

# Build project
RUN dotnet publish -c Release -o /app

# Chạy ứng dụng
FROM base AS final
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet", "RemoteDesktop.dll"]
