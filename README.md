# Rackgram – Frontend (Android app)

Sirf app code. Backend (database, RLS, edge functions, secrets) alag repo me hai: `rackgram-backend`.

## Backend se kaise judta hai
Sirf 2 public values, `index.html` ke top par (`SB_URL`, `SB_KEY`):
- `SB_URL` = Supabase project URL
- `SB_KEY` = **anon** (public) key. Ye public hone ke liye hi bani hai; asli suraksha backend ke RLS me hai.

## Is repo me ye kabhi mat daalo
- `service_role` key
- LiveKit API secret
- Firebase service-account JSON (private key wali)
- `WEBHOOK_SECRET`
- keystore / passwords

Ye sab sirf Supabase Edge Function secrets me rehte hain (backend repo ki README dekho).

`google-services.json` yahin rehta hai (Android ke liye zaroori, client config hai, secret nahi).
Google Cloud Console me uski API key ko package `com.rackgram.app` + SHA-1 tak restrict kar do.

## Build
GitHub → Actions → "Build APK" → Run workflow. Output artifact: `Rackgram-APK`.
Workflow sirf is repo ki files use karta hai.

## Files
- `index.html` – poori app (UI + Supabase client calls)
- `icon-*.png` – app icon (foreground = sirf white logo, background = grey)
- `android-native/` – notification / FCM native code
- `.github/workflows/build-apk.yml` – APK build
- `docs/CHANGELOG.md` – purani notes
