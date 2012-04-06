# Ruby workshop
*un endroit où j'apprend le Ruby*  
Ici, se trouvent mes projets pour me familiariser avec Ruby, ainsi qu'avec les balises HTML5 et le CSS3.  
Pour l'instant, rien de bien exploitable :)

## tic tac toe
### Objectifs :
Réaliser un jeu de "morpions" possédant une ia.  
L'interface doit être effectuée via une balise <canvas>
#### moteur de jeu :
Développée en Ruby pur, il est accessible via la classe *Party* l'IA e 4 méthodes doivent être accessibles pour jouer :

1. **initialize(ia)** : Permet de préparer la partie, le paramètre doit être le caractère 'x' ou 'o', indiquant ainsi au moteur quel symbole possède l'IA
2. **ia_start()** : Si l'IA débute la partie, cette méthode lance la résolution du premier coup. Le retour de cette méthode est le plateau de jeu (cf partie suivante)
3. **player_start(move)** : Indique au moteur que le joueur débute la partie avec le coup *move*. le paramètre doit être un tableau comportant les coordonnées du coup, ainsi que le symbole du joueur (par exemple : ['b','1','o']
4. **party_state** : retourne l'état de la partie, l'état peut être : "none" (partie en cour),"player" (le joueur a gagné),"ia" (l'ia a gagné),"draw" (match nul)

