FROM node:16.16-alpine3.16

# run as `nextjs`
RUN addgroup --system --gid 1001 nextjs
RUN adduser --system --uid 1001 nextjs
USER nextjs:nextjs

WORKDIR /app

# install dependencies (for cache)
COPY --chown=nextjs:nextjs package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# copy code
COPY --chown=nextjs:nextjs . .

# build
RUN yarn build

# environment
ENV NODE_ENV production
ENV NEXT_TELEMETRY_DISABLED 1
ENV PORT 3000

EXPOSE 3000

ENTRYPOINT ["yarn", "start"]
CMD []
