# DATA TEMPLATE

{  
>
"entities": [[**Entity**](#entity)],  
"associations": [[**Association**](#association)],  
"links": [[**Link**](#link)],  
"placeHolders": [[**Positioned**](#positioned)]

}

### Entity

{  
>
"name": *@required* (**String**) nome dell'entità (visualizzato)  
"px": *@required* ([**coordinata**](#coordinata))  
"py": *@required* ([**coordinata**](#coordinata))  
"relativeTo": *@default("TL")* (**String**) identificatore dell'entità alla quale riferirsi per la posizione (*speciali*: "TL", "TR", "BL", "BR")  
"attributes": [[**Attribute**](#attribute)]

}

### Association

{  
>
"name": *@required* (**String**) nome dell'associazione (visualizzato)  
"px": *@required* ([**coordinata**](#coordinata))  
"py": *@required* ([**coordinata**](#coordinata))  
"relativeTo": *@default("TL")* (**String**) identificatore dell'entità alla quale riferirsi per la posizione (*speciali*: "TL", "TR", "BL", "BR")  
"attributes": [[**Attribute**](#attribute)]  
"entities": [[**AssociationLink**](#associationlink)]

}

### Link

{  
>
"from": *@required* (**String**) id dell'entità  
"to": *@required* (**String**) id dell'entità  
"defaultDirection": *@default("|")* (**String**) "|" priorità verticale, "-" priorità orizzontale, "/" link diretto

}

### Positioned

{  
>
"name": *@required* (**String**) identificatore del placeHolder (non visualizzato)  
"px": *@required* ([**coordinata**](#coordinata))  
"py": *@required* ([**coordinata**](#coordinata))  
"relativeTo": *@default("TL")* (**String**) identificatore dell'entità alla quale riferirsi per la posizione (*speciali*: "TL", "TR", "BL", "BR")

}

### coordinata

(**float**): posizione in pixel  
oppure:  
(**String**): espressione da valutare. "***w***", "***h***": larghezza/altezza costante dei riquadri; "***W***", "***H***": larghezza/altezza della schermata

### Attribute

{  
>
"name": *@required* (**String**) nome dell'attributo (inserire come identificatore, anche se non visualizzato)  
"labelPosition": *@default("")* (**String**) "<", "^", ">", "v". Se "" la label non viene visualizzata  
"relativeToPosition": *@required* (**String**) "<", "^", ">", "v" **oppure** "px, py" con px e py [**coordinata**](#coordinata)  
"padding": *@default(30)* (**float**) distanza dal bordo del container  
"primary": *@default(false)* (**boolean**) impostare l'attributo come chiave primaria o meno  
"linearLink": *@default(null)* (**String**) "|", "-", "x": verticale, orizzontale o senza link

}

### AssociationLink

{  
>
"entity": *@required* (**String**) nome dell'entità  
"min": *@required* (**String**) cardinalità minima  
"max": *@required* (**String**) cardinalità massima  
"position": *@required* (**String**) "<", "^", ">", "v". Posizione della cardinalità

}
