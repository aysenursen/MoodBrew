# ☕ MoodBrew

**MoodBrew** is a minimalist coffee recommendation app that helps users decide *what to drink* based on how they feel — not just what they know.

Instead of overwhelming users with endless menus, MoodBrew asks a few thoughtful questions and gently guides them to the coffee that fits their current mood.

> Coffee is the excuse. Understanding the user is the goal.

---

## ✨ Key Features

- 🔍 **Mood-based coffee recommendations**  
  Short, intuitive questions lead to a personalized coffee suggestion.

- 🧠 **Explainable matching logic**  
  Each recommendation includes a *“Why this coffee?”* explanation.

- 📖 **Coffee knowledge & fun facts**  
  Learn about beans, roasts, aromas, and coffee culture without information overload.

- ❤️ **Save your moments**  
  Users can save their favorite recommendations after signing up.

- 🤖 **AI-powered Premium Experience**  
  Premium users unlock deeper, conversational recommendations powered by AI.

- 🚀 **Usable without sign-up**  
  No friction. Explore freely, sign up only when you want to save or go premium.

---

## 🧭 App Flow

1. **Onboarding (No Login Required)**  
   Users answer a few quick preference questions:
   - Hot / Cold  
   - Body (Light, Medium, Full)  
   - Aroma preferences  
   - Mood & energy level

2. **Recommendation Result**  
   - Coffee name & type  
   - Short explanation  
   - Optional fun fact  
   - “Save this moment” CTA

3. **Authentication (Firebase Auth)**  
   Triggered only when:
   - Saving a recommendation  
   - Accessing premium features

4. **Premium (AI-Enabled)**  
   - Natural language coffee advice  
   - Mood interpretation  
   - Personalized suggestions over time

---

## 🏗️ Architecture
The app is built following **Clean Architecture** principles.
This structure ensures:
- Separation of concerns  
- Testability  
- Scalability  
- Easy AI & feature expansion  

---

## 🔥 Tech Stack

- **Frontend:** Flutter  
- **Architecture:** Clean Architecture  
- **State Management:** (e.g. Bloc / Riverpod / Provider)  
- **Backend & Database:** Firebase (Auth, Firestore), Cloudinary
- **AI (Premium):** External AI API integration  
- **Design:** Minimalist, user-centric UI  

---

## 📊 Data Strategy

- **Static coffee data** (types, aromas, fun facts):  
  Stored in **Firestore** for flexibility and easy updates.

- **User data** (favorites, preferences, premium status):  
  Managed via **Firebase Authentication & Firestore**.

- **AI interactions:**  
  Triggered only for premium users to optimize cost and performance.

---

## 🎯 Why MoodBrew?

Most coffee apps assume users already know what they want.

MoodBrew assumes the opposite.

It’s designed for moments like:
- “I want coffee, but I don’t know what.”
- “I want something comforting.”
- “I want to try something new, but safely.”

MoodBrew removes decision fatigue — gently.

---

## 🚧 Project Status

🟡 In active development  
Planned features include:
- Recommendation history
- Smarter AI personalization
- Multi-language support

---

## 👩‍💻 Author

Developed by **Ayşe Nur Şen**  
Computer Engineering Graduate  
Focused on user-centered design & intelligent systems
