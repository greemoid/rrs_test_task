# Red Rocket Software Test Task
A simple Flutter application that loads a list of gadgets from the network and displays them in an interactive list.

# Demo
https://github.com/user-attachments/assets/f6bf7e2c-3f4a-47b7-945b-3b9a765d2b21

`Sorry for low FPS demo :(`


# Tech Stack
Key packages used in the project:

- `flutter_bloc` – state management using the BLoC pattern.

- `get_it` – service locator for easy dependency injection.

- `retrofit + dio` – HTTP client for network requests.

- `freezed + json_serializable` – for generating immutable data models and handling JSON serialization.

- `skeletonizer` – to show loading skeletons while waiting for data.

- `mocktail + http_mock_adapter` – for mocking dependencies and HTTP responses in unit tests.

- `bloc_test` – for testing BLoC states and events.
