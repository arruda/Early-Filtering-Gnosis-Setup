# MPS Node
Node for executing the MPS in a single machine (inside containers).


# Running
Load the environment variables from .env in the environment, one way of doing this is using `source load_env.sh` command.

Then run: `docker-compose up -d` and wait until all services have started.

# Stopping

Execute: `docker-compose down` to stop all the containers.

Execute: `docker-compose stop <service-name>` to stop a specific container.


# Logs

Use `docker-compose logs -f <service-name>`.