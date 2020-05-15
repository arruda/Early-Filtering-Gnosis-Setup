# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.1.0] - 2020-05-15
### Fixed
- Forwarder now removes the image from the Redis cache once it is processed and dump out.
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


[unreleased]: https://github.com/olivierlacan/keep-a-changelog/compare/v1.0.0...HEAD
[1.0.0]: https://gitlab.insight-centre.org/SIT/mps/mps-node/-/tags/v1.0.0
[1.0.1]: https://gitlab.insight-centre.org/SIT/mps/mps-node/-/tags/v1.0.1
[1.0.2]: https://gitlab.insight-centre.org/SIT/mps/mps-node/-/tags/v1.0.2
[1.1.0]: https://gitlab.insight-centre.org/SIT/mps/mps-node/-/tags/v1.1.0
