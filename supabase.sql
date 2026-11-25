-- ALT9 Game Showcase: 좋아요 · 댓글 · 설치 수 저장소
-- Supabase 대시보드 → SQL Editor에 전체를 붙여 넣고 Run 하세요. (여러 번 실행해도 안전합니다)

create table if not exists public.likes (
  project_id text not null check (char_length(project_id) <= 40),
  device_id  text not null check (char_length(device_id) between 8 and 64),
  created_at timestamptz not null default now(),
  primary key (project_id, device_id)
);

create table if not exists public.comments (
  id         bigint generated always as identity primary key,
  project_id text not null check (char_length(project_id) <= 40),
  name       text not null check (char_length(name) between 1 and 20),
  body       text not null check (char_length(body) between 1 and 500),
  created_at timestamptz not null default now()
);
create index if not exists comments_project_idx on public.comments (project_id, created_at desc);

create table if not exists public.installs (
  id         bigint generated always as identity primary key,
  project_id text not null check (char_length(project_id) <= 40),
  platform   text not null check (platform in ('windows', 'android', 'web')),
  created_at timestamptz not null default now()
);
create index if not exists installs_project_idx on public.installs (project_id);

-- 방문자(anon)가 할 수 있는 일을 아래로만 제한
alter table public.likes    enable row level security;
alter table public.comments enable row level security;
alter table public.installs enable row level security;

grant usage on schema public to anon;
grant select, insert on public.comments to anon;
grant insert on public.installs to anon;

drop policy if exists "comments read"   on public.comments;
drop policy if exists "comments write"  on public.comments;
drop policy if exists "installs write"  on public.installs;
create policy "comments read"  on public.comments for select to anon using (true);
create policy "comments write" on public.comments for insert to anon with check (true);
create policy "installs write" on public.installs for insert to anon with check (true);

-- 좋아요는 이 함수로만 켜고 끔 (기기당 1번)
create or replace function public.toggle_like(p_project text, p_device text)
returns boolean language plpgsql security definer set search_path = public as $$
begin
  delete from likes where project_id = p_project and device_id = p_device;
  if found then return false; end if;
  insert into likes (project_id, device_id) values (p_project, p_device);
  return true;
end $$;
revoke all on function public.toggle_like(text, text) from public;
grant execute on function public.toggle_like(text, text) to anon;

-- 프로젝트별 합계 (개별 기록은 숨기고 숫자만 공개)
create or replace view public.project_stats as
select project_id,
       sum(likes)::int as likes, sum(comments)::int as comments, sum(installs)::int as installs
from (
  select project_id, count(*) as likes, 0 as comments, 0 as installs from public.likes group by 1
  union all select project_id, 0, count(*), 0 from public.comments group by 1
  union all select project_id, 0, 0, count(*) from public.installs group by 1
) t group by project_id;
grant select on public.project_stats to anon;
