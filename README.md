# Optimize — V3 Gaming Layer

Optimize est une PWA d'organisation personnelle : tâches, planning, projets, révisions, objectifs, devoirs, budget, sites, journal, compétences, contacts, inventaire, et couche ludique.

## Nouveautés V3

- QG personnel évolutif.
- Cartes bonus avec raretés : Commun, Rare, Épique, Légendaire, Secret, Céleste.
- Table Supabase `reward_cards` pour ajouter des cartes au fil des mises à jour.
- Compagnons équipables : 2 slots de base, 3e slot avec récompense céleste.
- 6 cartes bonus équipables.
- Gacha gratuit débloqué au niveau 2.
- Boutique gratuite débloquée au niveau 5.
- Tickets comme monnaie interne gratuite.
- Boosts XP : secrets permanents, légendaires saisonniers réactivables avec 10 tickets.
- Saisons générales liées aux périodes de l’année : Winter Rewards, Focus Mode, Spring Upgrade, Creative Summer, New Game+, Build Season, Deep Work.
- Codex avec cartes, badges, récompenses et codes secrets équilibrés.

## Installation GitHub Pages

1. Dézipper le dossier.
2. Envoyer tous les fichiers à la racine du dépôt GitHub : `index.html`, `css`, `js`, `assets`, `supabase`, `manifest.json`, `service-worker.js`, etc.
3. Activer GitHub Pages : `Settings > Pages > Deploy from branch > main > root`.
4. Ouvrir le lien GitHub Pages.

## Configuration Supabase

Dans `js/config.js`, remplacer :

```js
SUPABASE_URL: "https://TON-PROJET.supabase.co",
SUPABASE_ANON_KEY: "COLLE_TA_CLE_ANON_OU_PUBLISHABLE_ICI"
```

par l’URL Supabase et la clé publique `anon` / `publishable`.

Ne jamais mettre de clé `service_role`, `secret` ou `JWT secret` dans GitHub.

## SQL Supabase

Dans Supabase :

1. Aller dans `SQL Editor`.
2. Créer une nouvelle query.
3. Copier tout le contenu de `supabase/schema.sql`.
4. Cliquer sur `Run`.

Le script utilise `create table if not exists` et `alter table add column if not exists`, donc il peut être relancé sans supprimer tes anciennes données.

## PWA

Sur iPhone : ouvrir le site dans Safari, bouton Partage, puis `Ajouter à l’écran d’accueil`.

Sur PC : ouvrir le site avec Chrome/Edge, puis installer l’application depuis la barre d’adresse si proposé.


## V3 — Collection Update

Cette version ajoute une collection plus complète : environ 30 cartes bonus, 20 compagnons, table Supabase `companions`, table `user_companions`, codes secrets équilibrés et gacha plus cohérent.

Important : après upload GitHub, lance `supabase/schema.sql` dans Supabase SQL Editor puis remets tes clés dans `js/config.js`.
