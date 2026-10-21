# App Privacy Policy Generator — static site served by nginx.
# Upstream commits pre-built HTML/CSS into public/ (see Makefile `build`),
# so the image only needs to copy that directory.
FROM nginx:1.27-alpine

RUN rm -rf /usr/share/nginx/html/*
COPY public/ /usr/share/nginx/html/

# SPA-ish static site: fall back to 404.html for unknown paths.
RUN printf 'server {\n\
  listen 8080;\n\
  root /usr/share/nginx/html;\n\
  index index.html;\n\
  location / { try_files $uri $uri/ $uri.html =404; }\n\
  error_page 404 /404.html;\n\
  location = /healthz { access_log off; return 200 "ok\\n"; }\n\
}\n' > /etc/nginx/conf.d/default.conf

EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD wget -q -O /dev/null http://127.0.0.1:8080/healthz || exit 1

CMD ["nginx", "-g", "daemon off;"]
