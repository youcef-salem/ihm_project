# Mizaniya

**Mizaniya** (ميزانية, « budget ») est un gestionnaire de budget simple et hors
ligne construit avec Flutter. Il vous aide à enregistrer vos dépenses et vos
revenus, à suivre plusieurs portefeuilles et à comprendre où va votre argent
chaque mois.

L'interface est conçue autour des principes d'interaction humain-machine
(Bastien & Scapin) : guidage clair, faible charge de travail, contrôle
explicite, prévention des erreurs et cohérence. Voir [`CRITERIA.md`](CRITERIA.md)
pour la correspondance complète entre critères et fonctionnalités.

## Fonctionnalités

- **Tableau de bord** — solde total de tous les portefeuilles, revenus et
  dépenses du mois, graphique en anneau des dépenses par catégorie, transactions
  récentes et carte mettant en évidence les dépenses inhabituellement élevées.
- **Transactions** — regroupées par date, recherchables par titre ou catégorie,
  filtrables par revenus/dépenses, suppression par glissement avec **Annuler**.
- **Portefeuilles** — suivi des comptes espèces, bancaires, carte et épargne,
  avec soldes individuels et total combiné.
- **Ajouter une transaction** — bascule dépense/revenu, validation en ligne,
  raccourcis de montant (+500, +1000, +2000, +5000), choix de la catégorie et du
  portefeuille, description optionnelle et sélecteur de date qui refuse les
  dates futures.
- **Garde-fous intelligents** — avertissement en direct lorsqu'une dépense
  dépasse le solde du portefeuille sélectionné, boîte de confirmation avant un
  découvert et repérage automatique des dépenses supérieures au double de votre
  moyenne pour la catégorie.
- **Personnalisation** — thème clair, sombre ou système.
- **Localisation** — anglais, français et arabe avec disposition de droite à
  gauche automatique. L'application démarre en français par défaut.
- **Contexte algérien** — montants formatés en DA (dinar) avec séparation des
  milliers, et types de portefeuilles adaptés aux usages locaux (espèces, compte
  CCP, carte).

## Stack technique

- [Flutter](https://flutter.dev/) (SDK Dart `^3.10.0`)
- [Riverpod](https://riverpod.dev/) pour la gestion d'état
- [flutter_localizations](https://docs.flutter.dev/ui/accessibility-and-localization/internationalization)
  + [intl](https://pub.dev/packages/intl) pour les traductions et le formatage
  des dates et des montants

Il n'y a **aucun backend**. Toutes les données vivent dans l'état en mémoire de
l'application et sont initialisées avec des transactions et des portefeuilles
d'exemple au lancement : les modifications sont donc réinitialisées au
redémarrage.

## Démarrage

### Prérequis

- SDK Flutter installé (`flutter --version`)
- Une plateforme cible : Android, iOS, web, Windows, macOS ou Linux

### Installation et exécution

```bash
flutter pub get
flutter run
```

Pour choisir un appareil spécifique :

```bash
flutter devices
flutter run -d <device-id>
```

### Lancer les tests

```bash
flutter test
```

### Analyse statique

```bash
flutter analyze
```

## Localisation

L'application prend en charge l'anglais, le français et l'arabe. Toutes les
chaînes visibles par l'utilisateur se trouvent dans :

- `lib/l10n/app_en.arb` (modèle)
- `lib/l10n/app_fr.arb`
- `lib/l10n/app_ar.arb`

Modifiez ces fichiers pour changer les traductions, puis régénérez les bindings
avec :

```bash
flutter gen-l10n
```

Ajoutez les nouvelles clés d'abord dans le modèle anglais, puis copiez-les dans
les fichiers français et arabe. L'arabe s'affiche automatiquement de droite à
gauche grâce aux délégués de localisation de Flutter. Les utilisateurs peuvent
changer la langue depuis les **Paramètres**.

## Structure du projet

```text
lib/
├── main.dart                  # Point d'entrée (Riverpod ProviderScope)
├── app.dart                   # MaterialApp : thème, locale, shell
├── core/                      # Helpers partagés
│   ├── categories.dart        # Catégories dépense/revenu + icônes/couleurs
│   ├── format.dart            # Montants, dates et analyse des saisies
│   ├── l10n.dart              # Extensions de localisation
│   ├── theme.dart             # Thèmes clair/sombre
│   └── wallet_kinds.dart      # Icônes et libellés des types de portefeuille
├── data/                      # Modèles + calculs purs (sans backend)
│   ├── models/                # Transaction, Wallet
│   └── calculations/          # Résumé, soldes, filtrage, dépenses inhabituelles
├── l10n/                      # Fichiers .arb + bindings générés
├── state/                     # Notifiers Riverpod + données d'exemple en mémoire
└── ui/
    ├── shell/                 # Coque avec navigation inférieure
    ├── screens/               # Tableau de bord, Transactions, Portefeuilles, Ajout, Paramètres
    └── widgets/               # Cartes, tuiles, graphiques, états vides réutilisables
```

La couche `data/` ne contient que des fonctions pures ; les notifiers de
`state/` détiennent l'état mutable de l'application et lui délèguent tous les
calculs.

## Modèle de données

- **Portefeuille (`Wallet`)** — `id`, `name`, `kind` (`cash`, `bank`, `card`,
  `savings`) et `initialBalance`.
- **Transaction** — `id`, `title`, `amount` positif, `type`
  (`expense`/`income`), `categoryId`, `walletId`, `date`, et un indicateur
  `isUnusual` calculé une seule fois à la saisie.
- **Solde** — calculé comme `initialBalance + revenus − dépenses` par
  portefeuille.

## Licence

Ce projet a été réalisé à des fins académiques et ne dispose pas encore de
fichier de licence.
