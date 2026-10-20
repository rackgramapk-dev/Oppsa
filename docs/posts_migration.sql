-- Posts (3x3 grid on the profile; photo + caption). Photos are stored in the existing avatars bucket as <uid>/post-*.jpg
create table public.posts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references public.profiles(id) on delete cascade,
  image_url text not null,
  caption text check (caption is null or char_length(caption) <= 500),
  created_at timestamptz not null default now()
);
create index posts_user_created_idx on public.posts (user_id, created_at desc);

alter table public.posts enable row level security;

create policy posts_select on public.posts for select to authenticated
  using (user_id = (select auth.uid()) or not public.blocked_either(user_id));
create policy posts_insert on public.posts for insert to authenticated
  with check (user_id = (select auth.uid()));
create policy posts_update on public.posts for update to authenticated
  using (user_id = (select auth.uid())) with check (user_id = (select auth.uid()));
create policy posts_delete on public.posts for delete to authenticated
  using (user_id = (select auth.uid()));
