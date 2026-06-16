# --- Etapa de construcción (Build) ---
FROM node:18-alpine AS build

WORKDIR /app

# Copiamos los archivos de configuración de paquetes
COPY package*.json ./

# Instalamos las dependencias del proyecto
RUN npm install

# Copiamos todo el código fuente
COPY . .

# Generamos la carpeta estática build
RUN npm run build

# --- Etapa de producción (Runtime) ---
FROM nginx:alpine

# Copiamos el resultado de la compilación al directorio que sirve Nginx
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]