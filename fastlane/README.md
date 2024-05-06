fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios test

```sh
[bundle exec] fastlane ios test
```

Runs all the tests

### ios distribute_testflight

```sh
[bundle exec] fastlane ios distribute_testflight
```

Build and deploy a new build to Testflight

### ios app_store

```sh
[bundle exec] fastlane ios app_store
```

Submit the app to App Store

### ios renew_development_certs

```sh
[bundle exec] fastlane ios renew_development_certs
```

Renew development certificates

### ios renew_appstore_certs

```sh
[bundle exec] fastlane ios renew_appstore_certs
```

Renew distribution certificates

### ios register_test_devices

```sh
[bundle exec] fastlane ios register_test_devices
```

Add new test devices from text file

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
