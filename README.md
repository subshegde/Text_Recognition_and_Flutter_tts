# Text Recognition App with Flutter

This Flutter app uses **Google ML Kit** for text recognition, **Flutter TTS** for reading the recognized text aloud, and **Image Picker** to select images from the gallery.

## Features

- 📸 **Pick an image** from the gallery using the **Image Picker** package.
- 🔍 **Recognize text** from the image using **Google ML Kit**'s text recognition capabilities.
- 🎤 **Text-to-Speech** (TTS) integration with **Flutter TTS** to read aloud the recognized text.
- 🌍 Support for **multiple languages** for text-to-speech.

## Technologies Used

- **Flutter** - The framework used to build the app.
- **google_ml_kit** - A package to integrate Google's ML Kit for text recognition.
- **flutter_tts** - A package to enable Text-to-Speech functionality.
- **image_picker** - A package to allow image selection from the gallery.

## Installation

To run this project locally:

1. Clone this repository:
    git clone https://github.com/subshegde/Text_Recognition_and_Flutter_tts.git

2. Navigate into the project directory:
    cd extract_text_from_image>

3. Install the dependencies:
    flutter pub get

4. Run the app:
    flutter run

## How to Use

1. Open the app on your Android/iOS device.
2. Tap the **Pick** button to select an image from your gallery.
3. The app will recognize the text from the image.
4. Once the text is recognized, it will be displayed on the screen.
5. Tap the **Speaker Icon** to have the text read aloud in the selected language.

## Supported Languages

- English (US)
- English (UK)
- Spanish
- French
- German
- Italian
- Portuguese (Brazil)
- Hindi
- Arabic
- Chinese (Mandarin)
- Japanese
- Korean
- Russian
- Kannada

## Packages Used

- **google_ml_kit: ^0.19.0** - For text recognition from images.
- **image_picker: ^1.1.2** - For selecting images from the gallery.
- **flutter_tts: ^4.0.2** - For text-to-speech functionality.

## Acknowledgements

- Google ML Kit for text recognition.
- Flutter TTS for speech synthesis.
- Image Picker for image selection.

# Happy Coding
