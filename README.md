# Trasloco

Web app per il trasloco: scatole con codice scritto a penna, foto del contenuto, ricerca, checklist e zaino della prima notte. Lista unica condivisa tra più persone.

- **Pagina**: GitHub Pages (questo repository)
- **Dati, foto e login**: Supabase (piano gratuito)

Il codice è pubblico, i dati no: solo le email presenti nella tabella `membri` possono leggere o modificare la lista.

## 1. Supabase

1. Crea un account su <https://supabase.com> e un nuovo progetto (regione: Central EU / Frankfurt).
2. Vai su **SQL Editor → New query**, incolla il contenuto di `setup.sql`, **cambia l'email nell'ultima riga con la tua** e premi **Run**.
3. Vai su **Authentication → Sign In / Providers** e disattiva **Allow new users to sign up**: gli account li crei solo tu.
4. Vai su **Project Settings → API** e copia **Project URL** e la chiave **anon public**.

## 2. GitHub

1. Crea un repository nuovo, per esempio `trasloco`.
2. Apri `index.html`, in cima allo script finale sostituisci `SUPABASE_URL` e `SUPABASE_ANON_KEY` con i valori copiati, poi carica `index.html` nel repository (**Add file → Upload files**). Non serve caricare `setup.sql`.
3. Vai su **Settings → Pages**, alla voce *Branch* scegli `main` e cartella `/ (root)`, poi **Save**. Dopo un minuto la pagina è online su `https://TUO-UTENTE.github.io/trasloco/`.

## 3. Creare gli account

Per te e per ogni persona che ti aiuta:

1. In Supabase vai su **Authentication → Users → Add user → Create new user**, inserisci email e una password e lascia attivo **Auto Confirm User**.
2. In **Table Editor → membri → Insert row** inserisci la stessa email.
3. Manda alla persona il link della pagina con email e password.

Per togliere l'accesso a qualcuno cancella la sua riga in `membri` (e, se vuoi, l'utente in Authentication → Users).

## Note

- L'accesso usa email e password, senza email di conferma: non serve configurare nessun servizio di posta.
- Sul telefono aggiungi la pagina alla schermata Home (Safari: Condividi → Aggiungi alla schermata Home; Chrome: menu ⋮ → Aggiungi a schermata Home).
- Le foto vengono ridotte prima del caricamento. Il piano gratuito di Supabase offre 1 GB di spazio, sufficiente per migliaia di foto.
