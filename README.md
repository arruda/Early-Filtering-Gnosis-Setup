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