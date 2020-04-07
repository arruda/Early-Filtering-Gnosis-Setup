# MPS Node
Node for executing the MPS in a single machine (inside containers).

# Docker Registry Access
Before using the project one needs to login on our internal docker registry.
This only needs to be done once ever.

To do so, one need to execute the following command, and login with theirs GITLAB user and password when asked:
```shell
docker login registry.insight-centre.org
```

# Configure .env
Copy the `example.env` file to `.env`, and inside it replace `SIT_PYPI_USER` and `SIT_PYPI_PASS` with the correct information.

## Using a specific a MPS version
Replace the `IMAGE_TAG=latest` variable with version you want to use, eg: `IMAGE_TAG=v1.0.0`


# Running
Load the environment variables from .env in the environment, one way of doing this is using `source load_env.sh` command.

Then run: `docker-compose up -d` and wait until all services have started.

# Stopping

Execute: `docker-compose down` to stop all the containers.

Execute: `docker-compose stop <service-name>` to stop a specific container.

# Logs

Use `docker-compose logs -f <service-name>`.

# Using Media Server
If one wants to use a media server to test the system, just use the script: `compose-media.sh` instead of the command `docker-compose`. eg:

```shell
./compose-media.sh up -d`
```

# Testing Simple Query
Using the current Query Manager it is possible to start the system with a very simple query.
*(This requires the use of the media server)*.

To do so just run:

```shell
./compose-media.sh up -d
```
This will start all the services including the media-server. Then run:

```shell
./compose-media.sh run --rm query-manager /bin/bash -c "cd query_manager && python send_veql_query.py"
```
This should send some queries that will start the system.

## Event traces
To verify the events that went through the system one just need to acess the Jaeger port: http://localhost:16686

On this system is possible to use the search mechanism to get insights on what is occurred on the system execution.


# Overriding Service Configurations for Development
If one wishes to override certain configurations in the docker-compose.yml files, instead of applying the changes there one, the best way is to create a file (if it does not exist yet) called docker `docker-compose.override.yml`.

This file is ignored by the version control (git) and will not be commited, so one can change whatever it is necessary to run specific simple development tests without worring that the changes will be inadvertently commited.

An example of how this can be done can be seen in the contents of the file `example-docker-compose.override.yml`.
More information on this can be read on the [docker-compose docs](https://docs.docker.com/compose/extends/#understanding-multiple-compose-files)

***ps**: when using `compose-media.sh` or `compose-all.sh` it will automatically create an empty but valid `docker-compose.override.yml` file if it does not exist yet.*



# Generating new MPS version

To create the tags for all services containers and git repositories, follow the next steps:

## Python env
Be sure to setup the local python env for development:
```
pipenv install -d
```
Replace `SIT_TOKEN` on the `.env` file with the correct value (use our CI user access token).


And enter the python virtualenv:
```
pipenv shell
```


## Prepare Changelog

Add the information to the new version right after the `[Unreleased]` section in the document.
More information on how to write a good Change log is available at the start of the file in a link to the format used as a reference.
**ps:** remember to add the link to the new version in the end of the file, just like the previous versions are doing.

Next commit this change.

## Bumpversion and Create Tags
Make sure no service is missing from the `SERVICE_PROJECT_LIST` variable in the `bumpversion.sh` file.

Before the next step, make sure you dont have any uncommited changes. Then run:
```
./bumpversion.sh <major|minor|patch>
```
Choose major, minor or patch version depending on what is inside this version. This follows the [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

This will start a process of bumping the current version to the new one, and generating the docker image tags as well as the git repository tags for each project, and finally for MPS node itself.