# What's new in this build (frontend)
- Profile tab (Profile 2 layout) with cover photo, Settings list with mono icons
- Chat Folders, Power Saving, Message requests, Who can message me
- Reactions: full emoji picker, search, recents, reacted-by
- Group "Seen by", photo captions + upload progress, message info, shared media
- Text formatting, multi-forward, voice speed, App background colours
- Smoother screen transitions
Needs the backend migrations in rackgram-backend/supabase/migrations (already applied).

## Latest (frontend only, no backend change)
- Fixed the extra gap at the bottom of every screen (bottom bar, chat and group message box): the system-bar inset was applied twice.
- Chat folders: automatic All / Personal / Groups / Channels pills (your own folders still work and appear after them).
- Message requests row: no extra gap, same spacing as normal chats; requests sheet shows avatars.
- Chats: sender avatar next to incoming messages (groups and personal chats); tap the avatar (or the sender name in groups) to open that profile.

## Settings full screens (needs backend migration 20261012_settings_v2_call_guards.sql)
- Message Requests, Notifications and Devices now open as full screens (not bottom sheets); Settings list unchanged.
- Message Requests screen: who can message me, requests list, Blocked people list (unblock), Who can call me (Everyone / chatted with / Nobody).
- Notifications screen: call notifications toggle, quiet hours, muted chats list (tap to unmute).
- Devices screen: rename this phone, city, terminate one / all others.

## 2026-10-12 update (needs backend migration `20261012_group_admin_requests_ids.sql`, already applied)

- **Admin rights screen** (tap a member, then Make admin or Admin rights): 10 permissions, Remain anonymous, custom title, Dismiss admin. Saved with the `set_admin` RPC.
- **Add member**: shows only people you chat with, requests and saved contacts, plus a search box for anyone. Each person can add 10 people directly per group or channel, the rest join with the link.
- **Chat service messages**: small "Rack added Salima", "Neha joined via invite link", "Kabir joined, approved by Rack" lines. Several adds in a row merge into one line.
- **Join requests** (private groups): Permissions has a switch "Admin approval to join with link". Admins with Add members or Manage invite link see a Join requests screen, select people and approve or decline. No limit on approvals.
- **Links** show as `rackgram.app/name` (private: `rackgram.app/+code`). Change `LINK_HOST` in index.html to your own domain. Copy gives the full https link. Join with link accepts old `join/...` text and new links.
- **User ID** on a profile is now `r-1234567890` (unique per user) instead of the long UUID.
- Call errors from the new call guards ("only accepts calls from people they chat with") now show as a toast.
