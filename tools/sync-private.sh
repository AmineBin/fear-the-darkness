#!/usr/bin/env bash

set -euo pipefail

if [[ $# -ne 1 ]]; then
	cat >&2 <<'EOF'
Usage: tools/sync-private.sh /chemin/vers/le/checkout-prive

Le checkout privé doit déjà être un dépôt Git cloné ou initialisé.
EOF
	exit 1
fi

public_root="$(git -C "$(dirname "$0")/.." rev-parse --show-toplevel)"
private_root="$(realpath "$1")"

if [[ "$public_root" == "$private_root" ]]; then
	echo "Erreur: le checkout privé doit être différent du dépôt public." >&2
	exit 1
fi

if [[ ! -d "$private_root/.git" && ! -f "$private_root/.git" ]]; then
	echo "Erreur: '$private_root' n'est pas un checkout Git." >&2
	exit 1
fi

echo "Synchronisation du projet complet vers: $private_root"
echo "Les dossiers .git, .godot et builds sont exclus."

rsync -a --human-readable \
	--exclude '.git/' \
	--exclude '.godot/' \
	--exclude 'builds/' \
	--exclude '.gitignore' \
	"$public_root/" "$private_root/"

if [[ ! -e "$private_root/.gitignore" ]]; then
	cat > "$private_root/.gitignore" <<'EOF'
# Fichiers générés par Godot
.godot/
/android/
/export.cfg
/export_presets.cfg
/builds/
EOF
	echo "Création d'un .gitignore adapté au dépôt privé."
fi

cat <<EOF

Synchronisation terminée.
Vérifie les fichiers avant de les committer dans le dépôt privé:

  cd "$private_root"
  git status
  git add -A
  git commit -m "Synchronize complete Godot project"
  git push

Note: ce script ne supprime pas les fichiers supprimés du checkout public.
Supprime-les manuellement dans le dépôt privé après vérification.
EOF
