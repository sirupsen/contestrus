# Contestrus

Contestrus is a platform for hosting algorithmic competitions. It is planned to
feature:

* Different task styles. ACM ICPC (Accepted/Not accepted) ✓, IOI (Partial scores) ✓,
  Open/Hidden Input.
* Customized contest forms. Contestrus comes with built-in importers for a
  simple contest format, but it's easy to write importers from an existing
  format. ✓
* Simple, fast interface. A useful interface that helps the participants as much
  as possible.
* API. An API that lets users submit their programs via an API and view their
  status.
* Sandboxing. Sandboxing is provided by running each submission within its own
  Docker container. ✓
* Administration interface. An interface to monitor and edit contests. ✓
* Contest and training. Support both running contests but also an open
  environment to train on tasks of previous contests. ✓
* Support for teams.
* Announcements. Ability to push announcements to participants during a
  competition.

Many contest environments are complicated to set up. Contestrus is aiming to be
extremely simple to set up with Docker for ease of deployment.

Current status is that it definitely works and the core is pretty stable. It's
been used to host a few competitions at Shopify without problems.

## Deployment

Pull down the latest Contestrus Docker image:

```bash
docker pull Sirupsen/contestrus
```

Create and migrate the `sqlite` database:

```bash
docker run \
  --volume  /var/lib/contestrus:/db \
  --env     RAILS_ENV=production \
  Sirupsen/contestrus migrate
```

Run the Contestrus web server:

```bash
docker run \
  --volume  /var/log/contestrus:/app/log \
  --volume  /var/lib/contestrus:/db \
  --env     RAILS_ENV=production \
  --publish 4000:80 \
  Sirupsen/contestrus web
```

Run the Contestrus worker:

```bash
docker run \
  --volume  /var/log/contestrus:/app/log \
  --volume  /var/lib/contestrus:/db \
  --volume  /var/run/docker.sock:/var/run/docker.sock \
  --volume  /var/lib/docker:/var/lib/docker \
  --env     RAILS_ENV=production \
  Sirupsen/contestrus worker
```

Grab the sandboxing images (will eventually be just one):

```bash
docker pull bouk/gcc
docker pull bouk/coffee
docker pull bouk/golang
docker pull bouk/node
docker pull bouk/pypy
docker pull bouk/ruby
```

Import a competition (there's a sample in the root of the project):

```bash
docker run \
  --volume /home/me/competition:/competition \
  Sirupsen/contestrus import
```
