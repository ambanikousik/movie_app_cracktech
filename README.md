# Movie App

Here are the things I felt worth to be mentioned:


## Architecture
1. I used domain driven architecture in a simplified manner. 
2. I used Bloc as state management library, which is my personal favorite and also preferred by official Flutter teams on many events.
3. For equality check I used Equatable instead of Freezed, because I wanted to avoid code-generation as much as possible.
4. I used FpDart for handling error like functional programming approach.
5. I used Fast-Immutable-Collection to make List and Map values for convenient.

## UI
1. For loading genre and Movie data I showed loading indicator and for error I showed error message as a popup dialog.
2. For showing movie details I used a bottom sheet so that the details info become scrollable across the screen which is more user friendly.
3. For showing movie poster I used CachedNetwork image and I've seen some of the poster links are dead, So I showed red exclamator (!) mark there.
4. When no internet connection is available, I showed a top indicator informing user that data is now being served from the cache.


## Caching
1. I used Hive as a local database to cache the data. As Hive was last updated 9 months ago, so I used a updated version of Hive from Github.
2. I also stored data in a temp variable for avoiding unnecessary api calls.
3. When no internet connection is available, I showed the cached data.

## Testing
1. I used bloc_test library for testing blocs.
2. I created a fake repository for testing.
3. As the level of testing was not mentioned and time was short, I only performed unit testing on blocs.



I hope this submission proves my level of expertise in Flutter and Dart. I'm looking forward to hearing from you soon.
Thank you.