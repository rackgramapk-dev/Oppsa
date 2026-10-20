# What's new (v12)

## Posts on the profile (needs backend migration docs/posts_migration.sql)
- Own profile: a "Posts" section under Highlights with an "Add post" button and a 3x3 style grid of tall (4:5) photos. Other people's profiles show their posts (read only), under Highlights.
- Add post: pick a photo (it is cropped to 4:5), write an optional caption, tap Post. Photos are saved in the avatars bucket as <uid>/post-*.jpg and rows go to public.posts (RLS: everyone signed in can see, only the owner can add, edit or delete; blocked people cannot).
- Every photo has a light glass-crack in one corner (the same crack each time for the same post).
- Tap a post to open the full photo with its caption. Owner: Edit caption and Delete post buttons there too.
- Long-press a post (own profile): the other posts dim and a floating menu opens with Edit caption, Delete post (red) and Cancel. Delete asks for confirmation and removes the photo file as well.
- Nothing else in the app was changed; the new code is one block that wraps the existing profile screens, like Highlights.

# What's new (v11)

## Chat long-press menu redesign (frontend only, no backend change)
- Long-press on a chat now opens the floating card menu (same style as the story menu): line icons, separate red card, separate Cancel card.
- Card 1: Pin / Unpin, Mark as unread / Mark as read, Mute / Unmute, Archive / Unarchive, Add to folder.
- Card 2 (personal chats): Clear history and Delete chat, both with a confirm sheet. Delete chat also removes the chat from pins, archive and folders.
- Card 2 (groups and channels): Leave group/channel, plus Delete group/channel for the owner (existing confirm sheets).
- Mark as unread is saved on this phone only (localStorage); it shows a badge "1" and clears when you open the chat.
- Add to folder: tap a folder to add or remove this chat; "Create new folder" opens the existing folder editor.
- Personal chats have no per-user delete in the database, so Clear history and Delete chat remove messages for both sides, like the old Clear chat.

# What's new (v10)

## Chat list: seen / delivered tick (frontend only, no backend change)
- If the last message in a chat is yours, a tick shows before the time: one tick = sent, two grey = delivered, two blue = seen, clock = sending, red ! = failed.
- Incoming last message: no tick (unread badge as before). Channels: no tick.
- Group chats show the tick from the group "seen by" data (loaded once per group).
- Personal chats update live when the other person reads your message.
- Respects Settings > hide read receipts. Nothing else in the list changed.

## Scrollbar line removed (frontend only)
- The thin line under the folder pills (All / Personal / Groups / Channels) was the horizontal scrollbar. Scrollbars are now hidden everywhere; scrolling works as before.

# What's new (v9)

## Full emoji keyboard for reactions (frontend only, no backend change)
- "Choose reaction" now has the complete phone-keyboard emoji set (1900+): Faces, People, Nature, Food, Travel, Activity, Objects, Symbols, Flags. One continuous scroll with section headers; tap a category pill to jump, the pill follows as you scroll.
- Search works on names and keywords (for example "love", "sad", "fire"). Recent row stays on top.
- Skin tones: long-press any hand/person emoji to pick a tone.
- Emoji your phone cannot draw yet (newest Unicode) are hidden automatically, so no empty boxes.
- Database: reaction emoji column allows 16 characters, the longest emoji here is 10, so no migration needed. RLS unchanged.

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

## Latest UI polish (frontend only, no backend change)
- Admin rights screen: emoji removed, line icons, card layout, dark toggle knob when off, blue section labels.
- Member menu: bottom sheet replaced by a small pop-up under the member row (Message, Make admin / Admin rights, Remove in red) with line icons. Tap outside or the row again to close.
- "Restrict" is not added yet (needs a backend function).
- Group/channel Profile redesigned: round actions (Open chat, Mute, Add), link card with copy icon, options (Edit, Permissions, Join requests) now above the members, members in one card with Owner/Admin badges, Leave/Delete at the bottom.
- Permissions and Edit group now open as full screens (switches instead of checkboxes, photo with camera badge) instead of bottom sheets.

## Highlights (Instagram style)
- Own profile: "Highlights" row under the info card. "New" makes a highlight from your live stories; long-press a highlight for Edit / Add stories / Delete.
- Story viewer (own story): new star button adds that story to a highlight.
- Edit highlight screen: name, cover (Gallery or from the highlight's stories), add/remove stories, delete.
- Other people's profiles show their highlights (read only).
- Backend: tables public.highlights and public.highlight_items (RLS on) - see docs/highlights_migration.sql. Photos are copied to the avatars bucket (<uid>/hl-*.jpg) so they outlive the 24h story.
- Note: stories hidden by RLS after 24h, so only live stories can be added.

## Story photo fit (frontend only)
- Story editor no longer crops a photo to fill 9:16. The whole photo is shown (fit), empty bars get a blurred copy of the photo (Instagram style).
- Pinch to zoom in/fill and drag to position as before; max zoom now scales with the photo shape.
- Story editor zoom is now Instagram style: one finger moves the photo, two fingers pinch to zoom in and out around the point between your fingers (and move while pinching). Minimum zoom = whole photo visible; maximum scales with the photo shape.

## Story editor redesign (frontend only, no backend change)
- New layout: full-bleed photo, floating tool dock (Text, Stickers, Draw, Filters), Share to story button below. All emoji/unicode icons replaced by line icons.
- Fixed the overlap bug: photo now sizes itself to the free space (ResizeObserver), so opening Filters/Draw/Stickers shrinks the photo instead of covering the buttons.
- Zoom: photos auto-fit (or auto-fill when close to 9:16); big photos are scaled to 2560px once; Fit/Fill button, double-tap to toggle, 90 degree Rotate.
- Filters: thumbnails of your own photo, Intensity slider, Adjust tab (Brightness, Contrast, Saturation) with Reset.
- Text: alignment button (center/left/right). Save to device button (share sheet or download).

## Story icons + swipe-up viewers (frontend only)
- Story editor icons are now the solid style (Aa glyph, filled smile, pen and sparkles). Viewer header and footer emoji/symbols replaced with line icons.
- Own story: swipe up anywhere on the story to open the Viewers list (same as the Viewers button). The timer pauses while the list is open. Swipe down still closes.

## Story editor fixes (frontend only)
- Drag a sticker/text onto the trash circle (bottom centre) and release: it now deletes (the trash position was measured after it was hidden).
- Pinch with two fingers anywhere on the screen to resize/rotate the sticker you are holding (works for small Mention/Hashtag/Location stickers too).
- Text dialog: no more big white box; the text box now fits the text.
- Sticker panel: emoji grid removed, replaced by label stickers (NEW, LOL, MOOD, ...).
- Location sticker: opens a picker (current location + search by name) and adds the real place name.

## Story viewers + reactions (frontend only, no backend change)
- Own story: swipe up anywhere (also over the bottom bar), tap the Viewers button, or use ... > Viewers: an Instagram-style panel slides up (drag the handle down, tap outside, or Back to close). Timer pauses while it is open.
- Panel shows view count, like count, each viewer with time, their emoji reaction and story reply text; tap a row to open the chat.
- Other people's stories: quick emoji row now has a + button for the full emoji list, emoji float up on screen when sent, and a Send button appears while typing (Enter still works).

## Story menu redesign (frontend only)
- The story "..." menu is now a floating action sheet: a rounded card with Viewers, Add story and Delete story (red), and a separate Cancel card. Other people's stories get Like/Unlike and Open chat in the same style.

## Send and New story sheets (frontend only)
- The chat "Send" (attach) sheet and the "New story" sheet now use the same floating action sheet as the story menu: rounded option card plus a separate Cancel card, no heading.

## Send photo sheet (frontend only)
- The photo preview sheet now shows a thumbnail with "1 photo", file size and who it goes to, a Change link (back to the attach options), the caption box (personal chats), and two equal Cancel / Send buttons. Enter in the caption box sends.
