# Fear the Darkness

Jeu d'horreur à la première personne, court et atmosphérique, avec une esthétique
PlayStation 1 : obscurité, lampe torche, exploration et objets-clés.

## En bref

| Genre         | Survival horror                                          |
| ------------- | -------------------------------------------------------- |
| Moteur        | Godot 4.7, Forward Plus, Jolt Physics, GDScript          |
| Cible         | PC — public 16+, amateurs d'horreur indé et de rétro PS1 |
| Sauvegarde    | 4 slots, fichiers `.tres` dans `user://save/`            |
| Scène de test | `playground.tscn`                                        |

## Boucle de jeu

1. Explorer un lieu sombre.
2. Trouver une clé, un objet ou un indice.
3. Ouvrir un passage, avancer.
4. Gérer santé, batterie et inventaire.
5. Sauvegarder sur un ordinateur dédié.

Le joueur ne combat pas : il fuit, se cache et gère ses ressources.

## Contrôles

| Action | Touche |
|---|---|
| Se déplacer | `ZQSD` / `WASD` |
| Courir | `Maj` |
| Sauter | `Espace` |
| Interagir | `E` |
| Inventaire | `I` |
| Lampe torche | `F` |
| Pause | `Échap` |

## Systèmes clés

### Joueur — `entities/player`

- `CharacterBody3D` avec tête orientable, caméra FPS, headbob et FOV dynamique.
- Vitesse : 1,7 m/s en marche, 2,7 m/s en course.
- Santé : 4 PV, gérée par `HealthComponent`.
- Interaction par raycast devant la caméra, avec libellé « Press [E] to interact ».

### Inventaire — `components/inventory`

- `Inv` contient des `InvSlot`, chacun avec un `InvItem` et une quantité.
- 12 slots pour le joueur, 21 pour un coffre.
- Actions : utiliser, jeter, transférer entre joueur et coffre.
- Les objets s'empilent jusqu'à leur `max_amount`.

Objets actuels : clé, kit de soin (+4 PV), poignée de porte, lampe torche.

### Interaction — `props/`

Chaque prop expose `interact(user)` :

- **Porte** : ouverture animée, verrouillée par clé, poignée ou blocage.
- **Coffre** : ouvre l'interface de transfert d'objets.
- **Radio** : allume et éteint un son 3D.
- **Trappe** : confirmation puis changement de scène.
- **Ordinateur** : ouvre l'interface de sauvegarde.

### Ennemi — `entities/enemies/wrapper`

- Suit le joueur avec `NavigationAgent3D`.
- Détecte à 10 m, attaque à 2 m, touche jusqu'à 3,5 m.
- Inflige 1 dégât, recharge d'1 s, se déplace à 2 m/s.
- Présent uniquement dans `playground.tscn` pour l'instant.

### Sauvegarde — `auto_load/save`

- 4 slots : `user://save/save_slot_<n>.tres`.
- Enregistre : PV, position, scène courante, état des portes, objets ramassés,
  inventaires joueur et coffre, temps de jeu.
- Sauvegarde manuelle depuis l'ordinateur ou l'écran dédié.

### UI et menus — `ui/`

- Menu principal : nouvelle partie, charger, options, quitter.
- Pause : reprendre, options, retour au menu, quitter.
- Inventaire : grille de 12 slots avec menu contextuel.
- HUD : réticule, texte d'interaction, messages narratifs, flash de dégât, santé.

### Rendu et audio

- Brouillard dense, nuit, textures en filtre « nearest ».
- Shader `overlay.gdshader` : pixellisation de l'écran (facteur 4).
- Shader `save_ui.gdshader` : effet CRT sur l'interface de sauvegarde.
- Bus audio : `Master`, `SFX`, `Music` — uniquement des effets pour l'instant.

## Architecture

```
addons/       GUT, Proton Scatter, Stairs+, PSX Visuals, Debug Draw 3D
assets/       Sources : audio, polices, props, items, ennemis, niveaux, UI
auto_load/    Singletons globaux
components/   Briques réutilisables : santé, inventaire, volume, proxy
data/         Ressource de sauvegarde
entities/     Joueur et ennemis (scènes et scripts)
items/        Un dossier par objet : scène, ressource, script
levels/       Niveaux et pièces
props/        Un dossier par prop : scène, script
shaders/      Overlay PS1 et CRT
tests/        Tests unitaires GUT
ui/           HUD, inventaires, menus
```

Les fichiers sources vivent dans `assets/`, organisés par prop, objet, ennemi ou
niveau. Les scènes et scripts restent dans `props/`, `items/`, `ui/`, `levels/`
et `entities/`. `assets/props/_library/` contient les textures de props non
rattachées à un prop précis.

### Autoloads

| Nom | Rôle |
|---|---|
| `SoundPlayer` | Sons d'interface |
| `SaveManager` | Sauvegarde et chargement |
| `ConfirmMenuUi` | Boîte de confirmation |
| `PlayTimeTracker` | Temps de jeu |
| `ChestInventoryUi` | Interface de coffre |
| `InvActionUi` | Menu contextuel d'inventaire |
| `PauseGame` | Pause globale |

### Groupes

`player`, `gui`, `player_inv_ui`, `chest_inv_ui`, `chest`, `doors`, `items`,
`pause_menu_ui`.

### Classes

`Player`, `HealthComponent`, `Inv`, `InvSlot`, `InvItem`, `MedKit`, `Door`,
`Wrapper`, `SaveDataResource`, `SaveSlotsDisplay`.

### Niveaux

```
main_menu.tscn
└── flat_forest.tscn     forêt de nuit, feu de camp, tente, radio
	└── level1.tscn      couloirs, escalier, appartement, salle sécurisée
```

La trappe de la forêt mène au niveau 1. Les pièces du niveau sont des scènes
séparées dans `levels/rooms/`.

## Conventions

| Élément                | Convention        | Exemple            |
| ---------------------- | ----------------- | ------------------ |
| Dossiers et fichiers   | `snake_case`      | `save_manager.gd`  |
| Classes                | `PascalCase`      | `SaveDataResource` |
| Nœuds                  | `PascalCase`      | `DoorFrame`        |
| Variables et fonctions | `snake_case`      | `health_component` |
| Constantes             | `SCREAMING_SNAKE` | `MAX_SAVE_SLOTS`   |
| Signaux                | `snake_case`      | `health_changed`   |
| Groupes                | `snake_case`      | `player_inv_ui`    |

- Un dossier par prop/item dans `assets/`, `props/` et `items/`.
- Les dossiers de `props/` et `items/` miroitent ceux de `assets/`.
- Les scènes et scripts ne contiennent pas de binaires.
- Commentaires en français, textes de jeu en anglais.
- Les valeurs d'équilibrage sont en constantes ou `@export` en haut des scripts.

## Bugs connus

- `main.tscn` pointe vers une scène supprimée : ne pas l'utiliser.
- Taille des coffres incohérente : 21 slots dans l'UI, 24 dans la sauvegarde.
- `items/door_knob/door_knob.tres` utilise le script `MedKit` au lieu d'un item d'énigme.
- Batterie de la lampe non sauvegardée et impossible à recharger.
- Les clés ne sont pas consommées à l'ouverture d'une porte.
- Mort du joueur : `queue_free()` sans écran de game over.
- Onglets Display et Controls des options non implémentés.
- Bouton « Save » des options sans effet.
- Wrapper absent des niveaux jouables.
- Pas de musique ni d'ambiance continue.
- Le joueur reste bloqué dans l'armoire si il la ferme en étant collé au portes en sautant

## Tests

- Framework GUT (`addons/gut`).
- Un seul fichier : `tests/unit/items/test_medkit.gd`.
- Cas couverts : soin sans `HealthComponent`, PV pleins, PV incomplets.

## Lancer le projet

1. Installer Godot 4.7.
2. Ouvrir `project.godot`.
3. Vérifier que le dossier `assets/` est présent : il est exclu du dépôt Git.
4. Lancer `F5` — le menu principal s'ouvre.
