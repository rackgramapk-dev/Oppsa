# v32.17 - Files and Document in the attach panel
- Attach panel now has Files and Document (same plain round grey buttons, no ring). Tapping opens the phone's own file picker.
- Max 15 MB. Bigger file: small white box "File is too large. Max size is 15 MB." for 4 seconds, file is not selected.
- Pick a file, see it with an "Add a caption..." box, send file and caption together. Chat shows a file bubble (name, size, type, download).
- Fix: the v32.16 attach panel never ran (a script error stopped it), so the old list kept showing. The panel and the new Files/Document code now load inside the main module and work.
- Download button saves the file from inside the app, never from the Supabase link. In the installed app it goes straight to Download/Rackgram (no browser download notice, no address). While downloading it shows 'Downloading... 62%', then the icon turns into a tick and the line says 'Saved'. Works in chats, groups and channels.
- Nothing else in the app was changed. Needs 4 new columns on messages and group_messages (file_url, file_name, file_size, file_type) - SQL comes next.

# v32.16 - New attach panel in chats (simple grey, WhatsApp style)
- The paperclip in chats and groups now opens a small bottom panel with round grey buttons: Gallery, Camera, Record video, Video gallery. No colours, labels under each icon, tap outside to close.
- Same rules as before: group photo / video permissions still hide the buttons that are off, and the video limit (3 min) is unchanged. Story chooser is not changed.
- Frontend only, no SQL.

# v32.15 - Fix: group / channel showing "Join" even though you are already a member
- Cause: while groups were reloading (after adding members, coming back to the app, or a weak network), every group was briefly marked "not a member", so the profile showed the Join button. If that reload failed, it stayed like that.
- Now membership is only changed after the new data has fully arrived, a failed or outdated reload no longer touches it, and the profile screen double-checks the member list before showing Join.
- Works the same for groups and channels. Frontend only, no SQL.

# v32.14 - Add member: profile photos in the list
- Add member sheet now shows each person's profile photo (or first letter if no photo) next to the name, both in "People you know" and in search results. Frontend only, no SQL.

# v32.13 - Daily add-member limit now resets every day at 12 AM
- Fixed: the 10 direct adds per group were counted forever, so the limit never came back. Now only adds made today (since 12:00 AM IST) count, and it resets by itself every midnight.
- Add member sheet says "direct adds left today" and the limit message tells you to try again after 12 AM.
- Backend rule was updated directly on the Rackgram project (already applied). No SQL to run.

# v32.12 - Posts with up to 5 photos (swipe left/right, pinch zoom, nothing cropped)
- Profile > Add post: the picker now lets you select up to 5 photos at once (Android shows the numbers 1..5 itself). Picking 1 photo works exactly as before (crop screen, then details).
- Picking 2 to 5 photos opens the new post screen with a swipe preview, a thumbnail strip (X removes a photo, + adds more, up to 5), then the same caption box, the same 4 settings and the same Share button as before. Photos are used whole, no crop step.
- Opened post and Home feed: multi-photo posts swipe left/right with a "1/5" counter and dots below the photo. No arrow buttons. Double-tap to like still works.
- Pinch with two fingers to zoom (up to 4x), drag to look around, pinch back to unzoom. Works in the opened post, Home feed and the new post preview.
- Profile grid: multi-photo posts show a small stack icon at the bottom-right of the tile. Pin and archive icons stay where they were.
- Save to device and Share (send to chat) use the photo you are looking at. Delete removes every photo of the post.
- Captions, likes, comments, pin, archive, hide likes and commenting off are unchanged.
- Needs one SQL: docs/fixes_v32_12.sql adds posts.images (jsonb, 2 to 5 items). Until it is run, picking several photos keeps only the first one and shows a message. Older app versions show the first photo of these posts.

# v32.11 - Video story: full-screen preview with text, filters and sound
- After you pick a video, a full-screen preview opens (not the small bottom sheet). Video plays on loop. X closes, Android back also closes.
- Aa: type text on the video (100 chars), pick a colour, drag it anywhere, tap it to edit.
- Filters: Normal, Warm, Cool, B&W, Vintage, Vivid, Fade, Drama (the same ones as photo stories).
- Sound: speaker button in preview. Muted videos stay muted for viewers. Viewers also get a speaker button in the story viewer.
- Text, filter and mute are saved with the story and shown live on top of the video (the video file itself is not re-encoded).
- Needs one SQL (already applied on the Rackgram project): docs/fixes_v32_11.sql adds stories.meta (jsonb). Older app versions ignore it.

# v32.10 - Video stories (max 40 seconds) - frontend only, no SQL needed
- Story chooser now has: "Record video (max 40 sec)" and "Video from gallery (max 40 sec)".
- Video is checked before posting: formats mp4 / webm / mov / 3gp, up to 50 MB, up to 40 seconds. Longer videos are refused with a message. Preview screen, then "Share to story".
- Viewer plays the video with sound; the top progress bar follows the video length. Holding the screen pauses the video, tap left/right works as before. Stories stay 24 hours.
- Replying / reacting to a video story sends the video in the chat (not a broken photo).
- Highlights: only photo stories can be added for now (videos are skipped in the picker).
- Uses the existing chat-media bucket (already allows video, 50 MB). Nothing changed in the database.

# v32.8 - Who reacted: new list with photos
- Long-press a reaction on a message (chat or group) now opens a WhatsApp-style sheet: tabs on top (All / each emoji with count), profile photo + name + @username + online dot, emoji on the right.
- No photo? The first letter of the name is shown. Profiles that were not loaded yet are fetched, so photos fill in.
- Tap your own row ("Tap to remove") to take your reaction back; the list updates live.
- Channel setting "hide who reacted" still works.

# v32.7 - No more cropped photos, no grey bars
- Home: posts whose size is unknown no longer get forced into a square crop. Photos now show whole, same as the opened post.
- Profile grid: removed the grey bars above/below photos. Tile background now matches the page, so only the photo is visible.

# v32.6 - Home fix, profile photos, theme colours
- FIXED: Home was blank in v32.5 (a function went missing). Restored.
- Home loads faster: placeholder cards while loading, last feed is cached and shown instantly, first two photos load first, prefetch starts earlier.
- Profile grid: same 3-column tiles, but the whole photo is shown (no crop/zoom), same as the opened post.
- Opened post screen and its likes/comments panel now use the app theme colours instead of fixed black.

# v32.5 - Home redesign (Option A)
- Home feed now classic full-width: round avatar + name, edge-to-edge photo, heart / comment / send icons, "N likes", caption, "View all N comments".
- Three-dot button on each post opens the full post.
- Home stories tray: dark ring for new stories, light ring when seen. Your DP with blue plus badge when you have no story; badge hides once your story is live.

# Version tag: the page title (top bar of the viewer) reads 'Rackgram v32.4'. If you do not see it, you are opening an old file.

# What's new (v32.4)
## Bug fixes (found by a full scope scan of the app code)
- Forwarding restriction: in a chat where forwarding is blocked, the multi-select Forward button still worked because the block was only applied to an internal copy of the function. Now the button respects the block.
- Expired account: when a saved account's login expired, the "Accounts" list threw an error instead of refreshing. Fixed.
- Chat list: the 30 second refresh that updates "Created ..." rows never ran (it silently failed every time). Fixed.

# What's new (v32.3)
## Bug fixes
- Home feed: two posts with the exact same time could make one disappear when scrolling. Paging now breaks ties by post id.
- Channel comments: a comment can no longer be attached to a message from another channel. Run docs/fixes_v32_3.sql once (SQL editor). channel_permissions_migration.sql now includes this too and is really safe to re-run (policies are dropped first, realtime add is guarded).
- Notes: removed a confusing sentence from the v31 Home notes.

# What's new (v32) - frontend only, no SQL needed

## New post is now a separate full-screen flow (profile > plus)
Step 1 (crop screen)
- Pick a photo, it opens full screen with a 3x3 grid while you move it.
- Drag to move, pinch (or mouse wheel) to zoom, up to 5x.
- The photo opens in FULL (original shape) by default. Corner button (bottom left of the photo) switches between full photo and square crop (fills the box). Tap again to go back. Very tall or very wide photos are limited to 4:5 and 1.91:1, like Instagram. The button is hidden for photos that are already square.
- Choose another photo, Next.
Step 2 (details screen)
- Photo preview, caption (500 characters with counter).
- Settings: Hide like count, Turn off commenting, Pin to my profile (max 3), Save as archived (only me).
- Cancel and Share (small grey buttons). Back arrow returns to the crop screen and keeps your caption and settings.
- Android back button steps back one screen, same as the arrow.
- Posted photo is exactly what you saw in the crop frame.

Needs SQL later (not in this version): Tag people, Location, Alt text, Who can see, Draft, Share to story.
The Recents gallery grid is not possible in a web page, so the system photo picker is used.

# What's new (v31.2)

## New Home tab (first tab in the bottom bar, Rackgram logo) - frontend only, no SQL needed
- Stories and notes tray on top (same as the chat list): tap a story to watch it, tap a note to reply, tap your plus to add.
- Feed of everyone's posts below, newest first, loads more as you scroll. Tap the photo to open the post, double-tap to like.
- Each card: Like (tap the number to see who liked), Comments, Share. Counts update live.
- Tap a name or photo to open that profile. Tap the Home tab again to refresh.
- Bell (top right): Activity list with who liked your posts, who commented, and who liked your note. A dot shows when there is something new.
- Search icon takes you to chat search.


## v31.2 fix
- Home tab crashed on tap ("homRender is not defined"), so the screen never changed. Fixed by exposing homRender and HM globally (2 lines, no function changed).

## v31.2
- Home no longer shows the chat folder chips (All/Personal/Groups/Channels) or the message-requests row; only stories/notes and posts.
- Home loads faster: people and likes fetched in parallel, feed is pre-loaded in the background after login.
