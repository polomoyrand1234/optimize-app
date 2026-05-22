-- Optimize V2 — schéma Supabase complet
-- À lancer dans Supabase > SQL Editor > New query > Run.
-- Important : Authentication > Providers > Email > Confirm email doit être désactivé pour la V1/V2.

create extension if not exists "pgcrypto";

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  username text not null unique,
  created_at timestamptz not null default now()
);

create table if not exists public.tasks (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null,
  category text not null default 'autre',
  due_date date,
  is_day_task boolean not null default false,
  completed boolean not null default false,
  completed_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz
);

create table if not exists public.events (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null,
  category text not null default 'autre',
  color text,
  start timestamptz not null,
  "end" timestamptz not null,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz
);

create table if not exists public.projects (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null,
  status text not null default 'active',
  progress integer not null default 0 check (progress >= 0 and progress <= 100),
  description text,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz
);

create table if not exists public.subjects (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null,
  description text,
  created_at timestamptz not null default now(),
  updated_at timestamptz
);

create table if not exists public.topics (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  subject_id uuid not null references public.subjects(id) on delete cascade,
  title text not null,
  status text not null default 'not_started',
  created_at timestamptz not null default now(),
  updated_at timestamptz
);

create table if not exists public.objectives (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null,
  scope text not null default 'jour',
  priority text not null default 'moyenne',
  status text not null default 'not_started',
  deadline date,
  progress integer not null default 0 check (progress >= 0 and progress <= 100),
  description text,
  created_at timestamptz not null default now(),
  updated_at timestamptz
);

create table if not exists public.homework (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  subject text,
  title text not null,
  due_date date,
  urgency text not null default 'moyenne',
  estimated_time text,
  status text not null default 'todo',
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz
);

create table if not exists public.ideas (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null,
  category text not null default 'autre',
  status text not null default 'brute',
  pinned boolean not null default false,
  content text,
  created_at timestamptz not null default now(),
  updated_at timestamptz
);

create table if not exists public.budget_entries (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null,
  type text not null default 'expense',
  category text not null default 'autre',
  amount numeric not null default 0,
  date date,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz
);

create table if not exists public.deadlines (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null,
  category text not null default 'examen',
  datetime timestamptz,
  importance text not null default 'haute',
  preparation text,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz
);

create table if not exists public.course_followups (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  subject text not null,
  last_lesson text,
  catchup text,
  exercises text,
  understanding text not null default 'moyen',
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz
);

create table if not exists public.documents (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null,
  category text,
  status text not null default 'a_faire',
  deadline date,
  link text,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz
);

create table if not exists public.site_links (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null,
  url text not null,
  category text not null default 'site',
  pinned boolean not null default false,
  description text,
  created_at timestamptz not null default now(),
  updated_at timestamptz
);

create table if not exists public.progress_journal (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  date date,
  category text not null default 'cours',
  mood text not null default 'bien',
  content text,
  created_at timestamptz not null default now(),
  updated_at timestamptz
);

create table if not exists public.purchases (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null,
  category text not null default 'perso',
  estimated_price numeric not null default 0,
  priority text not null default 'moyenne',
  status text not null default 'a_acheter',
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz
);

create table if not exists public.skills (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null,
  category text not null default 'code',
  level text not null default 'debutant',
  progress integer not null default 0 check (progress >= 0 and progress <= 100),
  objective text,
  actions text,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz
);

create table if not exists public.contacts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  role text,
  email text,
  phone text,
  category text not null default 'autre',
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz
);

create table if not exists public.creative_projects (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null,
  type text not null default 'youtube',
  status text not null default 'idee',
  idea text,
  steps text,
  link text,
  last_modified date,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz
);

create table if not exists public.personal_events (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null,
  date date,
  time text,
  location text,
  category text not null default 'perso',
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz
);

create table if not exists public.inventory_items (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  category text not null default 'tech',
  condition text not null default 'bon',
  location text,
  estimated_price numeric not null default 0,
  purchase_date date,
  status text not null default 'utilise',
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz
);


create table if not exists public.game_state (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  tickets integer not null default 0,
  unlocked_rewards jsonb not null default '[]'::jsonb,
  equipped_theme text not null default 'classic',
  equipped_title text not null default 'Apprenti Organisé',
  equipped_animation text not null default 'classic',
  claimed_level integer not null default 1,
  claimed_daily_date text,
  claimed_daily_ids jsonb not null default '[]'::jsonb,
  mission_date text,
  mission_claimed boolean not null default false,
  notifications jsonb not null default '[]'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz
);

alter table public.profiles enable row level security;
drop policy if exists profiles_select_own on public.profiles;
drop policy if exists profiles_insert_own on public.profiles;
drop policy if exists profiles_update_own on public.profiles;
create policy profiles_select_own on public.profiles for select using (auth.uid() = id);
create policy profiles_insert_own on public.profiles for insert with check (auth.uid() = id);
create policy profiles_update_own on public.profiles for update using (auth.uid() = id) with check (auth.uid() = id);

do $$
declare
  t text;
begin
  foreach t in array array[
    'tasks','events','projects','subjects','topics','objectives','homework','ideas','budget_entries','deadlines',
    'course_followups','documents','site_links','progress_journal','purchases','skills','contacts','creative_projects',
    'personal_events','inventory_items','game_state'
  ] loop
    execute format('alter table public.%I enable row level security', t);
    execute format('drop policy if exists %I on public.%I', t || '_select_own', t);
    execute format('drop policy if exists %I on public.%I', t || '_insert_own', t);
    execute format('drop policy if exists %I on public.%I', t || '_update_own', t);
    execute format('drop policy if exists %I on public.%I', t || '_delete_own', t);
    execute format('create policy %I on public.%I for select using (auth.uid() = user_id)', t || '_select_own', t);
    execute format('create policy %I on public.%I for insert with check (auth.uid() = user_id)', t || '_insert_own', t);
    execute format('create policy %I on public.%I for update using (auth.uid() = user_id) with check (auth.uid() = user_id)', t || '_update_own', t);
    execute format('create policy %I on public.%I for delete using (auth.uid() = user_id)', t || '_delete_own', t);
  end loop;
end $$;

-- Optimize V2.5 — extensions gaming avancées
-- Colonnes supplémentaires pour équipement actif, cartes, compagnons, boosts saisonniers et codes secrets.
alter table public.game_state add column if not exists unlocked_cards jsonb not null default '[]'::jsonb;
alter table public.game_state add column if not exists equipped_title_2 text not null default '';
alter table public.game_state add column if not exists equipped_cards jsonb not null default '[]'::jsonb;
alter table public.game_state add column if not exists equipped_companions jsonb not null default '["pet_robot"]'::jsonb;
alter table public.game_state add column if not exists active_legendary_boosts jsonb not null default '{}'::jsonb;
alter table public.game_state add column if not exists used_secret_codes jsonb not null default '[]'::jsonb;

create table if not exists public.reward_cards (
  id text primary key,
  name text not null,
  rarity text not null default 'common',
  category text not null default 'general',
  description text,
  condition_hint text,
  boost_type text default 'global',
  boost_value numeric not null default 0,
  season text not null default 'permanent',
  icon text default '🃏',
  active boolean not null default true,
  unlocks text,
  created_at timestamptz not null default now(),
  updated_at timestamptz
);

insert into public.reward_cards (id, name, rarity, category, description, condition_hint, boost_type, boost_value, season, icon, active, unlocks) values
('card_planning_core','Architecte du Chaos','common','organisation','Créer et modifier son planning.','Utilise souvent le planning.','planning',0,'permanent','🗓️',true,null),
('card_first_steps','Premiers Pas','common','progression','Les débuts dans Optimize.','Crée tes premiers éléments.','global',0,'permanent','👣',true,null),
('card_code_words','Créateur de Sites','rare','tech','Une carte liée au vocabulaire code / web.','Ajoute des idées ou projets avec des mots comme site, code, html, css, github.','tech',2,'permanent','💻',true,null),
('card_creative_studio','Atelier Créatif','rare','creative','Pour les idées YouTube, montage, dessin et création.','Ajoute plusieurs idées créatives.','creative',2,'permanent','🎬',true,null),
('card_deadline_runner','Runner des Deadlines','epic','deadline','Carte de ceux qui affrontent les grosses dates.','Crée plusieurs échéances importantes.','deadline',5,'permanent','⏱️',true,null),
('card_aaa_pattern','Triple A Signal','epic','easter','Un motif étrange est apparu dans tes textes.','Certaines lettres répétées peuvent déclencher cette carte.','global',4,'permanent','🅰️',true,null),
('card_github_gate','Portail GitHub','epic','tech','Tu relies tes sites et ton univers web.','Ajoute plusieurs sites GitHub Pages dans le Hub.','tech',5,'permanent','🌐',true,null),
('card_winter_focus','Winter Focus','legendary','season','Boost saisonnier de discipline.','Carte saisonnière hivernale.','global',10,'winter','❄️',true,null),
('card_summer_creator','Creative Summer','legendary','season','Boost saisonnier de créativité.','Carte saisonnière d’été.','creative',10,'summer','☀️',true,null),
('card_glitch_origin','Glitch Origin','secret','secret','Carte secrète avec boost permanent.','Indice : bugs, 404, glitchs et mots cachés.','global',12,'permanent','🕳️',true,null),
('card_optimize_origin','Optimize Origin','secret','secret','Carte secrète des pionniers.','Elle aime le nom de l’application.','global',10,'permanent','⚡',true,null),
('card_divine_second_title','Second Titre Divin','celestial','celestial','Objet mythique : autorise deux titres actifs.','Extrêmement rare. Peut tomber au gacha avec une chance minuscule.','global',8,'permanent','👑',true,'second_title_slot')
on conflict (id) do update set
  name = excluded.name,
  rarity = excluded.rarity,
  category = excluded.category,
  description = excluded.description,
  condition_hint = excluded.condition_hint,
  boost_type = excluded.boost_type,
  boost_value = excluded.boost_value,
  season = excluded.season,
  icon = excluded.icon,
  active = excluded.active,
  unlocks = excluded.unlocks,
  updated_at = now();

create table if not exists public.user_reward_cards (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  card_id text not null references public.reward_cards(id) on delete cascade,
  source text default 'system',
  unlocked_at timestamptz not null default now(),
  unique(user_id, card_id)
);

alter table public.reward_cards enable row level security;
drop policy if exists reward_cards_select_active on public.reward_cards;
create policy reward_cards_select_active on public.reward_cards for select using (active = true);

alter table public.user_reward_cards enable row level security;
drop policy if exists user_reward_cards_select_own on public.user_reward_cards;
drop policy if exists user_reward_cards_insert_own on public.user_reward_cards;
drop policy if exists user_reward_cards_update_own on public.user_reward_cards;
drop policy if exists user_reward_cards_delete_own on public.user_reward_cards;
create policy user_reward_cards_select_own on public.user_reward_cards for select using (auth.uid() = user_id);
create policy user_reward_cards_insert_own on public.user_reward_cards for insert with check (auth.uid() = user_id);
create policy user_reward_cards_update_own on public.user_reward_cards for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy user_reward_cards_delete_own on public.user_reward_cards for delete using (auth.uid() = user_id);


-- Optimize V3 — Collection Update
-- Cartes plus nombreuses + table compagnons publique pour enrichir le gacha sans refaire tout le site.

insert into public.reward_cards
(id, name, rarity, category, description, condition_hint, boost_type, boost_value, season, icon, unlocks)
values
('card_first_steps','Premiers Pas','common','progression','Les débuts dans Optimize.','Crée tes premiers éléments dans l’application.','global',0,'permanent','👣',null),
('card_planning_core','Architecte du Chaos','common','organisation','Tu commences à transformer le chaos en planning.','Ajoute plusieurs créneaux dans le planning.','planning',0,'permanent','🗓️',null),
('card_checklist_spark','Étincelle Checklist','common','organisation','Les petites tâches deviennent des victoires.','Termine plusieurs tâches.','global',0,'permanent','✅',null),
('card_journal_seed','Graine de Journal','common','progression','Premières traces de progression personnelle.','Ajoute quelques entrées dans le journal.','journal',0,'permanent','🌱',null),
('card_hub_starter','Portail Personnel','common','tech','Ton hub commence à connecter tes sites.','Ajoute un site dans Mes sites.','tech',0,'permanent','🌐',null),
('card_budget_seed','Premiers Crédits','common','budget','Début du suivi budget.','Ajoute quelques lignes de budget.','budget',0,'permanent','💰',null),
('card_doc_keeper','Gardien des Docs','common','admin','Tu gardes tes documents sous contrôle.','Ajoute un document à préparer.','global',0,'permanent','📄',null),
('card_class_tracker','Radar de Cours','common','cours','Tu suis mieux ce que tu vois en cours.','Ajoute un suivi de cours.','study',0,'permanent','📚',null),
('card_code_words','Créateur de Sites','rare','tech','Une carte liée au vocabulaire code / web.','Utilise des mots comme site, code, html, css, github, supabase.','tech',2,'permanent','💻',null),
('card_creative_studio','Atelier Créatif','rare','creative','Tes idées YouTube, montage ou dessin prennent forme.','Ajoute plusieurs idées créatives.','creative',2,'permanent','🎬',null),
('card_revision_engine','Moteur de Révision','rare','study','Les chapitres commencent à être cartographiés.','Ajoute des matières et thèmes de révision.','study',2,'permanent','🧠',null),
('card_calendar_weaver','Tisseur de Semaine','rare','planning','Tu utilises le planning comme une vraie carte.','Ajoute plusieurs créneaux dans la semaine.','planning',2,'permanent','🕸️',null),
('card_social_contact','Réseau Activé','rare','contact','Tes contacts utiles commencent à être centralisés.','Ajoute plusieurs contacts.','global',2,'permanent','📇',null),
('card_inventory_scout','Scout du Matériel','rare','inventory','Tu connais mieux ton matériel.','Ajoute plusieurs objets dans l’inventaire matériel.','global',2,'permanent','🎒',null),
('card_night_shift','Signal Nocturne','rare','easter','Une carte pour ceux qui croisent Optimize tard.','Utilise l’application ou écris une note dans une ambiance nocturne.','global',2,'permanent','🌙',null),
('card_idea_storm','Tempête d’Idées','rare','creative','Ton carnet commence à bouillonner.','Ajoute plusieurs idées dans le carnet.','creative',2,'permanent','🌪️',null),
('card_deadline_runner','Runner des Deadlines','epic','deadline','Tu affrontes les grosses dates au lieu de les fuir.','Crée plusieurs échéances importantes.','deadline',5,'permanent','⏱️',null),
('card_aaa_pattern','Triple A Signal','epic','easter','Un motif étrange est apparu dans tes textes.','Certaines répétitions de lettres peuvent déclencher cette carte.','global',4,'permanent','🅰️',null),
('card_github_gate','Portail GitHub','epic','tech','Tu relies tes sites et ton univers web.','Ajoute plusieurs sites GitHub Pages dans le Hub.','tech',5,'permanent','🧭',null),
('card_quest_master','Maître des Quêtes','epic','objective','Tu avances vraiment dans tes objectifs.','Valide plusieurs objectifs / quêtes.','objective',5,'permanent','🎯',null),
('card_skill_builder','Skill Builder','epic','skills','Tu fais monter tes compétences.','Ajoute et fais progresser plusieurs compétences.','global',5,'permanent','🛠️',null),
('card_project_architect','Architecte de Projets','epic','project','Tes projets prennent une vraie structure.','Crée plusieurs projets et avance-les.','project',5,'permanent','🏗️',null),
('card_winter_focus','Winter Focus','legendary','season','Boost saisonnier de discipline et de calme.','Carte saisonnière hivernale.','global',10,'winter','❄️',null),
('card_summer_creator','Creative Summer','legendary','season','Boost saisonnier de créativité.','Carte saisonnière d’été.','creative',10,'summer','☀️',null),
('card_new_game_plus','New Game+','legendary','season','Nouveau cycle, nouvelles habitudes.','Carte liée aux périodes de nouveau départ.','global',10,'new_game','🎮',null),
('card_deep_work_core','Deep Work Core','legendary','season','Pour les périodes de travail profond.','Carte liée aux phases focus / construction.','objective',10,'deep_work','🧘',null),
('card_glitch_origin','Glitch Origin','secret','secret','Carte secrète avec boost permanent.','Indice : bugs, 404, glitchs et mots cachés.','global',12,'permanent','🕳️',null),
('card_optimize_origin','Optimize Origin','secret','secret','Carte secrète des pionniers.','Elle aime le nom de l’application, mais pas seulement.','global',10,'permanent','⚡',null),
('card_bug_whisperer','Bug Whisperer','secret','secret','Tu transformes les erreurs en progression.','Indice : erreurs, corrections, debug et patience.','tech',10,'permanent','🐞',null),
('card_divine_second_title','Second Titre Divin','celestial','celestial','Objet mythique : autorise deux titres actifs.','Extrêmement rare. Peut tomber au gacha avec une chance minuscule.','global',8,'permanent','👑','second_title_slot')
on conflict (id) do update set
  name = excluded.name,
  rarity = excluded.rarity,
  category = excluded.category,
  description = excluded.description,
  condition_hint = excluded.condition_hint,
  boost_type = excluded.boost_type,
  boost_value = excluded.boost_value,
  season = excluded.season,
  icon = excluded.icon,
  unlocks = excluded.unlocks,
  active = true,
  updated_at = now();

create table if not exists public.companions (
  id text primary key,
  name text not null,
  rarity text not null default 'common',
  description text,
  value text not null,
  icon text default '🤖',
  phrase text,
  price integer not null default 0,
  starter boolean not null default false,
  gacha_only boolean not null default false,
  boost_type text,
  boost_value numeric not null default 0,
  boost_scope text not null default 'equipped',
  unlocks text,
  active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz
);

insert into public.companions
(id, name, rarity, description, value, icon, phrase, price, starter, gacha_only, boost_type, boost_value, boost_scope, unlocks, active)
values
('pet_robot','Robot Optimize','common','Compagnon de base neutre et fiable.','robot','🤖','Je surveille tes missions.',0,true,false,null,0,'equipped',null,true),
('pet_terminal','Terminal vivant','common','Petit compagnon informatique discret.','terminal','💾','Commande prête.',10,false,false,null,0,'equipped',null,true),
('pet_cube','Cube IA','common','Petit cube assistant, simple et efficace.','cube','🧊','Calcul en cours.',12,false,false,null,0,'equipped',null,true),
('pet_drone','Drone de bureau','common','Survole ton QG et repère les tâches.','drone','🚁','Zone scannée.',14,false,false,null,0,'equipped',null,true),
('pet_pixel','Compagnon Pixel','rare','Un petit allié rétro.','pixel','👾','Bip bip, pixel prêt.',26,false,false,null,0,'equipped',null,true),
('pet_holo','Hologramme IA','rare','Assistant visuel futuriste.','holo','🧬','Analyse en cours.',30,false,false,null,0,'equipped',null,true),
('pet_arcade_cat','Chat Arcade','rare','Un compagnon joueur et rapide.','arcade_cat','🐱','Combo productif détecté.',32,false,false,null,0,'equipped',null,true),
('pet_study_owl','Chouette Study','rare','Elle surveille les sessions sérieuses.','study_owl','🦉','Concentration activée.',34,false,false,'study',3,'equipped',null,true),
('pet_pocket_ai','IA de Poche','rare','Assistant miniature pour décisions rapides.','pocket_ai','📱','Je garde les infos utiles.',36,false,false,'global',3,'equipped',null,true),
('pet_ninja','Ninja Tech','epic','Discret, rapide, efficace.','ninja','🥷','Mission silencieuse.',65,false,false,'objective',5,'equipped',null,true),
('pet_dragon','Dragon Digital','epic','Compagnon puissant pour les gros objectifs.','dragon','🐉','On brûle les deadlines.',80,false,false,'objective',7,'equipped',null,true),
('pet_cyber_fox','Renard Cyber','epic','Rusé, rapide, très tech.','cyber_fox','🦊','Plan alternatif trouvé.',72,false,false,'tech',6,'equipped',null,true),
('pet_samurai_bot','Robot Samouraï','epic','Discipline et précision.','samurai_bot','🤖','Un coup, une tâche.',78,false,false,'planning',6,'equipped',null,true),
('pet_neon_specter','Spectre Néon','epic','Présence mystérieuse dans le QG.','neon_specter','👻','Je traverse le chaos.',84,false,false,'global',6,'equipped',null,true),
('pet_oracle','Oracle IA','legendary','Guide légendaire de progression.','oracle','🔮','Je vois ton prochain niveau.',140,false,false,'global',12,'season',null,true),
('pet_quantum_raven','Corbeau Quantique','legendary','Messager des grandes décisions.','quantum_raven','🐦‍⬛','Probabilité favorable.',150,false,false,'tech',12,'season',null,true),
('pet_guardian_qg','Gardien du QG','legendary','Protège ton cockpit personnel.','guardian_qg','🛡️','Base sécurisée.',160,false,false,'global',12,'season',null,true),
('pet_404','Robot 404','secret','Compagnon secret des chasseurs de bugs.','404','❔','Erreur trouvée. XP trouvé.',0,false,true,'tech',12,'permanent',null,true),
('pet_glitch','Glitch Pet','secret','Créature secrète instable.','glitch','🕳️','Je suis un bug utile.',0,false,true,'global',10,'permanent',null,true),
('pet_celestial','Gardien Céleste','celestial','Compagnon mythique avec troisième slot compagnon.','celestial','🌌','Le QG est sous protection divine.',0,false,true,'global',20,'permanent','third_companion_slot',true)
on conflict (id) do update set
  name = excluded.name,
  rarity = excluded.rarity,
  description = excluded.description,
  value = excluded.value,
  icon = excluded.icon,
  phrase = excluded.phrase,
  price = excluded.price,
  starter = excluded.starter,
  gacha_only = excluded.gacha_only,
  boost_type = excluded.boost_type,
  boost_value = excluded.boost_value,
  boost_scope = excluded.boost_scope,
  unlocks = excluded.unlocks,
  active = excluded.active,
  updated_at = now();

create table if not exists public.user_companions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  companion_id text not null references public.companions(id) on delete cascade,
  source text default 'system',
  unlocked_at timestamptz not null default now(),
  unique(user_id, companion_id)
);

alter table public.companions enable row level security;
drop policy if exists companions_select_active on public.companions;
create policy companions_select_active on public.companions for select using (active = true);

alter table public.user_companions enable row level security;
drop policy if exists user_companions_select_own on public.user_companions;
drop policy if exists user_companions_insert_own on public.user_companions;
drop policy if exists user_companions_update_own on public.user_companions;
drop policy if exists user_companions_delete_own on public.user_companions;
create policy user_companions_select_own on public.user_companions for select using (auth.uid() = user_id);
create policy user_companions_insert_own on public.user_companions for insert with check (auth.uid() = user_id);
create policy user_companions_update_own on public.user_companions for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy user_companions_delete_own on public.user_companions for delete using (auth.uid() = user_id);
