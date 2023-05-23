# Week00

#### _Conoscere l'interfaccia di godot ed i suoi nodi_ 

## Contents

* [Approach](#approach)
* [Scripting](#scripting)
* [Bonus](#bonus)
* [Notes](#notes)

### Approach

> #### Attenzione
> 
> Questo progetto é stato fatto in **Godot 4.0.3**, quindi eseguire il progetto su versioni precedenti (eg. **Godot 3.X**) potrebbe non funzionare

##### Main Node

L'engine di Godot si basa sulla parentela di oggetti definiti **nodi**, di questi il software ne possiede centinaia, ogniuno con la sua funzione, le sue 
interazioni e risorse. Da questi elementi ci si puó portare a creare elementi piú complessi imparentando l'uno l'atro questi ultimi in macro elementi chiamati **Scene**
volti alla gestione dell'ambiente sul quale in quel momento si va' a lavorare.

Se non si sa'da dove partire la prima cosa fatta diventa la creazione di un nodo di tipo [**Node2D**](https://docs.godotengine.org/en/stable/classes/class_node2d.html#node2d) come root della scena.

> Per aggiungere un nodo all'albero si può premere con il tasto destro per richiamare la voce dal menù oppure con la shortcut ```CTRL-A``` che aprirà direttamente l'interfaccia per l'aggiunta del nodo

Questo primo nodo, di norma ridefinito **Main**, risulta importante per ancorare ed interfacciare ogni componente che si proietterá nel gioco poiché ogniuno di questi ne sará figlio.
 

> Per un po' piú di chiarezza *si consiglia di seguire la notazione predisposta da Godot* ad esempio per i nodi all'interno della scena viene utilizzato il *CamelCase* mentre per le 
> funzioni e variabili in **GDScript** viene utilizzato lo *snake_case*

##### Character

Una modifica effettuata in Godot 4.0.x rispetto le versioni precedenti risulta essere il nodo [**CharacterBody2D**](https://docs.godotengine.org/en/stable/tutorials/physics/using_character_body_2d.html) che va'a sostituire il [**KinematicBody2D**](https://docs.godotengine.org/en/stable/tutorials/migrating/upgrading_to_godot_4.html).

> La differenza sostanziale (che ho notato almeno) é che nel primo è presente la proprietá ```velocity``` che interagisce direttamente con il metodo ```move_and_slide()``` del nodo.

Aggiunto all'albero il nuovo nodo, la prima cosa che il **Dock** ci fa'notare è la presenza di un'triangolo giallo di attenzione
![attenzione](/Week0/readme/assets/attention.png "Consider addiang a CollisionShape2D") cliccare su quest'ultimo già fornisce la soluzione al problema: è necessario aggiungere una 
[**CollisionShape2D** o un **CollisionPoligon2D**](https://docs.godotengine.org/en/stable/tutorials/assets_pipeline/escn_exporter/physics.html). Questi ultimi definiscono l'intercettazione e gestione delle collisioni definendo l'effettivo corpo del nostro giocatore in questo caso.

Quindi si può procedere ad aggiungere la collision shape che nuovamente risulta "allarmata" da questa icona, questa volta il problema risulta che a questo nodo manca una **risorsa di tipo shape** che
a *differenza dei nodi, fanno riferimento all'inspector del'nodo stesso*, dove è in questo caso è possibile andare direttamente alla voce Shape, cliccare sullla voce empty e creare una nuova risorsa shape dei tipi forniti. In questo progetto viene usata una di tipo [CapsuleShape2D](https://docs.godotengine.org/en/stable/tutorials/physics/collision_shapes_2d.html).

Prima di definire la dimensione della nostra collision shape si può procedere con aggiungere l'immagine così da fare il tutto su misura; il nodo d'aggiungere in questo caso è il nodo [**Sprite2D**](https://docs.godotengine.org/en/stable/classes/class_sprite2d.html)
utile per gestire texture generalmente di qualsiasi tipo (le immagini vengono trasformate in texture di default da Godot se si trovano nella cartella di lavoro).
L'immagine che è stata fornita per il progetto è uno spritesheet di un taxi ![taxi](/Week0/Taxi.png "Taxi SpriteSheet"), che può essere direttamente aggiunto alla voce ```Texture```, il risultato ovviamente mostrerà tutta l'immagine intera in questo caso, ma basta controllare la terza voce nell'inspector per aprire la finestrella ```Animation```, questa possiede tutti i paremetri che ci sono utili per poter gestire la nostra immagine: `Hframes`, `Vframes` ci permettono di definire la griglia per il quale sono presenti le nostre immagini mentre `frame` ci permette di scorrere tra queste. Ci sono altri metodi per gestire uno sprite sheet, tra il quale utilizzare la terza voce dell'inspector: **Region** oppure anche un [AnimatedSprite2D](https://docs.godotengine.org/en/stable/classes/class_animatedsprite2d.html).

Definita anche l'immagine si può procedere a modellare la collision shape come più ci aggrada.

##### Walls e Project Settings

In modo da non perdere il giocatore nel progetto sono stati inseriti dei muri che delimitano le dimensioni della finestra. Oltre a questo il personaggio nella finestra risulta molto piccolo essendo una sprite 16x16 di dimensione in una finestra molto più grande.

La soluzione per la dimensione è possibile risolverla con il nodo di tipo [Camera2D](https://docs.godotengine.org/en/stable/classes/class_camera2d.html) e modificare lo zoom a proprio piacimento oppure direttamente modificare la dimensione delle immagini, ma la problematica in questo caso risulta più "globale", perciò è utile considerare la modifica diretta della giostione dei disegni nella finestra.

Questo è possibile farlo facendo riferimento alla finestra di [Project Settings](https://docs.godotengine.org/en/stable/tutorials/editor/project_settings.html) dal menu di progetto sulla voce **Project**: seguendo Project Settings -> Display -> Window, sarà possibile agire sulla presentazione della schermata come più aggrada. **Le modifiche verranno poi utilizzate per ogni elemento di ogni scena**.

Gestite le dimensioni della [Viewport](https://docs.godotengine.org/en/stable/tutorials/rendering/viewports.html) principale si può procedere all'inserimento dei muri utilizzando un nuovo nodo: [StaticBody2D](https://docs.godotengine.org/en/stable/classes/class_staticbody2d.html); questo nodo non vene disturbato da forze di altri oggetti, quindi è perfetto utilizzarlo per muri o piattaforme.
Un nodo che ha bisogno di una shape può gestire più shapes, premesso questo si può procedere a creare il muro che contorna il nostro limite utilizzando benissimo un solo static body per tutti le shape necessarie a creare anche la propria mappa.

> #### Tip
>
> Se hai modificato la `scale` della tua finestra è consigliabile utilizzare dei **riferimenti** che possono essere creati cliccando e trascinando l'angolo grigio ![riferimenti](/Week0/readme/assets/riferimenti.png "Puoi trascinare il quadratino grigio per poter ottenere dei riferimenti") in alto a sinistra. Per rendere piu preciso il posizionamento puoi aggingere lo snap per la griglia sul menù del visualizzatore 2D ![griglia](/Week0/readme/assets/attention.png)

È possibile valutare diversi modi per gestire i limiti per il movimento dei corpi, nel progetto (vista la dimensione della mappa) è stato deciso di usare un diverso oggetto.

### Scripting
