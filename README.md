# WeatherApp
Take home project

This project is a weather app that uses a geocoded endpoint to fetches locations and fetches its associated weather with another API call. The app also caches the selected locations. I decided not to cache the weather since we’ll prob want the most up-to-date weather.

| Weather App |
|-|
| ![Screen Recording 2023-05-19 at 04 48 53 PM](https://github.com/Cwalker924/WeatherApp/assets/20428058/d532beff-79ae-44f4-9ac8-1d5a08960732) |

# 🤷🏾‍♂️ Why MVVM+C?
MVVM is battle tested architecture that has clear separation of data from API -> UI and suits this project.

#### [Networking] -> [Model] -> [ViewModel] -> [View]


# 🧐 Is that a +C in MVVM+C?
So maybe it’s more like:

#### [Coordinator] -> [Networking] -> [Model] -> [ViewModel] -> [View]

My appreciation for the Coordinator pattern came when implementing deep linking in my previous role. The Coordinator typically handles Networking and Navigation and can be spun up in an instant, making the app more modular. With a bit of dependency injections, the app and its components become far more testable.


# 🔥SwiftUI?
Aside from the fact that,

![](https://media.tenor.com/zFHAoUeMbKgAAAAC/i-like-it-a-lot-jim-carrey.gif)

SwiftUI is great for rapid development. Plus, SwiftUI/Combine is the future!... in my opinion. It’s highly unlikely UIKit will be dethroned any time soon. So… I attempted to answer the question as to how these two frameworks could work with one another in a realistic way.

I can also appreciate a codebase that is soft on newer, native API and frameworks (in good time of course). Be the change you wish to see, right?


# 👴🏾 If I had more time…
- If this was an enterprise app, I would move the Networking from the ViewModel to the Coordinator, mainly for consistency with UIKit implementation.
- Add more tests
- Added more subtle animation w/ SwiftUI (cause why not?!)
- Added more dummy data. The free version of this API doesn’t give us a ton.



# ⚖️Trade offs
Its not super obvious, but because we’ve decided to run with UIKit as a base and layer SwiftUI over the top, all of our navigation is done in the UIKit world. Meaning we lose the ease of SwiftUI navigation (NavigationView/NavigationLink). You’ll probably notice some of the workarounds implemented dealing with the Nav titles within the Weather Search Coordinator

\* I really hope Apple comes out with more APIs to help SwiftUI interface with UIKit.


# 😌 Stuff I’m proud of
- Architecture: You might notice my attempts to consider a Combine solution for data transportation (check out [WeatherSearchCoordinator.swift](https://github.com/Cwalker924/WeatherApp/blob/main/WeatherApp/Coordinators/WeatherSearchCoordinator.swift)) over other more traditional approaches (delegates, KVO, etc).
- Custom image caching that ultimately resulted in cloning the native AsyncImage APIs implementation
- Subtle animations so changes are less jolting


# ▶️ How to run
Once you’ve entered a development team for the project, and have entered your api key in ([APIKeys.swift](https://github.com/Cwalker924/WeatherApp/blob/main/WeatherApp/Networking/APIKeys.swift)) press XCode’s play button!


# ♻️ Reused code
The Coordinator class is re-used code from previous projects.

# 👀 Screenshots
| If you see this screen, you've gone too far. But seriously, you'll need to grab an API key from "openweathermap.org" | WeatherSearch View powered by the WeatherSearchCoordinator | 
|-|-|
| ![Simulator Screenshot - iPhone 14 Pro - 2023-05-19 at 12 58 06](https://github.com/Cwalker924/WeatherApp/assets/20428058/7d8ce3cd-56c3-4c72-8748-09947c439c9e) | ![Simulator Screenshot - iPhone 14 Pro - 2023-05-19 at 15 11 00](https://github.com/Cwalker924/WeatherApp/assets/20428058/fdc45777-9a23-49bf-8809-ee9142262e22) |

| Want to use your current location? Tap the location button to the left of the search bar! | WeatherView powered by the WeatherViewCoordinator |
|-|-|
| ![Simulator Screenshot - iPhone 14 Pro - 2023-05-19 at 15 12 37](https://github.com/Cwalker924/WeatherApp/assets/20428058/f1bdb683-b35a-42fb-b896-38d6f8db6c05) | ![Simulator Screenshot - iPhone 14 Pro - 2023-05-19 at 15 12 46](https://github.com/Cwalker924/WeatherApp/assets/20428058/00570fb1-aea3-4fad-87d6-8d65d6843fc0) |
