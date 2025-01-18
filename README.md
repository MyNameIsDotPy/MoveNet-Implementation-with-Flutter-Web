# TensorFlow.js with Flutter Web

This project demonstrates the integration of [TensorFlow.js](https://www.tensorflow.org/js) with a Flutter Web application, using the MoveNet SinglePose Thunder model for real-time pose detection directly in the browser.

## Features

- *Real-time pose detection*: Leverages MoveNet SinglePose Thunder for accurate pose estimation in the web browser.
- *Cross-platform compatibility*: Combines TensorFlow.js for browser-based ML and Flutter Web for a responsive UI.
- *No external model loading*: Uses a pre-integrated MoveNet SinglePose Thunder model.

## Prerequisites

To get started, ensure you have the following installed:

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- A modern web browser

## Getting Started

### Step 1: Clone the Repository
bash
git clone https://github.com/MyNameIsDotPy/MoveNet-Implementation-with-Flutter-Web.git
cd <repository-directory>


### Step 2: Install Dependencies

Install Flutter dependencies:
bash
flutter pub get


### Step 3: Run the Application

Serve the Flutter Web app:
bash
flutter run -d chrome

### Step 4: Load the model
Click the floating action button start and wait a few seconds

### Step 5: Test Pose Detection
Ensure the MoveNet SinglePose Thunder functionality is working by interacting with the real-time pose detection feature.

## Usage

1. *Pose Detection*: Ensure the camera permission is granted, and the MoveNet model will automatically start detecting poses in real time.
2. *UI Integration*: View detected poses displayed dynamically in the Flutter Web UI.


## Contributing

Contributions are welcome! Please open an issue or submit a pull request for improvements or bug fixes.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Acknowledgments

- [TensorFlow.js Documentation](https://www.tensorflow.org/js)
- [Flutter Web Documentation](https://docs.flutter.dev/platform-integration/web)

---

Feel free to reach out for any questions or support regarding this project!