# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.3.0] - 2020-06-05
### Fixed
- Tumbling Time window and Sliding Time window now works correctly.

### Added
- New Object Detection Service, for Tensorflow Object Detection model zoo. To use this on Gnosis node one needs to replace the object-detection configurations to use this service image and configurations instead, this service won't be used otherwise.
- Added operators for query matching: LEFT, RIGHT, FRONT and BACK.
    - Demo videos are available at: https://app.asana.com/0/691164837261656/1171330394984121/f

### Changed
- User Interface is now a one-stop service to access all Gnosis apps.
    - Current Apps:
        - Gnosis UI
        - Game Demo
        - Gnosis Documentation

### Benchmark
- Latency:
  - Average: 0.47882656250000005 seconds
  - Standard Deviation: 0.10317106821712423

## [1.2.0] - 2020-05-29
### Fixed
- Fixed link for the Unrelease section to point to link comparing the branch master with the previous version (this link needs to be updated on each release).
- User Interface no more breaks when streaming video to the remote Gnosis Node.

### Added
- Simple Adaptation Engine components added: Adaptation Knowledge, Adaptation Monitor, Adaptation Analyser, Adaptation Planner.
- Benchmark Plataform Controller allows for a broader range of configurations throught the HTTP API.
- Added a flag in the Forwarder to enabled annotation encoding only on request.

### Changed
- Scheduler and Event Dispatcher updated to work together in with new workflow: Publisher->Event Dispatcher->Scheduler->[Scheduler Plan...]->Window Manager.


### Known Issues
- Adaptation Planner has a mocked available services (and their respective streams key). In a future version this information should be retrived from the Adaptation Knowledge.

### Benchmark
- Latency:
  - Average: 0.5297053541666666 seconds
  - Standard Deviation: 0.14538887928179497

## [1.1.1] - 2020-05-22
### Fixed
- User Interface now supports high-resolution videos via File Upload. It can also run pre-uploaded videos.
- Graph output for User Interface is back.
- Better Garbage collection: Forwarder now discards plot object created for each frame going outward.
- Thoroughly tested Tumbling Count Window, Tumbling Time Window and Sliding Count Window.

### Known Issues
- Sliding Time Window is currently not working.

### Benchmark
- Latency:
  - Average: 1.571153717099567 seconds
  - Standard Deviation: 0.6757218691234075

## [1.1.0] - 2020-05-15
### Fixed
- Forwarder now removes the image from the Redis cache after it has been processed and dumped.
- Webcam now works when accessing User Interface via a remote client.
- Gitlab CI no more execute build task for tag changes.
- Better Exception handling in UI Node.js server.

### Added
- Gnosis has an updated User Interface v2.
    - Query Editor now supports templates. One each for Object Detection, VidCEP and Publish/subscribe.
    - Output displays result in three forms: Image, Graph and Tabular.
    - Status bar and top information bar updated with new information.
    - Colour Scheme refreshed (as per NUIG standards).
- Benchmark Platform Controller now uses PostgreSQL docker container as a DB.
- Gnosis version change script updated.
- User Interface now asks for Gnosis node hostname to connect.

### Known Issues
- Gnosis User Interface,
    - Graph output is currently disabled. It will behave similarly to the image output.

### Benchmark
- Latency:
  - Average: 0.977043112908497 seconds
  - Standard Deviation: 0.209773583007953

## [1.0.2] - 2020-04-16
### Fixed
- Pre-processor no longer throws an exception if the media stream is not available when receiving subscriptions.
- Fix added to execute case insensitive processing of query constraints.

### Benchmark
- Latency:
  - Average: 1.6329716175757576 seconds
  - Standard Deviation: 0.6492308611670065


## [1.0.1] - 2020-04-09
### Added
- Script for tagging versions (Docker and Git) for MPS node.
- Project Website template.
- Documentation ready and revised, but offline for now.

### Fixed
- Client Manager no longer throws an exception if the publisher mentioned in the subscription is not registered yet.

### Benchmark
- Latency:
  - Average: 2.844587017941611 seconds
  - Standard Deviation: 2.9624411250563405


## [1.0.0] - 2020-04-07
### Added
- Added semantic versioning for MPS node
- Added Changelog
- First release, with the available services:
  - client-manager
  - window-manager
  - query-manager
  - object-detection
  - publisher
  - namespace-mapper
  - query-planner
  - event-dispatcher
  - preprocessor
  - matcher
  - forwarder
  - color-detection

- Third party dependency services:
  - redis
  - jaeger

Not much more detail (too many things to just put in here), on future releases we will have a better and detailed changelog.

<!--
### Changed
- Just an example of how to use changelog.

### Fixed
- Just an example of how to use changelog.

### Removed
- Just an example of how to use changelog.

### Deprecated
- Just an example of how to use changelog. -->


[unreleased]: https://gitlab.insight-centre.org/SIT/mps/mps-node/compare/v1.3.0...master
[1.0.0]: https://gitlab.insight-centre.org/SIT/mps/mps-node/-/tags/v1.0.0
[1.0.1]: https://gitlab.insight-centre.org/SIT/mps/mps-node/-/tags/v1.0.1
[1.0.2]: https://gitlab.insight-centre.org/SIT/mps/mps-node/-/tags/v1.0.2
[1.1.0]: https://gitlab.insight-centre.org/SIT/mps/mps-node/-/tags/v1.1.0
[1.1.1]: https://gitlab.insight-centre.org/SIT/mps/mps-node/-/tags/v1.1.1
[1.2.0]: https://gitlab.insight-centre.org/SIT/mps/mps-node/-/tags/v1.2.0
[1.3.0]: https://gitlab.insight-centre.org/SIT/mps/mps-node/-/tags/v1.3.0
