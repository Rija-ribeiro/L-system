Ce programme permet de générer des fractales [L-système](https://fr.wikipedia.org/wiki/L-Syst%C3%A8me) avec des angles de 90°.

Pour l'utiliser, on execute le programme avec deux arguments :
  - le chemin vers un fichier fractal (voir une explication détaillé plus bas).
  - le nombre de génération attendu

exemple linux/macOS et windows :
```bash
./fractalReader /chemin/vers/le/fichier 10
.\fractalReader.exe C:\chemin\vers\le\fichier 10
```


# Comment rédiger les fichiers fractal.

Un fichier fractal décrit des actions qui seront executées afin de dessiner la fractale recherchée.

il existe des actions élémentaires qui sont déjà implémentées :

| Symbole  | Signification  |
| ------------ | ------------ |
| L | tourne le curseur à gauche |
| R | tourne le curseur à droite |
| M | fait avancer le curseur  |
| P | colorie le pixel actuellement survolé |
| F | est équivalent à PM |

Mais pour créer de véritables fractales, il faut définir de nouvelles actions, par exemple A et B, composées de celles ci-dessus.

Sur la toute première ligne du fichier, il faut inscrire le nom de toutes les actions que nous allons définir. Ici A et B.
```
AB
```

> [!CAUTION]
> Les noms des actions doivent faire exactement **un** caractère.

Ensuite, il faut définir les actions en respectant le format suivant :
**Nom_Approximation\_Formule De Récurence**

Exemple :
```
A_F_ALBL
B_F_RARB
```
Dans l'exemple ci-dessus, nous avons défini que A se transformera en ALBL à chaque génération et s'approximera en F.
Et que B se transformera en RARB à chaque génération et s'approximera en F.

> [!CAUTION]
> L'action qui va être executée est la première inscrite sur la première ligne

------------

> [!NOTE]
> une ligne sera considérée comme un commentaire si elle ne contient aucun \_ ou si elle contient un #.
