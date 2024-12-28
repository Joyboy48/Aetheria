# ai_integration

A new Flutter project.

This app is an AI-powered chat application built using Flutter and the BLoC pattern. It allows users to interact with an AI model to generate text and image responses based on user input. The app includes the following features:

- **User Input Handling**: Users can input text messages which are processed by the AI model.
- **AI Text Generation**: The app uses an AI model to generate text responses based on the user's input.
- **AI Image Generation**: The app uses an AI model to generate image responses based on the user's input.
- **State Management**: The app uses the BLoC pattern for efficient state management, ensuring a responsive and smooth user experience.
- **Network Permissions**: The app includes necessary network permissions to enable communication with the AI model.

### Features

1. **User Input Handling**:
   - Users can input text messages which are processed by the AI model.
   - The input messages are managed by the `ChatBloc` class, which handles the events and states related to chat messages.

2. **AI Text Generation**:
   - The app uses an AI model to generate text responses based on the user's input.
   - The `Chatrepo.chatTextGenerationRepo` method is used to generate the AI text responses.

3. **AI Image Generation**:
   - The app uses an AI model to generate image responses based on the user's input.
   - The `Chatrepo.chatImageGenerationRepo` method is used to generate the AI image responses.

4. **State Management**:
   - The app uses the BLoC pattern for efficient state management.
   - The `ChatBloc` class extends `Bloc` and manages the states and events for the chat functionality.
   - The `ChatSucessState` class holds the list of chat messages.

5. **Network Permissions**:
   - The app includes necessary network permissions in the `AndroidManifest.xml` file to enable communication with the AI model.

### Technologies Used

- **Dart**: Programming language for Flutter.
- **Flutter**: Framework for building the UI.
- **BLoC**: State management pattern.
- **Kotlin, Java, C++**: Additional languages used in the project.
- **Gradle**: Build automation tool.
- **Pub**: Package manager for Dart.
