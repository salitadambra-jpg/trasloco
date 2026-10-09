# Trasloco

Web app per il trasloco: scatole con codice scritto a penna, foto del contenuto, ricerca, checklist e zaino della prima notte. Lista unica condivisa tra più persone.

- **Pagina**: GitHub Pages (questo repository)
- **Dati, foto e login**: Supabase (piano gratuito)

Il codice è pubblico, i dati no: solo le email presenti nella tabella `membri` possono leggere o modificare la lista.

## 1. Supabase

1. Crea un account su <https://supabase.com> e un nuovo progetto (regione: Central EU / Frankfurt).
2. Vai su **SQL Editor → New query**, incolla il contenuto di `setup.sql`, **cambia l'email nell'ultima riga con la tua** e premi **Run**.
3. Vai su **Authentication → Emails → Magic Link** e aggiungi al testo dell'email questa riga, così arriva anche il codice da digitare (utile quando l'app è aperta dalla schermata Home):

   ```
   <p>Codice: <b>{{ .Token }}</b></p>
   ```

4. Vai su **Project Settings → API** e copia **Project URL** e la chiave **anon public**.

## 2. GitHub

1. Crea un repository nuovo, per esempio `trasloco`.
2. Apri `index.html`, in cima allo script finale sostituisci `SUPABASE_URL` e `SUPABASE_ANON_KEY` con i valori copiati, poi carica `index.html` nel repository (**Add file → Upload files**). Non serve caricare `setup.sql`.
3. Vai su **Settings → Pages**, alla voce *Branch* scegli `main` e cartella `/ (root)`, poi **Save**. Dopo un minuto la pagina è online su `https://TUO-UTENTE.github.io/trasloco/`.

## 3. Collegare i due

In Supabase vai su **Authentication → URL Configuration**:

- **Site URL**: `https://TUO-UTENTE.github.io/trasloco/`
- **Redirect URLs**: aggiungi lo stesso indirizzo

## 4. Aggiungere chi ti aiuta

In Supabase apri **Table Editor → membri → Insert row** e inserisci l'email della persona. Poi le mandi il link: entra con la sua email e il codice che riceve.

Per togliere l'accesso a qualcuno basta cancellare la sua riga.

## Note

- Il servizio email integrato di Supabase invia pochi messaggi l'ora: se fanno login molte persone insieme, qualcuno potrebbe dover riprovare dopo un po'.
- Sul telefono aggiungi la pagina alla schermata Home (Safari: Condividi → Aggiungi alla schermata Home; Chrome: menu ⋮ → Aggiungi a schermata Home).
- Le foto vengono ridotte prima del caricamento. Il piano gratuito di Supabase offre 1 GB di spazio, sufficiente per migliaia di foto.
