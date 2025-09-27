# 🚗🚶‍♂️ TripChain: Multi-Modal Mobility & Rewards Platform

TripChain is an innovative mobile application built with **Flutter** and **Firebase** designed to promote sustainable and efficient urban mobility. It leverages the concept of **trip-chaining**—linking multiple travel segments (walking, public transit, biking, etc.)—to offer users optimized routes, track their environmental impact, and reward them for choosing eco-friendly transportation.

---

## ✨ Features

The application incorporates a modern, feature-rich architecture, providing the following core functionalities:

1.  **Secure User Authentication:** Implemented via Firebase Authentication (`lib/screens/auth_gate.dart`) for secure sign-up and login.
2.  **Multi-Modal Trip Tracking:** Seamlessly records and maps multi-segmented journeys, capturing data for distance and mode of transport (`lib/screens/trip_details_screen.dart`).
3.  **Incentives & Rewards System:** A gamified experience where users earn points or rewards for sustainable travel, encouraging behavioral change (`lib/screens/rewards_screen.dart`).
4.  **Personalized Analytics:** Visual representation of travel patterns, mode usage breakdown, and environmental impact savings (CO2 reduction) (`lib/screens/analytics_screen.dart`).
5.  **Trip History & Review:** Comprehensive log of all past trips and chained journeys (`lib/screens/trip_history.dart`).

---

## 💻 Tech Stack

| Component | Technology | Role in Project |
| :--- | :--- | :--- |
| **Frontend** | **Flutter** (Dart) | Cross-platform UI development (iOS, Android). |
| **Backend** | **Firebase** | Cloud Firestore for data storage and Firebase Auth for user management. |
| **State Mgt.** | Provider / Riverpod *(Recommended)* | State management for scalable application structure. |
| **Geo-Services** | Google Maps Platform / Geolocator *(Implied)* | Tracking real-time user location and rendering maps. |

---

## 📸 Application Screenshots

To ensure these screenshots display correctly, please create a folder named **`assets/screenshots`** in the root of your repository and upload the corresponding images there.

<h3 align="center">Application Screenshots</h3>

<div align="center">
    
| Onboarding/Welcome Screen | Rewards Dashboard | Trip Analytics Overview |
| :---: | :---: | :---: |

<table width="100%">
    <tr>
    <td align="center">
      <a href="https://github.com/KARAN-KATAKDHOND/Trip_Chain/blob/master/lib/assets/screenshots/Log.jpg"><img src="https://github.com/KARAN-KATAKDHOND/Trip_Chain/blob/master/lib/assets/screenshots/Log.jpg" alt="App Login Screen" width="300" style="max-width:100%;"></a>
      <br>
      <p><strong>[Login Screen]</strong></p>
    </td>
    <td align="center">
      <a href="https://github.com/KARAN-KATAKDHOND/Trip_Chain/blob/master/lib/assets/screenshots/signup.jpg"><img src="https://github.com/KARAN-KATAKDHOND/Trip_Chain/blob/master/lib/assets/screenshots/signup.jpg" alt="App Rewards Dashboard" width="300" style="max-width:100%;"></a>
      <br>
      <p><strong>[Signup]</strong></p>
    </td>
    <td align="center">
      <a href="https://github.com/KARAN-KATAKDHOND/Trip_Chain/blob/master/lib/assets/screenshots/homescreen.jpg"><img src="https://github.com/KARAN-KATAKDHOND/Trip_Chain/blob/master/lib/assets/screenshots/homescreen.jpg" alt="App Trip Analytics" width="300" style="max-width:100%;"></a>
      <br>
      <p><strong>[Homescreen]</strong></p>
    </td>
  </tr>
    ########################################################################################################################################################################
  <tr>
    <td align="center">
      <a href="https://github.com/KARAN-KATAKDHOND/Trip_Chain/blob/master/lib/assets/screenshots/add_trip.jpg"><img src="https://github.com/KARAN-KATAKDHOND/Trip_Chain/blob/master/lib/assets/screenshots/add_trip.jpg" alt="App Trip Analytics" width="300" style="max-width:100%;"></a>
      <br>
      <p><strong>[Onboarding Screen]</strong></p>
    </td>
    <td align="center">
      <a href="./assets/screenshots/rewards_dashboard.png"><img src="https://github.com/KARAN-KATAKDHOND/Trip_Chain/blob/master/lib/assets/screenshots/rewards.jpg" alt="App Rewards Dashboard" width="300" style="max-width:100%;"></a>
      <br>
      <p><strong>[Rewards Dashboard]</strong></p>
    </td>
    <td align="center">
      <a href="./assets/screenshots/analytics_overview.png"><img src="https://github.com/KARAN-KATAKDHOND/Trip_Chain/blob/master/lib/assets/screenshots/analytics.jpg" alt="App Trip Analytics" width="300" style="max-width:100%;"></a>
      <br>
      <p><strong>[Analytics Overview]</strong></p>
    </td>
  </tr>
    #################################
    <tr>
    <td align="center">
      <a href="https://github.com/KARAN-KATAKDHOND/Trip_Chain/blob/master/lib/assets/screenshots/profile.jpg"><img src="https://github.com/KARAN-KATAKDHOND/Trip_Chain/blob/master/lib/assets/screenshots/profile.jpg" alt="App Trip Analytics" width="300" style="max-width:100%;"></a>
      <br>
      <p><strong>[User Profile]</strong></p>
    </td>
    <td align="center">
      <a href="./assets/screenshots/trip_history.png"><img src="https://github.com/KARAN-KATAKDHOND/Trip_Chain/blob/master/lib/assets/screenshots/trip_history.jpg" alt="App Rewards Dashboard" width="300" style="max-width:100%;"></a>
      <br>
      <p><strong>[Rewards Dashboard]</strong></p>
    </td>
    <td align="center">
      <a href="./assets/screenshots/analytics_overview.png"><img src="https://github.com/KARAN-KATAKDHOND/Trip_Chain/blob/master/lib/assets/screenshots/analytics.jpg" alt="App Trip Analytics" width="300" style="max-width:100%;"></a>
      <br>
      <p><strong>[Analytics Overview]</strong></p>
    </td>
  </tr>
</table>

</div>

---

## 🛠️ Getting Started

Follow these steps to set up and run the project locally.

### Prerequisites

* **Flutter SDK** (Latest Stable Channel)
* **Dart SDK**
* **Firebase CLI** (`npm install -g firebase-tools`)

### Installation & Setup

1.  **Clone the Repository:**
    ```bash
    git clone [https://github.com/KARAN-KATAKDHOND/Trip_Chain.git](https://github.com/KARAN-KATAKDHOND/Trip_Chain.git)
    cd Trip_Chain
    ```
2.  **Install Dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Configure Firebase Project:**
    * Create a project on the [Firebase Console](https://console.firebase.google.com/).
    * Enable **Email/Password** Authentication and **Cloud Firestore**.
    * Generate the configuration files using the FlutterFire CLI:
        ```bash
        flutterfire configure
        ```
    * *(Note: You must have the project registered on Firebase for Android/iOS/Web before running this command.)*

4.  **Run the App:**
    ```bash
    flutter run
    ```

---

## 🤝 Contributing

We welcome contributions! Feel free to report bugs, suggest features, or submit pull requests.

1.  Fork the Project.
2.  Create your Feature Branch (`git checkout -b feature/new-feature-name`).
3.  Commit your Changes (`git commit -m 'feat: Added new trip optimization algorithm'`).
4.  Push to the Branch (`git push origin feature/new-feature-name`).
5.  Open a Pull Request.

---

## 📜 License

Distributed under the MIT License. See the `LICENSE` file for more details.

**Project Link:** [https://github.com/KARAN-KATAKDHOND/Trip\_Chain](https://github.com/KARAN-KATAKDHOND/Trip_Chain.git)
