# daily_news_articles

A new Flutter project.
# News Daily App

Welcome to News Daily App! This Flutter project aims to provide users with the latest news articles from various sources. Here's a brief overview of what this app offers and how to get started:

## Overview

The app fetches news articles using a custom API, as the original API we planned to use has reached its daily limit. We have implemented our own news API with the following parameters:

- Base URL: `https://newsapi.org/v2/everything`
- Query: `q=tesla`
- Additional Parameters: 
  - Date Range: From 2024-03-28
  - Sort By: Published At
  - Language: English
  - API Key: Provided in the code (`b06a21d89a0041a3b18845f0fa7c41a3`)
  - Page Size: Dynamically set

## Getting Started

To get started with the News Daily App, follow these steps:

1. Clone this repository to your local machine.
2. Open the project in your preferred Flutter development environment (e.g., Android Studio, VS Code).
3. Ensure you have Flutter and Dart installed on your system.
4. Run `flutter pub get` to install all dependencies.
5. Run the app on a simulator or physical device using `flutter run`.

## Features

- **Article Controller**: Manages communication between the model and UI. It adds data into the article list, which is displayed with the help of the Gex Controller.
- **Pagination Logic**: Utilizes a ScrollController to fetch additional data when the user scrolls to the end of the list.
- **FavList Management**: Temporarily stores selected favorite items in a list. In a real scenario, favorites would be stored in local storage or a database.
- **Tab Controller**: Allows users to switch between viewing news articles and their favorite articles.
- **Custom Widgets**: Various custom widgets have been implemented to maintain clean code and adhere to a structured design.
- **Error Handling**: If a URL is not provided by the news API, a placeholder image is displayed instead of the missing image.

## Credits

The development of this app was inspired by various online resources, including blog posts and Stack Overflow answers. Special thanks to the Flutter community for their support and guidance throughout the development process.

---
## Accessing the Master Branch

To access the main codebase located in the master branch, click [here](https://github.com/harshgmx47/Daily-News-Articles/tree/master).

Feel free to explore the codebase and contribute to the News Daily App project! If you encounter any issues or have suggestions for improvement, please open an issue or submit a pull request. Happy coding!
