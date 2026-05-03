// lang.js — Spökkartan i18n, vanilla React (ingen extern dep)
// Stöder: svenska (sv), engelska (en), norska (no), danska (da), tyska (de)

import { useState, useEffect, useCallback } from "react";

export const LANGS = [
  { code: "sv", name: "Svenska", flag: "🇸🇪" },
  { code: "en", name: "English", flag: "🇬🇧" },
  { code: "no", name: "Norsk", flag: "🇳🇴" },
  { code: "da", name: "Dansk", flag: "🇩🇰" },
  { code: "de", name: "Deutsch", flag: "🇩🇪" },
];

export const DEFAULT_LANG = "sv";

// Detektera webbläsarspråk vid första besök
function detectBrowserLang() {
  if (typeof navigator === "undefined") return DEFAULT_LANG;
  const browserLang = (navigator.language || "sv").substring(0, 2).toLowerCase();
  return LANGS.find(l => l.code === browserLang)?.code || DEFAULT_LANG;
}

// Översättnings-dictionary
export const T = {
  sv: {
    // Hero & home
    hero_title: "Hitta & utforska hemsökta platser",
    hero_subtitle_template: "En av {country}s största sajter för hemsökta platser — {n} platser i {countries} länder.",
    tag_places: "platser",
    tag_countries: "länder",
    tag_bookable: "bokningsbara",
    intro_offer_title: "Prova PRO för 19 kr — första månaden",
    intro_offer_desc: "Alla platser · GPS · Roadtrip · E-bok-builder",
    btn_try_pro: "Prova Ghost Hunter PRO",

    // Cards
    card_map_title: "Spökkartan",
    card_map_desc: "Karta med alla platser",
    card_stories_title: "Berättelser",
    card_stories_desc: "Läs om hemsökta platser",
    card_ebook_title: "Bygg E-bok",
    card_ebook_desc: "29-39 kr · PDF till din e-post",
    card_hunters_title: "Spökjägare",
    card_hunters_desc: "Möt och kontakta jägarna",

    // Hotels
    hotels_title: "Hemsökta Hotell",
    book_now: "Boka",

    // Bottom nav
    nav_home: "Hem",
    nav_map: "Spökkartan",
    nav_stories: "Berättelser",
    nav_ebook: "E-bok",
    nav_hunters: "Spökjägare",
    nav_shop: "Shop",

    // Auth modal
    login_title: "Logga in",
    register_title: "Skapa konto",
    welcome_back: "Välkommen tillbaka till Spökkartan",
    continue_with_google: "Fortsätt med Google",
    or_with_email: "eller med e-post",
    new_user_offer: "Ny användare? Prova PRO för 19 kr första månaden",
    then_per_month: "Sedan 49 kr/mån · Avbryt när som helst",
    email_label: "E-postadress",
    password_label: "Lösenord",
    forgot_password: "Glömt lösenord?",
    login_btn: "Logga in →",
    no_account: "Ny här?",
    create_account: "Skapa konto",
    have_account: "Har konto?",

    // Place
    free: "GRATIS",
    pro: "PRO",
    locked_unlock: "Lås upp med Ghost Hunter PRO",
    bocka_av: "Bocka av",
    visited: "BESÖKT",
    add_roadtrip: "+ Roadtrip",
    in_roadtrip: "I Roadtrip",
    book_stay: "Boka boende här (affiliate) →",
    haunted_hotel_hint: "Tänk om du kunde bo på ett hemsökt ställe?",
    related_places: "Liknande platser som kan intressera dig",
    related_free: "Andra platser du kan läsa gratis",
    history_label: "Historik & Berättelse",

    // PRO modal
    pro_intro_offer: "Introduktionserbjudande",
    pro_19_first: "19 kr",
    pro_first_month: "första månaden",
    pro_then_49: "Sedan 49 kr/mån · Avbryt när som helst",
    pro_continue: "Fortsätt till säker betalning →",
    pro_what_you_get: ["Alla 308+ platser upplåsta", "GPS-koordinater & navigering", "Roadtrip-planerare", "Anslagstavlan (spökjägare)", "E-bok-builder — alla platser"],
    pro_secure: "Säker betalning · Ingen bindningstid",

    // Common
    back: "Tillbaka",
    cancel: "Avbryt",
    save: "Spara",
    close: "Stäng",
    loading: "Laddar…",
    search: "Sök",
    filter: "Filter",
    all: "Alla",

    // Language picker
    select_language: "Välj språk",
  },

  en: {
    hero_title: "Find & explore haunted places",
    hero_subtitle_template: "One of the largest sites for haunted places — {n} places across {countries} countries.",
    tag_places: "places",
    tag_countries: "countries",
    tag_bookable: "bookable",
    intro_offer_title: "Try PRO for 19 SEK — first month",
    intro_offer_desc: "All places · GPS · Roadtrip · E-book builder",
    btn_try_pro: "Try Ghost Hunter PRO",
    card_map_title: "The Ghost Map",
    card_map_desc: "Map with all places",
    card_stories_title: "Stories",
    card_stories_desc: "Read about haunted places",
    card_ebook_title: "Build E-book",
    card_ebook_desc: "29-39 SEK · PDF to your email",
    card_hunters_title: "Ghost Hunters",
    card_hunters_desc: "Meet and contact the hunters",
    hotels_title: "Haunted Hotels",
    book_now: "Book",
    nav_home: "Home",
    nav_map: "Map",
    nav_stories: "Stories",
    nav_ebook: "E-book",
    nav_hunters: "Hunters",
    nav_shop: "Shop",
    login_title: "Sign in",
    register_title: "Create account",
    welcome_back: "Welcome back to The Ghost Map",
    continue_with_google: "Continue with Google",
    or_with_email: "or with email",
    new_user_offer: "New user? Try PRO for 19 SEK first month",
    then_per_month: "Then 49 SEK/month · Cancel anytime",
    email_label: "Email address",
    password_label: "Password",
    forgot_password: "Forgot password?",
    login_btn: "Sign in →",
    no_account: "New here?",
    create_account: "Create account",
    have_account: "Have an account?",
    free: "FREE",
    pro: "PRO",
    locked_unlock: "Unlock with Ghost Hunter PRO",
    bocka_av: "Mark visited",
    visited: "VISITED",
    add_roadtrip: "+ Roadtrip",
    in_roadtrip: "In Roadtrip",
    book_stay: "Book a stay here (affiliate) →",
    haunted_hotel_hint: "What if you could sleep at a haunted place?",
    related_places: "Similar places you might like",
    related_free: "Other places you can read free",
    history_label: "History & Story",
    pro_intro_offer: "Introductory offer",
    pro_19_first: "19 SEK",
    pro_first_month: "first month",
    pro_then_49: "Then 49 SEK/month · Cancel anytime",
    pro_continue: "Continue to secure payment →",
    pro_what_you_get: ["All 308+ places unlocked", "GPS coordinates & navigation", "Roadtrip planner", "Bulletin board (ghost hunters)", "E-book builder — all places"],
    pro_secure: "Secure payment · No commitment",
    back: "Back",
    cancel: "Cancel",
    save: "Save",
    close: "Close",
    loading: "Loading…",
    search: "Search",
    filter: "Filter",
    all: "All",
    select_language: "Select language",
  },

  no: {
    hero_title: "Finn og utforsk hjemsøkte steder",
    hero_subtitle_template: "En av de største sidene for hjemsøkte steder — {n} steder i {countries} land.",
    tag_places: "steder",
    tag_countries: "land",
    tag_bookable: "bookbare",
    intro_offer_title: "Prøv PRO for 19 SEK — første måned",
    intro_offer_desc: "Alle steder · GPS · Roadtrip · E-bok-bygger",
    btn_try_pro: "Prøv Ghost Hunter PRO",
    card_map_title: "Spøkkartet",
    card_map_desc: "Kart med alle steder",
    card_stories_title: "Historier",
    card_stories_desc: "Les om hjemsøkte steder",
    card_ebook_title: "Bygg E-bok",
    card_ebook_desc: "29-39 SEK · PDF til e-posten din",
    card_hunters_title: "Spøkjegere",
    card_hunters_desc: "Møt og kontakt jegerne",
    hotels_title: "Hjemsøkte Hoteller",
    book_now: "Bestill",
    nav_home: "Hjem",
    nav_map: "Kart",
    nav_stories: "Historier",
    nav_ebook: "E-bok",
    nav_hunters: "Jegere",
    nav_shop: "Butikk",
    login_title: "Logg inn",
    register_title: "Opprett konto",
    welcome_back: "Velkommen tilbake til Spøkkartet",
    continue_with_google: "Fortsett med Google",
    or_with_email: "eller med e-post",
    new_user_offer: "Ny bruker? Prøv PRO for 19 SEK første måneden",
    then_per_month: "Deretter 49 SEK/mnd · Avbryt når du vil",
    email_label: "E-postadresse",
    password_label: "Passord",
    forgot_password: "Glemt passord?",
    login_btn: "Logg inn →",
    no_account: "Ny her?",
    create_account: "Opprett konto",
    have_account: "Har konto?",
    free: "GRATIS",
    pro: "PRO",
    locked_unlock: "Lås opp med Ghost Hunter PRO",
    bocka_av: "Merk besøkt",
    visited: "BESØKT",
    add_roadtrip: "+ Roadtrip",
    in_roadtrip: "I Roadtrip",
    book_stay: "Bestill overnatting her (affiliate) →",
    haunted_hotel_hint: "Tenk om du kunne overnatte på et hjemsøkt sted?",
    related_places: "Lignende steder du kan like",
    related_free: "Andre steder du kan lese gratis",
    history_label: "Historikk & Fortelling",
    pro_intro_offer: "Introduksjonstilbud",
    pro_19_first: "19 SEK",
    pro_first_month: "første måneden",
    pro_then_49: "Deretter 49 SEK/mnd · Avbryt når du vil",
    pro_continue: "Fortsett til sikker betaling →",
    pro_what_you_get: ["Alle 308+ steder opplåst", "GPS-koordinater & navigering", "Roadtrip-planlegger", "Oppslagstavle (spøkjegere)", "E-bok-bygger — alle steder"],
    pro_secure: "Sikker betaling · Ingen bindingstid",
    back: "Tilbake",
    cancel: "Avbryt",
    save: "Lagre",
    close: "Lukk",
    loading: "Laster…",
    search: "Søk",
    filter: "Filter",
    all: "Alle",
    select_language: "Velg språk",
  },

  da: {
    hero_title: "Find & udforsk hjemsøgte steder",
    hero_subtitle_template: "En af de største sider for hjemsøgte steder — {n} steder i {countries} lande.",
    tag_places: "steder",
    tag_countries: "lande",
    tag_bookable: "kan bookes",
    intro_offer_title: "Prøv PRO for 19 SEK — første måned",
    intro_offer_desc: "Alle steder · GPS · Roadtrip · E-bog-bygger",
    btn_try_pro: "Prøv Ghost Hunter PRO",
    card_map_title: "Spøgelseskortet",
    card_map_desc: "Kort med alle steder",
    card_stories_title: "Historier",
    card_stories_desc: "Læs om hjemsøgte steder",
    card_ebook_title: "Byg E-bog",
    card_ebook_desc: "29-39 SEK · PDF til din e-mail",
    card_hunters_title: "Spøgelsesjægere",
    card_hunters_desc: "Mød og kontakt jægerne",
    hotels_title: "Hjemsøgte Hoteller",
    book_now: "Book",
    nav_home: "Hjem",
    nav_map: "Kort",
    nav_stories: "Historier",
    nav_ebook: "E-bog",
    nav_hunters: "Jægere",
    nav_shop: "Butik",
    login_title: "Log ind",
    register_title: "Opret konto",
    welcome_back: "Velkommen tilbage til Spøgelseskortet",
    continue_with_google: "Fortsæt med Google",
    or_with_email: "eller med e-mail",
    new_user_offer: "Ny bruger? Prøv PRO for 19 SEK første måned",
    then_per_month: "Derefter 49 SEK/md · Annullér når som helst",
    email_label: "E-mailadresse",
    password_label: "Adgangskode",
    forgot_password: "Glemt adgangskode?",
    login_btn: "Log ind →",
    no_account: "Ny her?",
    create_account: "Opret konto",
    have_account: "Har konto?",
    free: "GRATIS",
    pro: "PRO",
    locked_unlock: "Lås op med Ghost Hunter PRO",
    bocka_av: "Marker besøgt",
    visited: "BESØGT",
    add_roadtrip: "+ Roadtrip",
    in_roadtrip: "I Roadtrip",
    book_stay: "Book overnatning her (affiliate) →",
    haunted_hotel_hint: "Tænk hvis du kunne overnatte på et hjemsøgt sted?",
    related_places: "Lignende steder du måske kan lide",
    related_free: "Andre steder du kan læse gratis",
    history_label: "Historie & Fortælling",
    pro_intro_offer: "Introduktionstilbud",
    pro_19_first: "19 SEK",
    pro_first_month: "første måned",
    pro_then_49: "Derefter 49 SEK/md · Annullér når som helst",
    pro_continue: "Fortsæt til sikker betaling →",
    pro_what_you_get: ["Alle 308+ steder låst op", "GPS-koordinater & navigation", "Roadtrip-planlægger", "Opslagstavle (spøgelsesjægere)", "E-bog-bygger — alle steder"],
    pro_secure: "Sikker betaling · Ingen bindingsperiode",
    back: "Tilbage",
    cancel: "Annullér",
    save: "Gem",
    close: "Luk",
    loading: "Indlæser…",
    search: "Søg",
    filter: "Filter",
    all: "Alle",
    select_language: "Vælg sprog",
  },

  de: {
    hero_title: "Heimgesuchte Orte finden & erkunden",
    hero_subtitle_template: "Eine der größten Seiten für heimgesuchte Orte — {n} Orte in {countries} Ländern.",
    tag_places: "Orte",
    tag_countries: "Länder",
    tag_bookable: "buchbar",
    intro_offer_title: "PRO für 19 SEK testen — ersten Monat",
    intro_offer_desc: "Alle Orte · GPS · Roadtrip · E-Book-Builder",
    btn_try_pro: "Ghost Hunter PRO testen",
    card_map_title: "Geisterkarte",
    card_map_desc: "Karte mit allen Orten",
    card_stories_title: "Geschichten",
    card_stories_desc: "Lesen Sie über heimgesuchte Orte",
    card_ebook_title: "E-Book erstellen",
    card_ebook_desc: "29-39 SEK · PDF an Ihre E-Mail",
    card_hunters_title: "Geisterjäger",
    card_hunters_desc: "Treffen und kontaktieren Sie die Jäger",
    hotels_title: "Heimgesuchte Hotels",
    book_now: "Buchen",
    nav_home: "Start",
    nav_map: "Karte",
    nav_stories: "Geschichten",
    nav_ebook: "E-Book",
    nav_hunters: "Jäger",
    nav_shop: "Shop",
    login_title: "Anmelden",
    register_title: "Konto erstellen",
    welcome_back: "Willkommen zurück bei der Geisterkarte",
    continue_with_google: "Mit Google fortfahren",
    or_with_email: "oder per E-Mail",
    new_user_offer: "Neuer Nutzer? PRO für 19 SEK ersten Monat testen",
    then_per_month: "Dann 49 SEK/Monat · Jederzeit kündbar",
    email_label: "E-Mail-Adresse",
    password_label: "Passwort",
    forgot_password: "Passwort vergessen?",
    login_btn: "Anmelden →",
    no_account: "Neu hier?",
    create_account: "Konto erstellen",
    have_account: "Konto vorhanden?",
    free: "GRATIS",
    pro: "PRO",
    locked_unlock: "Mit Ghost Hunter PRO freischalten",
    bocka_av: "Als besucht markieren",
    visited: "BESUCHT",
    add_roadtrip: "+ Roadtrip",
    in_roadtrip: "In Roadtrip",
    book_stay: "Hier übernachten (Affiliate) →",
    haunted_hotel_hint: "Was wäre, wenn Sie an einem heimgesuchten Ort übernachten könnten?",
    related_places: "Ähnliche Orte, die Ihnen gefallen könnten",
    related_free: "Andere Orte, die Sie kostenlos lesen können",
    history_label: "Geschichte & Erzählung",
    pro_intro_offer: "Einführungsangebot",
    pro_19_first: "19 SEK",
    pro_first_month: "ersten Monat",
    pro_then_49: "Dann 49 SEK/Monat · Jederzeit kündbar",
    pro_continue: "Weiter zur sicheren Zahlung →",
    pro_what_you_get: ["Alle 308+ Orte freigeschaltet", "GPS-Koordinaten & Navigation", "Roadtrip-Planer", "Schwarzes Brett (Geisterjäger)", "E-Book-Builder — alle Orte"],
    pro_secure: "Sichere Zahlung · Keine Bindung",
    back: "Zurück",
    cancel: "Abbrechen",
    save: "Speichern",
    close: "Schließen",
    loading: "Lädt…",
    search: "Suchen",
    filter: "Filter",
    all: "Alle",
    select_language: "Sprache wählen",
  },
};

// Custom hook + helpers
export function useLang() {
  const [lang, setLangState] = useState(() => {
    if (typeof localStorage !== "undefined") {
      return localStorage.getItem("spokkartan_lang") || detectBrowserLang();
    }
    return DEFAULT_LANG;
  });

  const setLang = useCallback((newLang) => {
    setLangState(newLang);
    if (typeof localStorage !== "undefined") {
      localStorage.setItem("spokkartan_lang", newLang);
    }
  }, []);

  const t = useCallback((key, vars = {}) => {
    const dict = T[lang] || T[DEFAULT_LANG];
    let val = dict[key];
    if (val === undefined) val = T[DEFAULT_LANG][key] || key;
    if (typeof val === "string" && Object.keys(vars).length > 0) {
      Object.entries(vars).forEach(([k, v]) => {
        val = val.replace(new RegExp(`\\{${k}\\}`, "g"), v);
      });
    }
    return val;
  }, [lang]);

  return { lang, setLang, t, langs: LANGS };
}

// Standalone t() for use outside React (rare)
export function t(key, lang = DEFAULT_LANG, vars = {}) {
  const dict = T[lang] || T[DEFAULT_LANG];
  let val = dict[key] || T[DEFAULT_LANG][key] || key;
  if (typeof val === "string" && Object.keys(vars).length > 0) {
    Object.entries(vars).forEach(([k, v]) => {
      val = val.replace(new RegExp(`\\{${k}\\}`, "g"), v);
    });
  }
  return val;
}
