FROM google/dart:2.2 AS builder
ENV PATH="${PATH}:/root/.pub-cache/bin"
WORKDIR /root/build-here
RUN pub global activate webdev
COPY /frontend/pubspec.yaml /root/build-here/
RUN pub get
COPY /frontend /root/build-here/
RUN pub get
RUN pub get && webdev build --output web:build
FROM nginx
EXPOSE 80
RUN sed -i -e 's,   location / {,   location /calendar {,g' /etc/nginx/conf.d/default.conf; \
sed -i -e 's,        root   /usr/share/nginx/html;,        alias   /usr/share/nginx/html;,g' /etc/nginx/conf.d/default.conf
COPY --from=builder /root/build-here/build /usr/share/nginx/html


