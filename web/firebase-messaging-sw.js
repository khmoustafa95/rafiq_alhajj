// Firebase Cloud Messaging service worker for Web Push.
//
// This file MUST live at the web root and be named `firebase-messaging-sw.js`;
// the `firebase_messaging` web plugin registers it automatically.
//
// Service workers cannot read Dart `--dart-define` values, so the Firebase web
// config below must be filled in manually. All of these are PUBLIC client
// values (safe to ship): copy them from Firebase Console → Project settings →
// your Web app → "SDK setup and configuration".
//
// Keep these values in sync with the FIREBASE_* web `--dart-define`s.

importScripts(
  'https://www.gstatic.com/firebasejs/10.12.2/firebase-app-compat.js',
);
importScripts(
  'https://www.gstatic.com/firebasejs/10.12.2/firebase-messaging-compat.js',
);

firebase.initializeApp({
  apiKey: 'AIzaSyB6yQydgip8E8MfCWjVn8fmL0a3Er9rj2k',
  authDomain: 'rafiq-alhajj.firebaseapp.com',
  projectId: 'rafiq-alhajj',
  storageBucket: 'rafiq-alhajj.firebasestorage.app',
  messagingSenderId: '459655824918',
  appId: '1:459655824918:web:42f67ac7e460e2ab901737',
});

const messaging = firebase.messaging();

// Shown only while the page is not focused (closed tab / background). Foreground
// messages are handled inside the Flutter app via the Realtime in-app toast.
messaging.onBackgroundMessage((message) => {
  const notification = message.notification || {};
  const data = message.data || {};
  const title = notification.title || data.title || 'رفيق الحاج';
  const options = {
    body: notification.body || data.body || '',
    icon: '/icons/Icon-192.png',
    badge: '/icons/Icon-192.png',
    data: data,
  };
  self.registration.showNotification(title, options);
});

// Focus/open the app when the user clicks a background notification.
self.addEventListener('notificationclick', (event) => {
  event.notification.close();
  event.waitUntil(
    self.clients
      .matchAll({ type: 'window', includeUncontrolled: true })
      .then((clientList) => {
        for (const client of clientList) {
          if ('focus' in client) {
            return client.focus();
          }
        }
        if (self.clients.openWindow) {
          return self.clients.openWindow('/');
        }
        return undefined;
      }),
  );
});
