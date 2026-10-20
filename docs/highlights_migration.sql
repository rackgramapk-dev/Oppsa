-- Highlights (already applied to the Rackgram Supabase project as migration "create_highlights")
create table public.highlights (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references public.profiles(id) on delete cascade,
  title text not null check (char_length(btrim(title)) between 1 and 24),
  cover_url text,
  created_at timestamptz not null default now()
);
create index highlights_user_created_idx on public.highlights (user_id, created_at);

create table public.highlight_items (
  id uuid primary key default gen_random_uuid(),
  highlight_id uuid not null references public.highlights(id) on delete cascade,
  user_id uuid not null default auth.uid() references public.profiles(id) on delete cascade,
  image_url text not null,
  story_created_at timestamptz,
  created_at timestamptz not null default now()
);
create index highlight_items_hl_created_idx on public.highlight_items (highlight_id, created_at);
create index highlight_items_user_idx on public.highlight_items (user_id);

alter table public.highlights enable row level security;
alter table public.highlight_items enable row level security;

create policy highlights_select on public.highlights for select to authenticated
  using (user_id = (select auth.uid()) or not public.blocked_either(user_id));
create policy highlights_insert on public.highlights for insert to authenticated
  with check (user_id = (select auth.uid()));
create policy highlights_update on public.highlights for update to authenticated
  using (user_id = (select auth.uid())) with check (user_id = (select auth.uid()));
create policy highlights_delete on public.highlights for delete to authenticated
  using (user_id = (select auth.uid()));

create policy highlight_items_select on public.highlight_items for select to authenticated
  using (user_id = (select auth.uid()) or not public.blocked_either(user_id));
create policy highlight_items_insert on public.highlight_items for insert to authenticated
  with check (
    user_id = (select auth.uid())
    and exists (select 1 from public.highlights h where h.id = highlight_id and h.user_id = (select auth.uid()))
  );
create policy highlight_items_delete on public.highlight_items for delete to authenticated
  using (user_id = (select auth.uid()));
