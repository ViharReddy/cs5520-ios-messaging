# cs5520-ios-messaging
# iOS Chat Application (WA8)

A real-time messaging application for iOS built with Swift, UIKit, and Firebase. This app provides secure user authentication, real-time chat functionality, and a clean, modern interface for seamless communication between users.

## Features

### User Authentication
- **Secure Registration**: Create new accounts with email validation and password requirements
- **Login System**: Secure authentication using Firebase Auth
- **Password Visibility Toggle**: Show/hide password feature for better UX
- **Input Validation**: Email format validation and password strength requirements (minimum 6 characters)
- **Session Management**: Automatic session persistence and logout functionality

### Chat Features
- **Real-time Messaging**: Instant message delivery using Firebase Firestore listeners
- **Create New Chats**: Start conversations with registered users
- **Group Chat Support**: Create chats with multiple participants
- **Message Timestamps**: Display time for each message with smart formatting (Today, Yesterday, Date)
- **Last Message Preview**: Shows recent message and timestamp in chat list
- **Delete Chats**: Swipe to delete conversations
- **Duplicate Chat Prevention**: Automatically detects and prevents creating duplicate one-on-one chats

### User Profile
- **Profile Display**: View user name and email
- **Sign Out**: Secure logout functionality
- **User Session Management**: Singleton pattern for maintaining user state

### UI/UX Features
- **Tab Bar Navigation**: Easy switching between Chats and Profile
- **Custom Message Bubbles**: Distinct styling for sent and received messages
- **Dynamic Keyboard Handling**: Auto-adjusting view when keyboard appears
- **Pull-down Modal Sheets**: Modern iOS presentation style for creating new chats
- **Empty State Handling**: Informative message when no chats exist
- **Responsive Design**: Auto Layout constraints for all screen sizes

## Project Structure

```
WA8/
│
├── Models/
│   ├── User.swift              # User data model
│   ├── Chat.swift              # Chat conversation model
│   └── Message.swift           # Message model with timestamp formatting
│
├── Views/
│   ├── LoginView.swift         # Login screen UI
│   ├── SignupView.swift        # Registration screen UI
│   ├── ChatsView.swift         # Chat list screen UI
│   ├── ChatView.swift          # Individual chat screen UI
│   ├── CreateChatView.swift    # New chat creation UI
│   └── ProfileView.swift       # User profile screen UI
│
├── ViewControllers/
│   ├── LoginViewController.swift       # Handles login logic
│   ├── SignupViewController.swift      # Handles registration
│   ├── ViewController.swift            # Main tab bar controller
│   ├── ChatsViewController.swift       # Manages chat list
│   ├── ChatViewController.swift        # Individual chat messages
│   ├── CreateChatViewController.swift  # User selection for new chats
│   └── ProfileViewController.swift     # Profile management
│
├── Cells/
│   ├── ChatsTableViewCell.swift       # Chat list item cell
│   ├── UsersTableViewCell.swift       # User selection cell
│   ├── IncomingMsgCell.swift          # Received message bubble
│   └── OutgoingMsgCell.swift          # Sent message bubble
│
├── Utilities/
│   ├── Utilities.swift         # Helper functions (email validation)
│   └── UserSession.swift       # Singleton for user session
│
└── App/
    ├── AppDelegate.swift        # App lifecycle and Firebase setup
    └── SceneDelegate.swift      # Scene management and initial navigation

```

## Technical Stack

- **Language**: Swift 5
- **UI Framework**: UIKit (Programmatic UI)
- **Backend**: Firebase
  - Firebase Authentication (Email/Password)
  - Cloud Firestore (Real-time Database)
- **Architecture Pattern**: MVC (Model-View-Controller)
- **Design Patterns**: Singleton (UserSession), Delegation

## Requirements

- iOS 13.0+
- Xcode 12.0+
- Swift 5.0+
- CocoaPods or Swift Package Manager

## Installation

### 1. Clone the Repository
```bash
git clone https://github.com/yourusername/WA8.git
cd WA8
```

### 2. Install Dependencies

#### Using CocoaPods:
```bash
pod install
```

#### Using Swift Package Manager:
1. Open the project in Xcode
2. Go to File → Add Packages
3. Add Firebase iOS SDK: `https://github.com/firebase/firebase-ios-sdk`
4. Select the following packages:
   - FirebaseAuth
   - FirebaseFirestore

### 3. Configure Firebase

1. Create a new project in [Firebase Console](https://console.firebase.google.com)
2. Add an iOS app to your Firebase project
3. Download the `GoogleService-Info.plist` file
4. Add the file to your Xcode project root
5. Enable Email/Password authentication in Firebase Console
6. Create a Firestore database

### 4. Build and Run
1. Open `WA8.xcworkspace` (if using CocoaPods) or `WA8.xcodeproj`
2. Select your target device or simulator
3. Press `Cmd + R` to build and run

## Database Structure

### Firestore Collections

#### `users` Collection
```javascript
{
  uid: "user_unique_id",
  name: "User Name",
  email: "user@email.com"
}
```

#### `chats` Collection
```javascript
{
  chatId: "auto_generated_id",
  with: ["uid1", "uid2", ...],        // Array of participant UIDs
  withNames: ["Name1", "Name2", ...], // Array of participant names
  lastMessage: "Latest message text",
  lastSender: "sender_uid",
  lastUpdated: Timestamp
}
```

#### `chats/{chatId}/messages` Subcollection
```javascript
{
  id: "message_id",
  senderId: "sender_uid",
  senderName: "Sender Name",
  text: "Message content",
  timestamp: Timestamp
}
```

## Key Features Implementation

### Real-time Updates
The app uses Firestore listeners for real-time updates:
- Chat list updates automatically when new messages arrive
- Messages appear instantly in active conversations
- User presence and typing indicators (can be extended)

### Security Rules (Firestore)
Recommended security rules for production:
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can only read/write their own profile
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Chat access only for participants
    match /chats/{chatId} {
      allow read, write: if request.auth != null && 
        request.auth.uid in resource.data.with;
      
      // Messages in chat
      match /messages/{messageId} {
        allow read, write: if request.auth != null &&
          request.auth.uid in get(/databases/$(database)/documents/chats/$(chatId)).data.with;
      }
    }
  }
}
```

## Future Enhancements

- [ ] Push Notifications
- [ ] Media Sharing (Images, Videos)
- [ ] Voice Messages
- [ ] Read Receipts
- [ ] Typing Indicators
- [ ] User Online/Offline Status
- [ ] Message Search
- [ ] Dark Mode Support
- [ ] Message Reactions
- [ ] End-to-End Encryption
- [ ] User Profile Pictures
- [ ] Message Edit/Delete
- [ ] Group Chat Admin Features
- [ ] Voice/Video Calling

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Author

**Sai Vihar Reddy Gunamgari**

## Acknowledgments

- Firebase for providing real-time database and authentication services
- Apple's UIKit framework for the robust UI components
- The iOS development community for continuous learning resources

## Support

For issues, questions, or suggestions, please create an issue in the GitHub repository.