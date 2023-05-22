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

Generalmente se non si sa'da dove partire la prima cosa fatta diventa la creazione di un nodo di tipo [**Node2D**](blue) come root della scena
Questo primo nodo risulta importante per ancorare ed interfacciare ogni componente che si proietterá nel gioco poiché ogniuno di questi ne sará figlio.

Generalmente questo nodo viene chiamato **Main**

> Per un po' piú di chiarezza *si consiglia di seguire la notazione predisposta da Godot* ad esempio per i nodi all'interno della scena viene utilizzato il *camel case* mentre per le 
> funzioni e variabili in **GDScript** viene utilizzato lo *snake case*

##### Character

Una modifica effettuata in Godot 4.0.x rispetto le versioni precedenti risulta essere il nodo [**CharacterBody2D**](blue) che va'a sostituire il [**KinematicBody2D**](blue).

> La differenza sostanziale (che ho notato almeno) é che nel primo è presente la proprietá ```velocity``` che interagisce direttamente con il metodo ```move_and_slide()``` del nodo.

Aggiunto all'albero il nuovo nodo, la prima cosa che il **Dock** ci fa'notare è la presenza di un'triangolo giallo di
![attenzione](/Week0/readme/assets/attention.png "Consider addiang a CollisionShape2D")
