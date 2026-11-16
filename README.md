## Important

Français:

Ce dépôt GitHub a uniquement pour but de présenter le code source du jeu. Il ne permet pas d'exécuter le jeu dans les conditions prévues.

Afin d'éviter tout problème futur, les assets du jeu (textures, sons, modèles, etc.) ne sont pas présents dans ce dépôt GitHub.

Si vous essayez d'exécuter le projet directement avec Godot, celui-ci ne fonctionnera donc pas correctement et pourra générer des erreurs.

Une démo jouable sera disponible lorsque le jeu aura atteint un niveau de maturité suffisant. Par la suite, le jeu complet sera commercialisé sur les différentes plateformes prévues.

## Assets

Certains assets (une grande partie) ont été récupéré sur internet auprès d'artistes qui autorisent la réutilisation de leurs assets, j'essaye de créditer le maximum d'artistes qui ont mis à disposition ces assets. En cas d'oublie de ma part n'hésitez pas à me contacter.

## Dépôt privé du projet complet

Ce dépôt public contient le code, mais pas les assets du jeu ni les scènes et
ressources Godot privées. Ces fichiers sont sauvegardés dans un dépôt privé
séparé, utilisé comme copie complète du projet.

Pour synchroniser le dossier actuel vers un checkout local du dépôt privé :

```bash
git clone <URL_DU_DEPOT_PRIVE> ../fear-the-darkness-private
tools/sync-private.sh ../fear-the-darkness-private
```

Après vérification, dans le dépôt privé :

```bash
git add -A
git commit -m "Synchronize complete Godot project"
git push
```

Les dossiers `.git`, `.godot` et `builds` ne sont pas copiés. Le script ne
supprime pas automatiquement les fichiers absents du dépôt public afin d'éviter
une suppression accidentelle d'assets privés.

## Utilisation de l'IA

Dans le cadre de ce projet, étant moi même contre l'utilisation de l'IA générative pour du contenu artistique, cet outil n'a pas été utilisé pour ce cas.

Dans le cadre de ce projet, l'IA a été utilisé comme outil d'apprentissage et d'aide lors de la programmation de certaines features complexe, de correction de scripts, de documentation technique et de génération de tests unitaires ou de tâches répétitives.

Aucune fonctionnalité de ce jeu n'a été et ne sera jamais "vibe codé", chaque fonctionnalité est testé, validé et adapté par moi en cas de génération de script.
