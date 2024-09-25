
# E-Cars Analysis Project

Questo progetto rappresenta uno dei miei primi lavori nel campo dell'analisi dei dati e della programmazione. L'obiettivo principale era applicare tecniche di statistica multivariata, regressione multipla e clustering su un dataset relativo a diverse caratteristiche di auto elettriche. Essendo un progetto sviluppato all'inizio del mio percorso, alcune soluzioni sono basiche e non ottimizzate, ma il focus principale era apprendere e sperimentare nuovi metodi.

## Descrizione

Il progetto analizza un dataset contenente specifiche tecniche di auto elettriche, come autonomia, capacità della batteria, potenza e prezzo. Il codice segue diverse fasi di analisi:

1. **Pulizia dei Dati**: Ho trasformato alcune variabili per facilitarne l'analisi statistica.
   
2. **Analisi Statistica Descrittiva**: Ho calcolato le statistiche descrittive (media, asimmetria, kurtosi, ecc.) utilizzando la funzione `apply` per ogni variabile quantitativa.

3. **Analisi delle Componenti Principali (ACP)**: Ho ridotto la dimensionalità dei dati utilizzando l'ACP, per evidenziare le componenti che spiegano la maggior parte della variabilità.

4. **Regressione Multipla**: Ho esplorato vari modelli di regressione per prevedere l'autonomia delle auto in base alle loro caratteristiche tecniche. Ho utilizzato sia metodi di selezione step-wise che prove manuali per verificare la significatività delle variabili.

5. **Analisi Cluster**: Ho segmentato i dati usando l'algoritmo K-means e analizzato i cluster per identificare gruppi di auto con caratteristiche simili.

## Tecnologie Utilizzate

- **R**: Per l'analisi statistica e la visualizzazione.
- **Librerie**: `e1071`, `MASS`, `factoextra`, `ggplot2`, `cluster` per l'implementazione di metodi statistici e grafici.

## Note

Questo progetto è stato sviluppato con lo scopo di imparare. Alcune tecniche non sono ottimizzate o perfezionate come farei oggi, ma rappresentano comunque una buona base di partenza per future analisi.

## Prossimi Passi

- Ottimizzazione del modello di regressione.
- Maggiori approfondimenti sull'analisi dei cluster.
- Automazione del processo di selezione delle componenti principali.
