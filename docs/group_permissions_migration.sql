-- Group permissions (v29). ALREADY APPLIED to the Rackgram Supabase project as migration "group_permissions_v1".
-- Adds: can_photo, can_video, can_voice, members_can_add (groups); per-type media check on group_messages inserts;
-- server-side slow mode (slow_secs) and link block (allow_links) for groups; members_can_add guard on group_members inserts.
-- Safe to keep for reference. Existing groups keep their old behaviour (media columns copied from can_media; members_can_add = true).
alter table public.groups
  add column if not exists can_photo boolean not null default true,
  add column if not exists can_video boolean not null default true,
  add column if not exists can_voice boolean not null default true,
  add column if not exists members_can_add boolean not null default true;
update public.groups set can_photo = false, can_video = false, can_voice = false where kind = 'group' and can_media = false;
grant select (can_photo, can_video, can_voice, members_can_add, allow_links, can_forward, slow_secs) on public.groups to authenticated;
grant update (can_photo, can_video, can_voice, members_can_add, allow_links, can_forward, slow_secs, join_approval) on public.groups to authenticated;
-- plus: private.groups_update_guard (new columns need the "perm" right), private.can_post_msg, policy gmsg_insert,
-- private.group_msg_limits + trigger zz_group_msg_limits (links, slow mode), private.gm_insert_guard (members_can_add).
