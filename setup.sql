-- =========================================================
--  Trasloco: tabelle, permessi e spazio foto per Supabase
--  Incolla tutto in Supabase > SQL Editor > New query > Run
--  PRIMA cambia l'email nell'ultima riga con la tua.
-- =========================================================

-- Chi può usare l'app (un indirizzo email per riga)
create table if not exists public.membri (
  email text primary key
);

-- Stanze, checklist e zaino (una sola riga condivisa)
create table if not exists public.config (
  id int primary key default 1 check (id = 1),
  data jsonb not null,
  updated_at timestamptz not null default now()
);

-- Le scatole
create table if not exists public.scatole (
  id uuid primary key default gen_random_uuid(),
  room text not null,
  num int not null,
  contents text not null default '',
  fragile boolean not null default false,
  priority boolean not null default false,
  status text not null default 'prep' check (status in ('prep','chiusa','arrivata','svuotata')),
  photos text[] not null default '{}',
  created_at timestamptz not null default now(),
  unique (room, num)
);

-- È un membro chi ha fatto login con un'email presente in "membri"
create or replace function public.is_member()
returns boolean
language sql stable security definer
set search_path = public
as $$
  select exists (
    select 1 from public.membri
    where lower(email) = lower(coalesce(auth.jwt() ->> 'email', ''))
  );
$$;

alter table public.membri  enable row level security;
alter table public.config  enable row level security;
alter table public.scatole enable row level security;

drop policy if exists "vedo solo me stesso" on public.membri;
create policy "vedo solo me stesso" on public.membri
  for select to authenticated
  using (lower(email) = lower(coalesce(auth.jwt() ->> 'email', '')));

drop policy if exists "solo membri" on public.config;
create policy "solo membri" on public.config
  for all to authenticated
  using (public.is_member()) with check (public.is_member());

drop policy if exists "solo membri" on public.scatole;
create policy "solo membri" on public.scatole
  for all to authenticated
  using (public.is_member()) with check (public.is_member());

-- Aggiornamenti in tempo reale tra telefoni
alter publication supabase_realtime add table public.scatole, public.config;

-- Spazio privato per le foto
insert into storage.buckets (id, name, public)
values ('foto', 'foto', false)
on conflict (id) do nothing;

drop policy if exists "foto solo membri" on storage.objects;
create policy "foto solo membri" on storage.objects
  for all to authenticated
  using (bucket_id = 'foto' and public.is_member())
  with check (bucket_id = 'foto' and public.is_member());

-- >>> CAMBIA QUI con la tua email <<<
insert into public.membri (email) values ('salitadambra@gmail.com')
on conflict do nothing;
