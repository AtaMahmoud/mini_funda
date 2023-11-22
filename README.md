# mini_funda

Just a mini version of Funda's overview screen using Funda API

## Development
Mini Funda is built with `VS Code`, `Flutter 3.16.0` and `Dart 3.2.0`

The app follows `bloc` state management library which allows us to separate our application into three layers:

* Presentation which is the app UI [`house_overview.dart` & `house_details.dart`].
* Business Logic where all `Blocs` orchestrate the flow of data and UI interactions [`house_overview_bloc.dart` & `house_details_bloc.dart`].
* Data layer which includes the API client and repository [`funda_api_client.dart` & `funda_homes_repository.dart`].



## Getting Started

After cloning this repository, perform the following steps before building your project.

Add your API key to `launch.json`
```sh
 FUNDA_API_KEY=YOUR_API_KEY
```

Get third-party packages:

```sh
flutter pub get
```

to run the code generation if needed
```sh
 dart run build_runner build
```

to run all test files
```sh
flutter test
```
the app includes a mix of normal tests and widget tests.

## Demo
https://github.com/AtaMahmoud/mini_funda/assets/17383177/c8191f1b-2038-4964-b7a5-09bd3476ce4e

