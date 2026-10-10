-- Rackgram Notes (Instagram-style). Run once in Supabase Dashboard -> SQL Editor. Additive only.
-- One note per user, max 60 chars, expires after 24h (the app sets expires_at).
-- Visible only to: the owner, and people who share a chat / saved contact with the owner (and no block either way).

create table if not exists public.notes (
  user_id    uuid primary key default auth.uid() references public.profiles(id) on delete cascade,
  body       text not null check (char_length(btrim(body)) between 1 and 60),
  created_at timestamptz not null default now(),
  expires_at timestamptz not null default (now() + interval '24 hours')
);
create index if not exists notes_expires_idx on public.notes (expires_at);

-- security definer = no RLS recursion on messages / blocks / contact_names
create or replace function public.can_see_note(owner uuid)
returns boolean language sql stable security definer set search_path = public as $$
  select owner = auth.uid() or (
    (
      exists (select 1 from public.messages m
              where (m.sender_id = auth.uid() and m.receiver_id = owner)
                 or (m.receiver_id = auth.uid() and m.sender_id = owner))
      or exists (select 1 from public.contact_names c where c.user_id = auth.uid() and c.contact_id = owner)
    )
    and not exists (select 1 from public.blocks b
                    where (b.blocker_id = owner and b.blocked_id = auth.uid())
                       or (b.blocker_id = auth.uid() and b.blocked_id = owner))
  );
$$;

alter table public.notes enable row level security;
drop policy if exists notes_select on public.notes;
drop policy if exists notes_insert on public.notes;
drop policy if exists notes_update on public.notes;
drop policy if exists notes_delete on public.notes;
create policy notes_select on public.notes for select to authenticated using (public.can_see_note(user_id));
create policy notes_insert on public.notes for insert to authenticated with check (user_id = auth.uid());
create policy notes_update on public.notes for update to authenticated using (user_id = auth.uid()) with check (user_id = auth.uid());
create policy notes_delete on public.notes for delete to authenticated using (user_id = auth.uid());

-- realtime (new / changed / deleted notes appear live in the tray)
do $$ begin
  begin alter publication supabase_realtime add table public.notes; exception when duplicate_object then null; end;
end $$;
