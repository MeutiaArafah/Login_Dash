# 🚀 Hajime Starter Kit Documentation

Welcome to the **Hajime Starter Kit** — a production-ready, feature-first Flutter template powered by Firebase, Riverpod 3.0, and GoRouter. 

---

## 🏗️ Architecture & Philosophy

This starter kit uses a **Feature-First Architecture** rather than layering by type.
- **State Management**: `flutter_riverpod` (v3.0 syntax) with `riverpod_generator`.
- **Navigation**: `go_router` (guarded by global auth streams).
- **Authentication**: `firebase_auth` & `google_sign_in` (Social-first entry).
- **Data Modeling**: `freezed` & `json_annotation`.
- **Theming**: `flex_color_scheme` (dynamic automatic themes).

---

## 🛠️ The Ultimate Firebase Setup Guide

*When you duplicate this starter kit for a brand new app, you must link it to a brand new backend. Follow these exact steps from start to finish to avoid "OAuth", "Platform", or "Compilation" traps!*

### Phase 1: Creating the Server in Firebase
1. Open your browser and head to the [Firebase Console](https://console.firebase.google.com/).
2. Click **Create Project**. Give your new app a name, disable Google Analytics (unless you want it), and wait for it to generate.
3. Once inside the project dashboard, look at the left sidebar menu under "Build" and click **Authentication**. Click the **Get Started** button.
4. You will be placed on the **Sign-in method** tab. Click **Email/Password**. Toggle "Enable" on, and hit Save.
5. Click **Add new provider** on that same list and select **Google**. Toggle "Enable" on, select your email address in the support dropdown, and hit Save.
6. Still inside the Authentication page, click the **Settings** tab. Look for **User account linking** and ensure it is set to **"Link accounts that use the same email"**. *(This flawlessly merges users who switch between password and Google login).*
7. Go back to the left sidebar menu, click **Firestore Database**, and click **Create database**. Select your region, and choose **Start in Test Mode** (you will update its security rules before publishing). 

### Phase 2: Connecting the Flutter Code (FlutterFire)
1. Ensure your local terminal has the CLI tools installed by running: `dart pub global activate flutterfire_cli`.
2. Inside your terminal, navigate to the root folder of this codebase and run:
   ```bash
   dart pub global run flutterfire_cli:flutterfire configure
   ```
3. Use your arrow keys to select the Firebase project you just created in Phase 1.
4. **CRITICAL:** Use your spacebar to ensure **Web**, **Android**, and **iOS** are all checked before hitting Enter.
5. The CLI will download the remote keys and automatically generate your `lib/firebase_options.dart` file!

### Phase 3: The Google Sign-In Security Traps
*Firebase automatically creates Google OAuth client keys when you enabled Google in Phase 1, but Google specifically prevents them from working until you "prove" who is using them!*

#### Trap A: Android Needs a SHA-1 Fingerprint
Google needs to know your development computer's digital signature to allow Android to securely pop up the Google Login screen.
1. In your terminal, run:
   ```bash
   cd android && ./gradlew signingReport
   ```
2. Wait a few seconds, then find the `SHA1: xx:xx:xx...` key under the **debug** section. Copy that huge string.
3. Go back to your **Firebase Console** -> Click the **Settings Gear ⚙️** (top left) -> **Project Settings**.
4. Scroll down, select your Android App, click **Add fingerprint**, paste your SHA-1 key, and save!

#### Trap B: The Web Client ID Metadata
The native Google Sign In package requires Web platforms to declare their ID right inside the root `.html` file.
1. Go back to **Firebase Console** -> **Authentication** -> **Sign-in Method** -> click the pencil on **Google**.
2. Click open the **"Web SDK configuration"** accordion.
3. Copy the **Web client ID** string (it ends in `.apps.googleusercontent.com`).
4. Head into your Flutter code and open `web/index.html`.
5. Look for the `<meta name="google-signin-client_id" ... >` tag and replace its `content` value with your newly copied Client ID.
6. Open `lib/features/auth/data/auth_repository.dart` and paste that exact same string into the `signInWithGoogle()` Client ID placeholder!

#### Trap C: The "Error 401 invalid_client" on Chrome
When testing the Web build locally, Flutter naturally selects a random port (e.g. `localhost:39182`), which Google blocks for security. We must lock it and whitelist it.
1. In your **Firebase Console**, go to **Project Settings** ⚙️ -> **Integrations** tab -> find Google Cloud, and click the blue link for **Google APIs console** (Or go directly to [Google Cloud Credentials](https://console.cloud.google.com/apis/credentials)).
2. Under **OAuth 2.0 Client IDs**, click the name `Web client (auto created by Google Service)`.
3. Scroll deeply down to **Authorized JavaScript origins**. Click **Add URI** and type: `http://localhost:5555`.
4. Hit **Save** at the very bottom.
5. You must now ALWAYS run your web app using this specific locked port in your terminal:
   ```bash
   flutter run -d chrome --web-port=5555
   ```

*(Note: It can sometimes take 2 to 3 minutes for Google Cloud servers to process the javascript origin save!)*

---

## 🧩 Running Code Generation
Because we utilize Riverpod and Freezed natively, a lot of highly potent boilerplate code (the files ending in `.g.dart` or `.freezed.dart`) are generated automatically for speed and error-reduction. 

Whenever you add a new `@riverpod` method or edit a `@freezed` class, run:
```bash
dart run build_runner build -d
```

---

## 🔐 How The Auth Router Gateway Works

We intentionally avoid using messy `if (user == null)` ternary operators inside our individual UI files. Instead, everything utilizes a global **Router Guard**. 

Inside `lib/core/routing/app_router.dart`, `GoRouter` listens aggressively to the `authStateChangesProvider`.
- If the user isn't logged in, navigating *anywhere* automatically redirects them to the `WelcomeScreen`!
- If the user is logged in, GoRouter seamlessly authenticates and allows them passage to the `HomeScreen`.
