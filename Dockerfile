# <DOCKER_FROM>  # Warning: text inside the DOCKER_FROM tags is auto-generated. Manual changes will be overwritten.
FROM aldryn/base-project:3.18
# </DOCKER_FROM>

# <DOCKER_BUILD>  # Warning: text inside the DOCKER_BUILD tags is auto-generated. Manual changes will be overwritten.

# node modules
# ------------
# package.json is put into / so that mounting /app for local
# development does not require re-running npm install
ENV PATH=/node_modules/.bin:$PATH
RUN npm install -g npm-install-retry
COPY package.json /
RUN (cd / && npm-install-retry -- --production && rm -rf /tmp/*)

# bower requirements
# ------------------
COPY bower.json /app/
COPY .bowerrc /app/
RUN bower install \
    --verbose \
    --allow-root \
    --config.interactive=false

# python requirements
# -------------------
ENV PIP_INDEX_URL=${PIP_INDEX_URL:-https://wheels.aldryn.net/v1/aldryn-extras+pypi/aldryn-baseproject/+simple/} \
    WHEELSPROXY_URL=${WHEELSPROXY_URL:-https://wheels.aldryn.net/v1/aldryn-extras+pypi/aldryn-baseproject/}
COPY requirements.* /app/
COPY addons-dev /app/addons-dev/
RUN pip-reqs compile && \
    pip-reqs resolve && \
    pip install \
        --no-index --no-deps \
        --requirement requirements.urls

# add full sourcecode
# -------------------
COPY . /app

# static compilation with gulp (e.g sass)
# ---------------------------------------
ENV GULP_MODE=production
RUN gulp build; exit 0

# collectstatic
# -------------
RUN DJANGO_MODE=build python manage.py collectstatic --noinput

# </DOCKER_BUILD>

# minify collected javascript files
# ---------------------------------
RUN python tools/minify.py
