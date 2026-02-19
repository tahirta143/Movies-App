
# CineVerse - A Netflix-Inspired Movie Streaming App

## Overview

CineVerse is a modern, professional, and feature-rich movie streaming mobile application built with Flutter. It is designed to provide a premium user experience similar to popular streaming services like Netflix and Amazon Prime Video. The app features a dark, elegant UI with neon accents, smooth animations, and a user-friendly layout.

## Design and Style

*   **Theme:** Dark theme with a combination of elegant black and deep navy blue backgrounds.
*   **Accent Color:** Neon red for buttons, highlights, and important UI elements.
*   **Layout:** Minimal, premium, and cinematic layout with a focus on visual hierarchy and balanced spacing.
*   **Cards and Components:** Glassmorphism effect for cards and UI components, with soft shadows and rounded corners (16px+).
*   **Typography:** A combination of a bold, cinematic font for headings and a clean sans-serif font for body text.
*   **Animations:** Smooth and subtle animations, including hero animations for poster transitions, fade and slide transitions between screens, and micro-interactions on user actions.

## Features

### Home Screen
*   **Hero Banner:** A large, auto-sliding hero banner showcasing featured movies with a gradient overlay.
*   **Movie Sections:** Horizontal scrolling lists for "Popular Movies," "Top Rated," "Now Playing," and "Upcoming."
*   **Movie Cards:** Each movie is represented by a poster with a 2:3 aspect ratio, a rating badge, and the movie title.

### Search Screen
*   **Search Bar:** A rounded search bar with a glassmorphism effect for instant search.
*   **Search Results:** A grid layout of movies that animates in as the user types.
*   **No Results:** An illustration is displayed when no search results are found.

### Movie Detail Screen
*   **Backdrop Image:** A full-width backdrop image of the movie with a gradient overlay.
*   **Movie Information:** Includes the movie title, genre chips, rating, and release date.
*   **Expandable Overview:** An expandable text section for the movie's overview.
*   **Cast and Crew:** A horizontal scrolling list of cast members with circular avatars.
*   **Trailer Button:** A "Watch Trailer" button that opens an embedded YouTube player.
*   **Similar Movies:** A section recommending similar movies.

### Trailer Screen
*   **Embedded Player:** An embedded YouTube player that supports up to 1080p resolution.
*   **Related Trailers:** A section for related movie trailers.

### Navigation
*   **Bottom Navigation Bar:** A bottom navigation bar with four tabs: Home, Search, Watchlist, and Profile.
*   **Floating Indicator:** An animated indicator that floats to the active tab.

### Extra Features
*   **Watchlist:** Users can add movies to their watchlist.
*   **Like Button:** Users can "like" movies.
*   **Dark/Light Mode Toggle:** A toggle to switch between dark and light themes.
*   **Profile Page:** A profile page with a user avatar and settings.

## Current Implementation

*   Created the basic project structure with `core`, `features`, and `main.dart`.
*   Defined the app's dark theme in `lib/core/theme/app_theme.dart`.
*   Added dependencies: `go_router`, `provider`, `google_fonts`, `flutter_svg`, `youtube_player_flutter`, `http`, and `flutter_dotenv`.
*   Set up navigation using `go_router` for all the screens.
*   **API Integration:**
    *   Created a `MovieService` to interact with the TMDB API.
    *   Added `flutter_dotenv` to manage the API key securely.
    *   Implemented methods to fetch popular, top-rated, now playing, and upcoming movies.
    *   Implemented a method to fetch detailed information for a specific movie.
    *   Implemented a method to search for movies.
    *   Implemented a method to fetch a movie's trailer.
*   **Screens (with real data):**
    *   `HomeScreen`: Displays lists of movies fetched from the TMDB API.
    *   `MovieDetailScreen`: Displays detailed information about a selected movie and a button to watch the trailer, fetched from the TMDB API.
    *   `SearchScreen`: Allows users to search for movies using the TMDB API and displays the results.
    *   `TrailerScreen`: Plays the movie trailer fetched from the TMDB API.
*   **Screens (UI Only):**
    *   `WatchlistScreen`: With a list of saved movies (using dummy data).
    *   `ProfileScreen`: With user information (using dummy data).
*   Created reusable widgets for `MovieCard`.

## Plan

1.  **Project Structure:** Create a well-organized project structure with `core`, `features`, and `main.dart`. (DONE)
2.  **Theme:** Define the app's theme in `lib/core/theme/theme.dart`. (DONE)
3.  **Dependencies:** Add necessary dependencies to `pubspec.yaml`. (DONE)
4.  **Navigation:** Set up routing using `go_router`. (DONE)
5.  **Screens:** Build the Home, Search, Movie Detail, and Profile screens. (DONE)
6.  **Widgets:** Create reusable widgets for movie cards, buttons, and other UI elements. (DONE)
7.  **API Integration:** Replace dummy data with real data from a movie API. (DONE)
8.  **State Management:** Use `provider` for state management for watchlist and user profile.
9.  **Animations:** Implement Hero animations, transitions, and micro-interactions.
10. **Authentication:** Implement user authentication.
