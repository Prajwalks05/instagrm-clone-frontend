# 📸 Instagram Clone (Flutter + Supabase)

A full-featured Instagram Clone built with **Flutter** (Android + Web) and **Supabase** as backend.  
Features include:
- 📷 Post and Story Uploads
- 🖼 Story View with Multiple Media
- 💾 Local Profile Picture Storage
- 🌈 Modern UI with Metallic Gradient Theme
- 🌍 Web Support

---

## 🚀 Getting Started

This project is a starting point for running the Instagram Clone locally or on web.

---

## 🛠 Prerequisites
Make sure you have installed:
- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Git](https://git-scm.com/)
- [XAMPP](https://www.apachefriends.org/) (for local web hosting)
- A code editor (VS Code or Android Studio recommended)

---

## 📥 Clone the Repository
```bash
git clone https://github.com/yourusername/instagram_clone.git
cd instagram_clone
```

---

## 📱 Run on Android
1. Ensure a connected emulator or device is available.  
2. Run:
   ```bash
   flutter pub get
   flutter run 
   ```

---

## 🌐 Build for Web
To build Flutter app for the web:
```bash
flutter pub get
flutter build web --release --base-href="/instagram_clone/"
```

- The compiled web app will be located inside:
  ```
  build/web/
  ```

---

## 🌍 Deploy to XAMPP (Local Web Server)
1. Locate your **XAMPP `htdocs` folder**:
   ```
   C:/xampp/htdocs/
   ```
2. Copy the entire `build/web` folder into `htdocs`:
   ```
   C:/xampp/htdocs/instagram_clone/
   ```
3. Open the `index.html` inside `htdocs/instagram_clone/`:
   - Find the `<base>` tag and update:
     ```html
     <base href="/instagram_clone/">
     ```
4. Start Apache from XAMPP Control Panel.
5. Open in your browser:
   ```
   http://localhost/instagram_clone/
   ```
---

## 📄 Edit `<base>` Tag for GitHub Pages or Other Hosting
If deploying to **GitHub Pages**:
```bash
flutter build web --release --base-href="/instagrm-clone-frontend/"
```

---

## 📦 Folder Structure
```
instagram_clone/
│-- lib/                  # Main Flutter source code
│-- assets/               # Images, icons, etc.
│-- android/              # Android-specific configuration
│-- web/                  # Web-specific files
│-- build/                # Generated build output (ignored in .gitignore)
│-- pubspec.yaml          # Dependencies
│-- .env                  # Environment variables (ignored in git)
```

---

## 📝 License
This project is licensed under the MIT License.

---

## 📌 Author
**Prajwal Shetty** 
