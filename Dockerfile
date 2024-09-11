FROM directus/directus:11.x.y

USER root
RUN corepack enable
USER node

# install extensions if needed
#RUN pnpm install directus-extension-package-name