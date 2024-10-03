# Gnosis Early Filtering E2E setup
Fork of the [Gnosis Node](https://github.com/Gnosis-MEP/Gnosis-Node), with specific configurations for easy to run and reproduce the experiments on the end-to-end Early Filtering pipeline. The idea is to run this readly configured Gnosis node on the Server. On the Raspberry Pi one should instead download/gitclone the [Adaptive Publisher](https://github.com/Gnosis-MEP/Adaptive-Publisher). See the experiment protocol section on for the detailed steps on running the E2E, including information on how to setup and run the AdaptivePublisher part.


# Requirements
Docker, Docker-compose, and nvidia-docker runtime configured (for the Cloudseg model that runs on the GPU).

**PS**: Newer versions of docker already come shipped with docker-compose, but the command is different. **If using the newer docker version use the shell scripts starting with** `new-` (e.g., `new-compose-all-gnosis.sh`) instead of the ones described in the following sections. On the other repositories (Adaptive Publisher and Benchmark-Tools) the just replace the command instructions from using `docker-compose` to `docker compose` (without the dash).

# Configure .env
Copy the `example.env` file to `.env`. No need to change any configuration, since all configurations are already setup for the E2E experiments.

# Experiment Protocol
## Basic Setup:

- Connect the Raspberry Pi (Edge) to the Server by the network router.
- On the Server:
    - Clone this repository into a local directory and copy the `example.env` file into a new file called `.env`.
    - Check and take note of the Server IP address in the network (e.g., 192.168.0.1)
    - Clone the benchmark-tools repository into a local directory.
- On the Edge:
    - clone the repositoy from the [Adaptive Publisher](https://github.com/Gnosis-MEP/Adaptive-Publisher) to a directory (e.g., `/home/pi/AdaptivePublisher/`)
    - go to the cloned repository, and download into the `data/` directory the models [HS-D-B-1-10S](https://github.com/Gnosis-MEP/Adaptive-Publisher/releases/download/models_weights/HS-D-B-1-10S_-300_car_person-bird-dog.pth) and [TS-D-Q-1-10S](https://github.com/Gnosis-MEP/Adaptive-Publisher/releases/download/models_weights/TS-D-Q-1-10S_-300_car_person-bird-dog.pth). These are the classifier models for the Houston1 and Jackson1 sub-datasets
    - also download the video files for the [Houston1](https://github.com/arruda/Early-Filtering-Gnosis-Setup/releases/download/e2e_exp/HS-D-B-1.mp4) and [Jackson1](https://github.com/arruda/Early-Filtering-Gnosis-Setup/releases/download/e2e_exp/TS-D-Q-1.mp4) sub-datasets  (again inside the  `data/` directory).
    - Download the .env configuration files for each setup: [Houston1_cloudseg.env](https://github.com/arruda/Early-Filtering-Gnosis-Setup/releases/download/e2e_exp/Houston1_cloudseg.env), [Houston1_gnosis.env](https://github.com/arruda/Early-Filtering-Gnosis-Setup/releases/download/e2e_exp/Houston1_gnosis.env), [Jackson1_cloudseg.env](https://github.com/arruda/Early-Filtering-Gnosis-Setup/releases/download/e2e_exp/Jackson1_cloudseg.env), [Jackson1_gnosis.env](https://github.com/arruda/Early-Filtering-Gnosis-Setup/releases/download/e2e_exp/Jackson1_gnosis.env)
    - On each of the downloaded .env files replace the values for  `REDIS_ADDRESS` and `TRACER_REPORTING_HOST` (these variables are right at the top) with the your Server IP addrees. Eg: `REDIS_ADDRESS=192.168.0.1`

## Executing a experiment:

**PS**: Before executing the experiment for real, you should first do a hot-start on both the Server and the Edge. For that you can follow these same steps, but you don't need to run any of the Benchmark-tools commands, and you after running everything for a few minutes, you can stop and cleanup everything before starting things for real. To really start the experiment, remember to do all the steps in here from the start without skipping any.

- On the Server:
    - On this clonned repository location, execute the "`./compose-all-<method>.sh up -d`" where <method> is either `gnosis` or `cloudseg`. (use "`./new-compose-all-<method>.sh up -d`" if using new docker version.)
    - On the Benchmark-tools clonned repository location, start listening/saving the end-user query results by its registered query name. For the Jackson1 dataset, the query is called `AnyCars` for the Houston1 it is called `CountCars`. The example bellow is the code to save the results of the `AnyCars` query.
        - `docker-compose run --rm benchmark-tools python ./benchmark_tools/task_generator/task_export_stream_content.py AnyCars`
        - This command will keep running on that terminal until you stop it, it will also notify you of the name of the JSON lines file that it is saving the contents to (e.g., `outputs/export_50809f300b8e646a3e7735569a0da37f.jl`).
- On the Edge:
    - Copy the example env file for the subdataset (Houston1 or Jackson1) and method in question ("gnosis" or "cloudseg"), into a new file called `.env`. Example: copy `Jackson1_gnosis.env` into a new file called `.env` if you are evaluating the gnosis early filtering method on the Jackson1 subdataset. Makle sure to use the same method as the one used in the Server. If the `.env` file already exist, just replace it with the new one you wish to use.
    - Start the Edge components by running `docker-compose up service`

- On the Server:
    - Go to the Gnosis Access Point Web Interface: [http://localhost:8000/](http://localhost:8000/), and click to [Add Subscription Query] button.
    - On the New Query page replace the query text with the specific    Query for each method and dataset being used:
        - Jackson1 car detection query using Gnosis Early Filtering:
            ```
            REGISTER QUERY AnyCars
            OUTPUT AnnotatedVideoStream
            CONTENT ObjectDetection
            MATCH (c:car)
            FROM publisher1 WITHIN TUMBLING_COUNT_WINDOW(1)
            WITH_QOS
            accuracy = 'medium_importance',
            latency = 'medium_importance',
            energy_consumption = 'medium_importance'
            RETURN c
            ```
        - Jackson1 car detection query using CloudSeg:
            ```
            REGISTER QUERY AnyCars
            OUTPUT AnnotatedVideoStream
            CONTENT ImageResizer, ObjectDetection
            MATCH (c:car)
            FROM publisher1 WITHIN TUMBLING_COUNT_WINDOW(1)
            WITH_QOS
            accuracy = 'medium_importance',
            latency = 'medium_importance',
            energy_consumption = 'medium_importance'
            RETURN c
            ```
        - Houston1 car counting query using Gnosis Early Filtering:
            ```
            REGISTER QUERY CountCars
            OUTPUT AnnotatedVideoStream
            CONTENT ObjectDetection
            MATCH (c:car)
            FROM publisher1 WITHIN TUMBLING_COUNT_WINDOW(1)
            WITH_QOS
            accuracy = 'medium_importance',
            latency = 'medium_importance',
            energy_consumption = 'medium_importance'
            RETURN count(distinct c) as CarCount
            ```
        - Houston1 car counting query using CloudSeg:
            ```
            REGISTER QUERY CountCars
            OUTPUT AnnotatedVideoStream
            CONTENT ImageResizer, ObjectDetection
            MATCH (c:car)
            FROM publisher1 WITHIN TUMBLING_COUNT_WINDOW(1)
            WITH_QOS
            accuracy = 'medium_importance',
            latency = 'medium_importance',
            energy_consumption = 'medium_importance'
            RETURN count(distinct c) as CarCount
            ```

    - Then click on Add Query, and it should show a Pop-Up saying that the Query was registered, and redirect to the end-user query viewing page and should trigger the Edge publisher to start its processing.
    - You can close this query page now.

- On The Edge:
    - Once all frames are published, you can stop the container (CTRL+C). (It should stop by itself once all frames are processed)

## Saving Results:
- On the Server:
    - You can check if the server has finished all its processing by opening the Jaeger web interface, and checking the event traces for the AdaptivePublisher to see if the last events have already been processed: [Local Jaeger EventTrace Search](http://localhost:16686/search?limit=20&lookback=1h&maxDuration&minDuration&service=AdaptivePublisher)
    - On the benchmark-tools directory:
        - Once the Server as finished processing all frames (this can take a while, up to 30 mins when using the CloudSeg), you can stop the end-user query saving/listening on the Benchmark-tools by pressing CTRL+C. The output .jl file should contain all the results received by the end-user.
        - Now run the following comands to export the rest of the experiment data:
            - `docker-compose run --rm benchmark-tools python ./benchmark_tools/task_generator/task_export_jaeger_json.py`
            - `docker-compose run --rm benchmark-tools python ./benchmark_tools/evaluation/per_service_speed_evaluation.py > outputs/per_service_speed.json`
    - This will leave you with the following files on the `outputs/` directory of the benchmark-tools:
        - `AdaptivePublisher-process_next_frame.json`: Jaeger exported Event traces file.
        - `per_service_speed.json`: Detailed processing speed of each service and its operations, average values end with `_avg` and the standard deviation ends with `_std`.
        - `<query_id>.jl`: the JSON lines file with the exported results of the end-user query.

## Stopping/Cleanup:
- On the Edge:
    - Stop the adaptive publisher container if you didn't stop it already (CTRL+C).
    - Then run `docker-compose down` to clean up the docker containers.
- On the Server:
    - Back in this clonned repository location, run the same script you use to start the Server components, but with the `down` argument, eg: `./compose-all-<method>.sh down` (where method is either `gnosis` or `cloudseg`).


# Logs
Using the compose-all script of the version you are running, you can pass the following argument to check the logs of a specific service: `logs -f <service-name>`.

# Event traces
To verify the events that went through the system one just need to acess the Jaeger port: http://localhost:16686

On this system is possible to use the search mechanism to get insights on what is occurred on the system execution.

## Importing Experiment Traces
It is also possible to run the Jaeger and import the traces available from the experiments used in the journal.
This option is available on the Search page, on the Tab [Json File].

**The JSON Traces files are very large, and it is advised to break them into smaller JSON files if visualising this way, since it loads everything in memory in the browser, and may crash your browser.**


# License
Copyright 2024 University of Galway

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.