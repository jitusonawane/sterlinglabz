# Static site served by nginx, sized for Cloud Run
FROM nginx:1.27-alpine

# Cloud Run injects PORT at runtime; nginx.conf is generated from the
# template below at container start so it listens on the right port.
ENV PORT=8080

COPY nginx.conf.template /etc/nginx/templates/default.conf.template
COPY index.html /usr/share/nginx/html/index.html
COPY assets/ /usr/share/nginx/html/assets/

EXPOSE 8080

# The official nginx image auto-runs docker-entrypoint.d scripts, which
# render any /etc/nginx/templates/*.template with envsubst before nginx starts.
CMD ["nginx", "-g", "daemon off;"]
