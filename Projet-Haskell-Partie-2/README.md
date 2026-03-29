# Projet-Haskell-Partie-2

L’histoire
Un groupe d’enfants qui joue à l’extérieur est appelé à rentrer à la maison par leur père. Les enfants
se réunissent au tour de lui. Comme souvent, quelques enfants se sont salis. Certaines ont même
de la boue sur leurs visages. Chaque enfant peut voir le visage des autres enfants, mais ne peut pas
voir son propre visage. Tout cela est connaissance commune, et les enfants sont, évidement, des
logiciens parfaits. Le père maintenant leur dit : « Au moins un parmi vous a le visage sale. » Et
ensuite il dit, « Celui qui sait si son propre visage est sale, fait un pas en avant. » Si personne ne
fait un pas en avant, le père répète la réquisition. Après la répétition de cette réquisition plusieurs
fois, tous le enfants sales font un pas en avant.
Ceci est un scénario intrigant. Pourquoi les enfants ne font pas un pas en avant tout de suite ? Pourquoi
ils le font après un certain nombre de réquisitions du père ? Ce comportement vient du fait que les enfants,
qui sont des logiciens parfaits, ont raisonné logiquement sur les informations reçues. Pour mieux comprendre
comment ils ont raisonné, nous allons analyser un problème plus simple.
Problème 1. Alice et Bob viennent de jouer à l’extérieur. Bob a de la boue sur son visage. Alice
a le visage propre. Chacun d’eux peut voir le visage de l’autre, mais ne peut pas voir son propre
visage. Leur père maintenant leur dit : « Au moins un parmi vous a le visage sale. » Bob part laver
son visage sans même pas regarder le miroir, car il sait que son visage est sale. Comment a-t-il
conclu cela ?
Ici, la réponse est plus facile. Le père a dit à Alice et Bob qu’un des deux était sale. Bob peut voir le visage
d’Alice, qui est propre. Donc, il a conclu que son propre visage est sale. Bien sûr, nous faisons l’hypothèse que
les deux enfants sont des logiciens parfaits et que leur père dit toujours la vérité.
Nous pouvons représenter le problème 1 avec un graphe, comme dans les figures ci-dessous. (Les prochains
paragraphes expliquent les figures.)
01 11
00 10a
a
b b
Père : « Au moins un parmi
vous a le visage sale. »
=⇒
01 11
10
a
b
Bob se lave le visage
sans même pas
regarder le miroir.
=⇒
01
10
Concentrons nous d’abord sur le graphe à gauche. Les sommets, libellés par des nombres binaires, repré-
sentent les mondes possibles. Les nombres binaires 00, 01, 10 et 11 représentent la valeur de vérité des deux
propositions qui nous intéressent. Dans chaque nombre binaire :
— le premier chiffre représente la valeur de vérité de la proposition « Le visage d’Alice est sale. » ;
— le deuxième chiffre représente la valeur de vérité de la proposition « Le visage de Bob est sale. ».
Donc, dans le monde possible 00, les deux enfants sont propres, et dans le monde possible 11 les deux enfants
sont sales. Le monde possible dont le label est souligné est le monde réel, c.-à-d., le monde où le visage d’Alice
est propre et celui de Bob est sale.
Les arêtes représentent l’incertitude des enfants. Par exemple, les deux sommets 01 et 11 sont liées par
une arête libellé a. Cela veut dire qu’Alice ne peut pas distinguer entre les mondes 01 et 11. Alice peut voir
que le visage de Bob est sale, mais elle ne peut pas voir son propre visage. Donc, elle ne sais pas si son visage
est propre ou sale. Pour Bob, la situation est analogue. Il ne peut pas voir son visage, mais il peut voir celle
d’Alice. Donc, il ne peut pas distinguer entre les mondes 00 et 01.
Maintenant, nous pouvons nous demander pourquoi le monde 10, qui représente le cas où le visage d’Alice
est sale et celui de Bob est propre, apparaît dans le graphe. Pour comprendre cela, il faut pousser la réflexion
un peu plus loin et se demander ce que pense Alice à propos de ce que pense Bob, et vice-versa. Notons que,
par exemple, Bob n’est pas sûr dans quelle monde possible il est vraiment. De son point de vue, il peut être
1
dans 01 ou bien dans 00. Dans le cas où il serait dans 00, Alice ne serait pas capable de distinguer entre 00
et 10. Donc, pour Bob, Alice peut imaginer qu’elle est dans 10. Donc, ce monde possible doit apparaître dans
le graphe. De même manière, comme Alice ne sait pas si elle est dans 01 ou bien dans 11, il faut y avoir une
arrête libellé b entre 11 et 10.
Maintenant, quand le père des enfants annonce « Au moins un parmi vous a le visage sale. », les deux
enfants découvrent que le monde 00 n’est pas possible. Plus que cela, chacun sait que l’autre enfant le sait
aussi. En effet, ceci devient connaissance commune. C’est la raison pour laquelle, après cet annonce, nous
devons supprimer le monde 00 du graphe. Ce que nous amène au graphe du milieu. Dans ce graphe, Alice ne
peut toujours pas distinguer entre 00 et 11, et Bob ne peut pas distinguer entre 10 et 11.
La dernière chose qui se passe dans l’histoire est que Bob lave son visage sans même pas regarder le miroir.
Cela veut dire qu’il sait qu’il a le visage sale. Donc, Alice apprend qu’elle n’a pas le visage sale, car elle apprend
dans quel monde possible ils sont dès le départ. S’ils était dans le monde 10, Bob n’aurait pas pu savoir que
son visage est sale car, pour lui, le monde 10 serait toujours possible. La même chose pour le monde 11. Le
seul cas où il sait que son visage est salle, est le monde possible 01
