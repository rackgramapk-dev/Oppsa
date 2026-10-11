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
