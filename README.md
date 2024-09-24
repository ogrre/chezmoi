# README.md

## Introduction

Ce dépôt utilise [chezmoi](https://www.chezmoi.io/) pour gérer la configuration des fichiers sur plusieurs machines. Chezmoi permet de centraliser, gérer et synchroniser tes dotfiles de manière sécurisée et efficace.

## Prérequis

- **chezmoi** doit être installé sur ta machine.  
  Pour l'installer, exécute la commande suivante :
  ```bash
  sh -c "$(curl -fsLS get.chezmoi.io)"
  ```

## Initialisation du dépôt avec chezmoi

1. Cloner ton dépôt git contenant tes dotfiles sur ta machine locale.

   ```bash
   git clone <url-du-depot> ~/.local/share/chezmoi
   cd ~/.local/share/chezmoi
   ```

2. Initialiser chezmoi pour utiliser les fichiers du dépôt.

   ```bash
   chezmoi init --apply
   ```

## Ajouter un fichier à chezmoi

1. Crée un fichier ou modifie un fichier existant dans ton dossier personnel (ex: `~/.bashrc`, `~/.vimrc`).

2. Ajoute ce fichier à chezmoi :

   ```bash
   chezmoi add ~/.bashrc
   ```

3. Vérifie les modifications :

   ```bash
   chezmoi diff
   ```

## Appliquer les modifications à ta machine

Pour que les changements soient pris en compte sur ta machine, applique les fichiers chezmoi :

```bash
chezmoi apply
```

## Modifier un fichier géré par chezmoi

1. Modifie un fichier existant dans ton répertoire personnel.

2. Ajoute ou mets à jour les changements dans chezmoi :

   ```bash
   chezmoi add ~/.vimrc
   ```

3. Applique les modifications si nécessaire :

   ```bash
   chezmoi apply
   ```

## Envoyer les modifications à ton dépôt git

1. Récupère les changements dans ton dépôt local chezmoi :

   ```bash
   cd ~/.local/share/chezmoi
   ```

2. Vérifie l'état des modifications :

   ```bash
   git status
   ```

3. Ajoute les fichiers modifiés :

   ```bash
   git add .
   ```

4. Commit les modifications :

   ```bash
   git commit -m "Mise à jour des fichiers de configuration"
   ```

5. Pousse les changements vers le dépôt distant :

   ```bash
   git push origin main
   ```

## Récupérer les fichiers sur une autre machine

1. Sur une nouvelle machine, installe `chezmoi` et initialise-le avec ton dépôt distant :

   ```bash
   chezmoi init <url-du-depot>
   ```

2. Applique les fichiers pour les installer sur la nouvelle machine :

   ```bash
   chezmoi apply
   ```

## Documentation supplémentaire

Pour plus de détails, consulte la [documentation officielle](https://www.chezmoi.io/docs/).
