# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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
