
// SPÖKKARTAN v7 — Mobile-first, working auth, clean navigation
import { useState, useEffect, useRef, useMemo, useCallback } from "react";
import { fetchPlaces, subscribeToPlaces, signInWithGoogle, signInWithEmail, signUpWithEmail, signOut as supabaseSignOut, getProfile, onAuthChange, getSession, fetchPartners, createPartner, fetchPartnerPackages, submitPartnerQuestion, fetchPartnerQuestions, updatePartnerQuestion, fetchHunters, fetchHunterVisits, updateHunterProfile, upsertHunterVisit, createHunterOrder } from "./supabase";
import { useLang, LANGS } from "./lang";

const LF_CSS = "https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/leaflet.min.css";
const LF_JS  = "https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/leaflet.min.js";

// ── ADMIN CREDENTIALS (base64 encoded) ───────────────────────
const ADMIN_EMAIL = atob("ZnJlZHJpY2subHVuZGJlcmdAZ21haWwuY29t");
const ADMIN_PASS  = atob("QW5nbGFybmEx");

// ── USERS DB ──────────────────────────────────────────────────
const USERS_DB = {
  [ADMIN_EMAIL]: {
    id:"admin-1", name:"Fredrik Lundberg", email:ADMIN_EMAIL,
    pass:ADMIN_PASS, role:"admin", pro:true,
    bio:"", yt:"", ig:"", fb:"", avatar:"", verified:true,
    created:"2024-01-01"
  }
};

// ── BULLETIN BOARD DEMO POSTS ─────────────────────────────────
const BOARD_POSTS_INIT = [
  {id:"b1",authorId:"h1",author:"Matti Hietasaari",avatar:"https://www.spokkartan.se/wp-content/uploads/2024/10/c4ff1399-f783-4dbb-b366-768d058a77d5.jpeg",verified:true,cat:"samarbete",title:"Söker partner till Rankhyttans Herrgård i september",body:"Planerar en övernattning i Dalarna i september. Söker erfaren partner med EMF-utrustning. Hör av dig!",ts:"2026-04-10T19:30:00",likes:7},
  {id:"b2",authorId:"h2",author:"John Lietz",avatar:"https://www.spokkartan.se/wp-content/uploads/2024/11/6-5.jpg",verified:true,cat:"säljer",title:"Säljer: Mel-8704R EMF-mätare, knappt använd",body:"Uppgraderar utrustningen. Säljer Mel-8704R för 850 kr (nypris 1400 kr). Swish, upphämtning Göteborg eller frakt.",ts:"2026-04-14T11:15:00",likes:3},
  {id:"b3",authorId:"h3",author:"Jenny & Johanna",avatar:"https://www.spokkartan.se/wp-content/uploads/2025/11/613800CD-0D47-474D-8B4D-8492EC3D693F.jpg",verified:true,cat:"tipsar",title:"Okänd plats nära Sundsvall — extremt aktiv",body:"Hittade en övergiven gård som inte finns på Spökkartan. Dörrar slogs, temperaturen sjönk 4 grader. Kan dela koordinater.",ts:"2026-04-20T22:45:00",likes:19},
];

// ── AFFILIATE DATA ────────────────────────────────────────────
const AMAZON_TAG = "spokkartan-21";
const HAUNTED_HOTELS = [
  {name:"Borgvattnets Prästgård",region:"Jämtland",country:"Sverige",price:"fr. 590 kr/natt",scary:5,url:"https://www.countrysidehotels.se/en/experience/haunted-hotels-in-sweden/",partner:"Countryside Hotels"},
  {name:"Stenkullens Värdshus",region:"Östergötland",country:"Sverige",price:"fr. 1 290 kr/natt",scary:4,url:"https://www.booking.com/searchresults.sv.html?ss=Stenkullen+Värdshus",partner:"Booking.com"},
  {name:"Häringe Slott",region:"Stockholm",country:"Sverige",price:"fr. 2 800 kr/natt",scary:4,url:"https://www.countrysidehotels.se/en/experience/haunted-hotels-in-sweden/",partner:"Countryside Hotels"},
  {name:"Hotel Union Øye",region:"Norangsfjorden",country:"Norge",price:"fr. 2 100 kr/natt",scary:4,url:"https://www.booking.com/searchresults.sv.html?ss=Hotel+Union+Øye",partner:"Booking.com"},
  {name:"Dragsholm Slot",region:"Sjælland",country:"Danmark",price:"fr. 2 400 kr/natt",scary:5,url:"https://www.booking.com/searchresults.en.html?ss=Dragsholm+Slot",partner:"Booking.com"},
  {name:"Dalen Hotel",region:"Telemark",country:"Norge",price:"fr. 1 500 kr/natt",scary:4,url:"https://www.booking.com/searchresults.sv.html?ss=Dalen+Hotel+Norway",partner:"Booking.com"},
];
const GHOST_TOURS = [
  {name:"Stockholm Ghost Walk",city:"Stockholm",price:"fr. 299 kr",duration:"90 min",rating:4.8,reviews:2340,url:"https://www.getyourguide.com/stockholm-l50/stockholm-90-minute-ghost-walk-historical-tour-t249222/",partner:"GetYourGuide"},
  {name:"Oslo Spøkelsesvandring",city:"Oslo",price:"fr. 349 kr",duration:"90 min",rating:4.7,reviews:678,url:"https://www.getyourguide.com/oslo-l4/",partner:"GetYourGuide"},
  {name:"Edinburgh Underground Vaults",city:"Edinburgh",price:"fr. 499 kr",duration:"75 min",rating:4.9,reviews:5670,url:"https://www.getyourguide.com/edinburgh-l1/",partner:"GetYourGuide"},
  {name:"Uppsala Mörka Hemligheter",city:"Uppsala",price:"fr. 449 kr",duration:"120 min",rating:4.9,reviews:156,url:"https://www.tripadvisor.com/",partner:"TripAdvisor"},
];
const BASE_HUNTERS = [
  {
    id:"h1",name:"Matti Hietasaari",verified:true,speciality:"EMF & ITC",since:"2015",places:47,
    tier:"spotlight",
    img:"https://www.spokkartan.se/wp-content/uploads/2024/10/c4ff1399-f783-4dbb-b366-768d058a77d5.jpeg",
    tagline:"Sveriges mest aktiva pod-spökjägare — 200+ undersökningar dokumenterade.",
    bio:"Spökjägare, poddare och grundare av Spökjägargruppen Okänt. Kör poddarna 'Det värsta jag hört' och 'Spökhistorier'. Intensiva nattundersökningar i Sverige och Finland sedan 2015. Fokus på bevis-samlande med EMF, ITC-spökboxar och röstinspelning.",
    yt:"https://youtube.com/@OkantSpokjakt",ig:"https://instagram.com/matti.okant",fb:"https://facebook.com/OkantSpokjakt",
    podcast:"https://open.spotify.com/show/spokhistorier",website:"",
    bestPlace:"Borgvattnets prästgård",
    bestReason:"Vi övernattade tre gånger och fick varje gång samma kvinnoröst på olika EVP-inspelningar. Aldrig upplevt något liknande.",
    upcoming:"Vinternedslag i Rankhyttans Herrgård (sept 2026) + ny pod-säsong med fokus på Norrland. Kör live-stream från Bokenäs i augusti.",
    visitedPlaces:[
      {name:"Borgvattnets prästgård",country:"Sverige",spook:5},
      {name:"Bokenäs Värdshus",country:"Sverige",spook:4},
      {name:"Rödby fyrtorn",country:"Danmark",spook:4},
      {name:"Helvetegården",country:"Finland",spook:5},
    ],
  },
  {
    id:"h2",name:"John Lietz",verified:true,speciality:"Film & ljud-analys",since:"2012",places:63,
    tier:"premium",
    img:"https://www.spokkartan.se/wp-content/uploads/2024/11/6-5.jpg",
    tagline:"Sveriges mest dokumenterade spökjägare — YouTube + IG + 63 platser undersökta.",
    bio:"Grundare av Spökjakt Sverige. En av Sveriges mest engagerade paranormalutredare med YouTube-kanal och stort Instagram-följe. Specialist på ljud- och filmanalys efter undersökningar — använder noggranna kontrollexperiment innan något publiceras.",
    yt:"https://youtube.com/@SpokjaktSverige",ig:"https://instagram.com/spokjaktsverige",fb:"",
    podcast:"",website:"https://spokjaktsverige.se",
    bestPlace:"Hötorgshallens källare, Stockholm",
    bestReason:"Det enda stället jag fångat på film en sittande gestalt som rör sig i bild över 4 sekunder. Kameran var fastställd och låst.",
    upcoming:"Ny YouTube-serie 'Källaren under Stockholm' — premiär juni 2026. Tar bokningar för företagsundersökningar.",
    visitedPlaces:[
      {name:"Hötorgshallen",country:"Sverige",spook:5},
      {name:"Häringe slott",country:"Sverige",spook:4},
      {name:"Carlsten fästning",country:"Sverige",spook:3},
    ],
  },
  {
    id:"h3",name:"Jenny & Johanna",verified:true,speciality:"Nattundersökningar",since:"2019",places:28,
    tier:"premium",
    img:"https://www.spokkartan.se/wp-content/uploads/2025/11/613800CD-0D47-474D-8B4D-8492EC3D693F.jpg",
    tagline:"Borgvattnets veteraner — nattövernattningar i Sveriges mest hemsökta prästgård.",
    bio:"Vi är Jenny och Johanna — väninnor från Östersund som upptäckte spökjakt 2019 och fastnade direkt. Sedan dess har vi sovit i Borgvattnets prästgård 14 gånger och dokumenterar varje natt. Vi vill att fler ska våga övernatta själva.",
    yt:"",ig:"https://instagram.com/jenny_johanna_spokjakt",fb:"",
    podcast:"",website:"",
    bestPlace:"Borgvattnets prästgård",
    bestReason:"Det är vårt hem nu. Vi känner husets rytmer — när det är 'aktivt' och när det är lugnt. Inget slår att stå i den övre korridoren kl 03:00.",
    upcoming:"Bok om Borgvattnet planeras till hösten 2026. Kör guidade nattvisningar för 4–6 personer en gång i månaden.",
    visitedPlaces:[
      {name:"Borgvattnets prästgård",country:"Sverige",spook:5},
      {name:"Frösö kyrka",country:"Sverige",spook:3},
      {name:"Tännäs gamla fjällgård",country:"Sverige",spook:4},
    ],
  },
];

const FLAG={Sverige:"🇸🇪",Norge:"🇳🇴",Danmark:"🇩🇰",UK:"🇬🇧",Storbritannien:"🇬🇧",USA:"🇺🇸",Tyskland:"🇩🇪",Finland:"🇫🇮",Polen:"🇵🇱",Nederländerna:"🇳🇱",Italien:"🇮🇹"};
const TYPE_ICON={Slott:"🏰",Hotell:"🛎️",Ruin:"🏚️",Kyrka:"⛪",Prästgård:"🕯️",Spökhus:"👻",Sanatorium:"🏥",Fängelse:"⚔️",Kyrkogård:"⚰️",Övergiven:"🏗️",Herrgård:"🏯",Fästning:"🗡️",Urban:"🚇",Skog:"🌲",Museum:"🏛️"};

// Dela en lång text i läsbara stycken.
// 1) Föredrar dubbla newlines (\n\n)
// 2) Annars enkla newlines
// 3) Sist: dela på meningar — en ny paragraf var ~3:e mening
function splitParagraphs(text) {
  if (!text) return [];
  const trimmed = String(text).trim();
  if (!trimmed) return [];

  // Dubbla newlines
  if (/\n\s*\n/.test(trimmed)) {
    return trimmed.split(/\n\s*\n+/).map(s=>s.trim()).filter(Boolean);
  }
  // Enstaka newlines
  if (/\n/.test(trimmed)) {
    return trimmed.split(/\n+/).map(s=>s.trim()).filter(Boolean);
  }
  // Inga newlines — splitta på meningar och gruppera 3 åt gången
  const sentences = trimmed.match(/[^.!?]+[.!?]+(?:\s|$)/g) || [trimmed];
  const paras = [];
  for (let i = 0; i < sentences.length; i += 3) {
    paras.push(sentences.slice(i, i+3).join(" ").trim());
  }
  return paras.filter(Boolean);
}
const CAT_C={samarbete:"#a78bfa",tipsar:"#34d399",säljer:"#fbbf24",köper:"#60a5fa",event:"#2dd4bf"};

// ── CSS ───────────────────────────────────────────────────────
const CSS = `
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap');
:root{
  --bg:#07060f;--bg2:#0a0918;--bg3:#0f0d1e;--card:#0d0b1b;--card2:#131228;
  --b:#1c1832;--b2:#26204a;--acc:#7c3aed;--acc2:#a78bfa;--acc3:#5b21b6;
  --g:#34d399;--am:#fbbf24;--r:#f87171;--bl:#60a5fa;
  --tx:#f0ecff;--tx2:#b4a8d8;--tx3:#6b5e8a;--tx4:#352d52;
  --gold:#d4af37;--nav:52px;
}
*{box-sizing:border-box;margin:0;padding:0}
html,body,#root{height:100%;overflow:hidden}
body{font-family:'Poppins',sans-serif;background:var(--bg);color:var(--tx)}
::-webkit-scrollbar{width:3px;height:3px}
::-webkit-scrollbar-thumb{background:var(--b2);border-radius:2px}
input,select,textarea,button{font-family:'Poppins',sans-serif!important}
input::placeholder,textarea::placeholder{color:var(--tx4)!important}
select option{background:var(--card2)}

/* Leaflet — riktig karta-känsla */
.leaflet-container{background:#e8eef2!important;transition:background 0.3s;font-family:'Poppins',sans-serif!important}
.leaflet-container.lf-dark-mode{background:#0d0a1f!important}
.leaflet-tile{transition:filter 0.3s}
.leaflet-control-zoom{border:1px solid rgba(124,58,237,0.25)!important;border-radius:10px!important;overflow:hidden;box-shadow:0 4px 12px rgba(0,0,0,0.18)!important}
.leaflet-control-zoom a{background:#fff!important;border-color:rgba(124,58,237,0.18)!important;color:#5b21b6!important;width:34px!important;height:34px!important;line-height:34px!important;font-size:18px!important;font-weight:700!important}
.leaflet-control-zoom a:hover{background:#f5f0ff!important;color:#7c3aed!important}
.leaflet-container.lf-dark-mode .leaflet-control-zoom a{background:var(--card)!important;border-color:var(--b)!important;color:var(--acc2)!important}
.leaflet-control-attribution{background:rgba(255,255,255,0.85)!important;font-size:9px!important;color:#666!important;padding:1px 6px!important;border-radius:4px 0 0 0!important}
.leaflet-container.lf-dark-mode .leaflet-control-attribution{background:rgba(7,6,15,0.85)!important;color:#999!important}
.leaflet-attribution-flag{display:none!important}
.leaflet-popup-content-wrapper{background:var(--card)!important;border:1px solid var(--b2)!important;border-radius:16px!important;padding:0!important;color:var(--tx)!important;box-shadow:0 12px 40px #00000088!important}
.leaflet-popup-tip,.leaflet-popup-close-button{display:none!important}
.leaflet-popup-content{margin:0!important;width:auto!important}

/* MARKERS — drop-pin riktig karta-stil */
.sp-marker{filter:drop-shadow(0 3px 5px rgba(0,0,0,0.35))}
.sp-pin{
  position:relative;
  width:32px;height:42px;
  cursor:pointer;
  transition:transform 0.18s cubic-bezier(.16,1,.3,1);
}
.sp-pin:hover{transform:translateY(-3px) scale(1.08)}
.sp-pin-body{
  position:absolute;top:0;left:0;
  width:32px;height:32px;
  border-radius:50% 50% 50% 0;
  transform:rotate(-45deg);
  box-shadow:inset -2px -3px 6px rgba(0,0,0,0.2),0 0 0 2px #fff;
  display:flex;align-items:center;justify-content:center;
}
.sp-pin-emoji{
  transform:rotate(45deg);
  font-size:15px;line-height:1;
}
.sp-pin-shadow{
  position:absolute;
  bottom:-2px;left:50%;
  transform:translateX(-50%);
  width:14px;height:4px;
  background:rgba(0,0,0,0.3);
  border-radius:50%;
  filter:blur(2px);
}
.sp-pin.featured .sp-pin-body{box-shadow:inset -2px -3px 6px rgba(0,0,0,0.2),0 0 0 2px #fff,0 0 0 4px rgba(212,175,55,0.6)}
.sp-pin.scary-5 .sp-pin-body{background:linear-gradient(135deg,#dc2626,#7c2d12)}
.sp-pin.scary-4 .sp-pin-body{background:linear-gradient(135deg,#9333ea,#5b21b6)}
.sp-pin.scary-3 .sp-pin-body{background:linear-gradient(135deg,#7c3aed,#6d28d9)}
.sp-pin.scary-2 .sp-pin-body{background:linear-gradient(135deg,#a78bfa,#7c3aed)}
.sp-pin.scary-1 .sp-pin-body{background:linear-gradient(135deg,#c4b5fd,#a78bfa)}
.sp-pin.bookable .sp-pin-body{box-shadow:inset -2px -3px 6px rgba(0,0,0,0.2),0 0 0 2px #fff,0 0 0 3px rgba(52,211,153,0.7)}
.sp-pin-bookable{
  position:absolute;top:-4px;right:-4px;
  background:linear-gradient(135deg,#34d399,#059669);
  border-radius:50%;
  width:18px;height:18px;
  display:flex;align-items:center;justify-content:center;
  font-size:9px;
  border:2px solid #fff;
  box-shadow:0 2px 4px rgba(0,0,0,0.3);
}

/* Karta-legend */
.sp-legend{
  position:absolute;bottom:14px;right:14px;
  background:rgba(255,255,255,0.96);
  border:1px solid rgba(124,58,237,0.2);
  border-radius:11px;
  padding:9px 12px;
  font-size:10px;
  font-weight:600;
  color:#1a0a36;
  box-shadow:0 4px 14px rgba(0,0,0,0.18);
  z-index:400;
  backdrop-filter:blur(6px);
  -webkit-backdrop-filter:blur(6px);
  display:flex;flex-direction:column;gap:5px;
}
.leaflet-container.lf-dark-mode + .sp-legend,
.lf-dark-mode .sp-legend{
  background:rgba(13,11,27,0.92);
  border-color:rgba(167,139,250,0.3);
  color:#f0ecff;
}
.sp-legend-row{display:flex;gap:6px;align-items:center}
.sp-legend-dot{width:10px;height:10px;border-radius:50%;flex-shrink:0;border:1.5px solid #fff;box-shadow:0 1px 2px rgba(0,0,0,0.2)}

@keyframes fup{from{opacity:0;transform:translateY(14px)}to{opacity:1;transform:none}}
@keyframes spin{to{transform:rotate(360deg)}}
@keyframes float{0%,100%{transform:translateY(0)}50%{transform:translateY(-6px)}}
@keyframes scan{0%{top:-100%}100%{top:200%}}

.au{animation:fup 0.38s cubic-bezier(.16,1,.3,1) both}
.af{animation:float 4s ease-in-out infinite}

.inp{width:100%;background:var(--bg3);border:1px solid var(--b);border-radius:10px;padding:10px 13px;color:var(--tx);font-size:14px;outline:none;transition:border-color 0.2s;-webkit-appearance:none}
.inp:focus{border-color:var(--acc)}
.inp-sm{padding:7px 11px;font-size:12px;border-radius:8px}

.btn{display:inline-flex;align-items:center;justify-content:center;gap:6px;border:none;border-radius:11px;font-family:'Poppins',sans-serif!important;font-weight:600;cursor:pointer;transition:all 0.2s;letter-spacing:0.1px;-webkit-tap-highlight-color:transparent;touch-action:manipulation}
.btn-p{background:linear-gradient(135deg,#7c3aed,#5b21b6);color:#fff;box-shadow:0 4px 14px #7c3aed44;padding:12px 20px;font-size:14px}
.btn-p:active{filter:brightness(0.92);transform:scale(0.98)}
.btn-g{background:linear-gradient(135deg,#34d399,#059669);color:#fff;padding:12px 20px;font-size:14px}
.btn-gold{background:linear-gradient(135deg,#d4af37,#e8c840);color:#1a0900;font-weight:700;padding:12px 20px;font-size:14px}
.btn-ghost{background:transparent;border:1px solid var(--b2);color:var(--tx2);padding:11px 18px;font-size:13px}
.btn-ghost:active{background:var(--bg3)}
.btn-danger{background:linear-gradient(135deg,#f87171,#dc2626);color:#fff;padding:12px 20px;font-size:14px}
.btn-sm{padding:8px 14px!important;font-size:12px!important;border-radius:9px!important}
.btn-full{width:100%}
.btn:disabled{opacity:0.45;pointer-events:none}

.tag{display:inline-flex;align-items:center;padding:3px 10px;border-radius:999px;font-size:10px;font-weight:600;white-space:nowrap}
.pill{padding:7px 14px;border-radius:999px;border:1px solid var(--b2);background:transparent;color:var(--tx3);font-size:12px;font-weight:500;cursor:pointer;white-space:nowrap;-webkit-tap-highlight-color:transparent;touch-action:manipulation}
.pill.on{border-color:var(--acc);background:var(--acc);color:#fff}

/* Bottom nav (mobile) */
.bottom-nav{display:flex;background:rgba(7,6,15,0.97);border-top:1px solid var(--b);padding:0;safe-area-inset-bottom:env(safe-area-inset-bottom)}
.nav-btn{flex:1;display:flex;flex-direction:column;align-items:center;justify-content:center;padding:8px 4px 10px;gap:3px;background:none;border:none;cursor:pointer;-webkit-tap-highlight-color:transparent;touch-action:manipulation;min-height:var(--nav)}
.nav-btn span:first-child{font-size:20px;line-height:1}
.nav-btn span:last-child{font-size:9px;font-weight:600;color:var(--tx4);transition:color 0.18s}
.nav-btn.active span:last-child{color:var(--acc2)}
.nav-btn.active span:first-child{filter:drop-shadow(0 0 4px var(--acc))}

/* Card */
.card{background:var(--card);border:1px solid var(--b);border-radius:14px}
.card-tap{-webkit-tap-highlight-color:transparent;touch-action:manipulation;cursor:pointer;transition:opacity 0.15s}
.card-tap:active{opacity:0.8}

.gt{background:linear-gradient(135deg,#c4b5fd,#8b5cf6,#6d28d9);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text}

/* Scary dots */
.scary{display:flex;gap:3px}
.scary-dot{width:7px;height:7px;border-radius:50%;display:inline-block}

/* Modal overlay */
.modal-overlay{position:fixed;inset:0;background:rgba(0,0,0,0.88);backdrop-filter:blur(10px);-webkit-backdrop-filter:blur(10px);z-index:900;display:flex;align-items:flex-end;justify-content:center;padding:0}
@media(min-width:600px){.modal-overlay{align-items:center;padding:20px}}
.modal-sheet{background:var(--card);border-radius:20px 20px 0 0;width:100%;max-width:480px;max-height:92vh;overflow-y:auto;padding:20px 20px 32px;position:relative}
@media(min-width:600px){.modal-sheet{border-radius:20px;margin:0 20px;max-height:85vh}}
.modal-handle{width:40px;height:4px;background:var(--b2);border-radius:2px;margin:0 auto 20px}

/* Place card */
/* Reader prose — bättre läsbarhet */
.reader-prose{max-width:680px;margin:0 auto}
.reader-prose p{margin:0 0 14px;text-indent:0}
.reader-prose p:first-of-type::first-letter{
  font-size:2.6em;
  font-weight:700;
  float:left;
  line-height:0.95;
  margin:4px 8px 0 0;
  color:var(--acc2);
  font-family:'Poppins',sans-serif;
}
.reader-prose p:last-child{margin-bottom:0}
@media(min-width:600px){.reader-prose p{font-size:16px!important}}

.place-card{background:var(--card);border:1px solid var(--b);border-radius:14px;overflow:hidden;cursor:pointer;-webkit-tap-highlight-color:transparent;transition:opacity 0.15s}
.place-card:active{opacity:0.82}
.place-img{height:110px;background:linear-gradient(135deg,#110828,#0a0517);display:flex;align-items:center;justify-content:center;position:relative;overflow:hidden}
.place-img img{position:absolute;inset:0;width:100%;height:100%;object-fit:cover}
.place-img-fade{position:absolute;inset:0;background:linear-gradient(to top,var(--card),transparent 55%)}

/* Ebook builder */
.place-row{display:flex;gap:10px;align-items:center;padding:10px 12px;border-radius:10px;cursor:pointer;border:1px solid transparent;-webkit-tap-highlight-color:transparent;touch-action:manipulation;transition:background 0.15s}
.place-row.sel{background:rgba(124,58,237,0.12);border-color:rgba(124,58,237,0.35)}
.place-row:active{background:var(--bg3)}

/* Stories grid */
.stories-grid{display:grid;grid-template-columns:1fr 1fr;gap:10px;padding:14px}
@media(min-width:500px){.stories-grid{grid-template-columns:repeat(auto-fill,minmax(200px,1fr))}
}
/* Admin table */
.atbl{width:100%;border-collapse:collapse;font-size:11px}
.atbl th{padding:8px 10px;border-bottom:1px solid var(--b);font-weight:600;color:var(--tx3);font-size:9px;letter-spacing:1px;text-transform:uppercase;text-align:left;white-space:nowrap;position:sticky;top:0;background:var(--bg)}
.atbl td{padding:7px 10px;border-bottom:1px solid var(--b);color:var(--tx2);vertical-align:middle}
.atbl tr:active td{background:var(--bg3)}
`;

// ── ATOMS ─────────────────────────────────────────────────────
const Scary = ({n,sz=6}) => <div className="scary">{[1,2,3,4,5].map(i=><span key={i} className="scary-dot" style={{width:sz,height:sz,background:i<=n?"#7c3aed":"var(--b2)",boxShadow:i<=n?"0 0 4px #7c3aed88":"none"}}/>)}</div>;
const Tag = ({ch,c="#7c3aed",bg,style={}}) => <span className="tag" style={{background:bg||c+"20",border:`1px solid ${c}44`,color:c,...style}}>{ch}</span>;
const Spinner = () => <span style={{display:"inline-block",width:16,height:16,border:"2px solid #ffffff33",borderTopColor:"#fff",borderRadius:"50%",animation:"spin 0.7s linear infinite"}}/>;
const Btn = ({ch,onClick,v="p",sz="",full,disabled,style={}}) => <button className={`btn btn-${v}${sz?" btn-"+sz:""}${full?" btn-full":""}`} disabled={disabled} onClick={onClick} style={style}>{ch}</button>;

// ── MAP ───────────────────────────────────────────────────────
function SpokMap({places,onSelect}) {
  const layerRef = useRef(null);
  const [mapMode, setMapMode] = useState("light");
  const [mapStyle, setMapStyle] = useState("voyager"); // voyager | terrain | satellite
  const ref = useRef(null), mapRef = useRef(null), mRefs = useRef({});

  // Tile-källor — alla riktiga, tydliga karttjänster
  const TILES = {
    voyager:  { light:"https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png",
                dark: "https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png",
                attribution:"&copy; OpenStreetMap, &copy; CARTO",
                subdomains:"abcd", maxZoom:20 },
    terrain:  { light:"https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png",
                dark: "https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png",
                attribution:"&copy; OpenTopoMap (CC-BY-SA)",
                subdomains:"abc", maxZoom:17 },
    satellite:{ light:"https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}",
                dark: "https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}",
                attribution:"Tiles &copy; Esri",
                subdomains:"", maxZoom:18 },
  };

  function applyMapMode(mode) {
    if (!ref.current) return;
    if (mode === "dark") ref.current.classList.add("lf-dark-mode");
    else ref.current.classList.remove("lf-dark-mode");
  }

  function toggleMapMode() {
    const next = mapMode === "dark" ? "light" : "dark";
    setMapMode(next);
    if (typeof localStorage !== "undefined") localStorage.setItem("spokkartan_map_mode", next);
    swapTiles(next, mapStyle);
    applyMapMode(next);
  }

  function changeStyle(s) {
    setMapStyle(s);
    if (typeof localStorage !== "undefined") localStorage.setItem("spokkartan_map_style", s);
    swapTiles(mapMode, s);
  }

  function swapTiles(mode, style) {
    if (!layerRef.current?.layer || !mapRef.current) return;
    const tile = TILES[style] || TILES.voyager;
    const url = mode === "dark" ? tile.dark : tile.light;
    layerRef.current.layer.setUrl(url);
    layerRef.current.layer.options.maxZoom = tile.maxZoom;
    layerRef.current.layer.options.subdomains = tile.subdomains;
  }

  // Drop-pin marker — färgad efter scary-faktor, alltid med tema-emoji
  function mkIcon(p) {
    const scary = Math.max(1, Math.min(5, p.scary || 3));
    const featured = p.featured ? " featured" : "";
    const bookable = (p.bookable && p.booking_url) ? " bookable" : "";
    const emoji = TYPE_ICON[p.type] || FLAG[p.country] || "👻";
    const html = `
      <div class="sp-pin scary-${scary}${featured}${bookable}">
        <div class="sp-pin-body"><span class="sp-pin-emoji">${emoji}</span></div>
        <div class="sp-pin-shadow"></div>
        ${(p.bookable && p.booking_url) ? '<div class="sp-pin-bookable">🏨</div>' : ''}
      </div>`;
    return window.L.divIcon({
      className:"sp-marker",
      html,
      iconSize:[32,42],
      iconAnchor:[16,40],
      popupAnchor:[0,-34]
    });
  }

  function init(){
    if(mapRef.current||!ref.current||!window.L)return;
    const map = window.L.map(ref.current, {
      center:[59,14], zoom:5,
      zoomControl:true,
      attributionControl:true,
      preferCanvas:false,
      worldCopyJump:true,
    });

    const startMode = (typeof localStorage !== "undefined" ? localStorage.getItem("spokkartan_map_mode") : null) || "light";
    const startStyle = (typeof localStorage !== "undefined" ? localStorage.getItem("spokkartan_map_style") : null) || "voyager";
    const tile = TILES[startStyle] || TILES.voyager;
    const url = startMode === "dark" ? tile.dark : tile.light;

    const layer = window.L.tileLayer(url, {
      maxZoom: tile.maxZoom,
      subdomains: tile.subdomains,
      attribution: tile.attribution,
      crossOrigin: true,
    }).addTo(map);

    layerRef.current = { layer };
    setMapMode(startMode);
    setMapStyle(startStyle);
    applyMapMode(startMode);
    mapRef.current = map;

    places.filter(p=>p.lat&&p.lng).forEach(p=>{
      const m = window.L.marker([p.lat,p.lng], {icon: mkIcon(p), riseOnHover:true})
        .addTo(map)
        .on("click", ()=>onSelect(p));
      mRefs.current[p.id] = m;
    });
  }

  useEffect(()=>{
    if(!document.getElementById("lf-css")){const l=document.createElement("link");l.id="lf-css";l.rel="stylesheet";l.href=LF_CSS;document.head.appendChild(l);}
    if(window.L){init();return;}
    const s=document.createElement("script");s.src=LF_JS;s.onload=init;document.head.appendChild(s);
    return()=>{if(mapRef.current){mapRef.current.remove();mapRef.current=null;mRefs.current={};}};
  },[]);

  const ctrlBtn = (active) => ({
    background: active ? "linear-gradient(135deg,#7c3aed,#5b21b6)" : "rgba(255,255,255,0.96)",
    border: active ? "1px solid #7c3aed" : "1px solid rgba(124,58,237,0.18)",
    color: active ? "#fff" : "#1a0a36",
    borderRadius: 8,
    padding: "7px 11px",
    fontSize: 11,
    fontWeight: 700,
    cursor: "pointer",
    boxShadow: "0 2px 8px rgba(0,0,0,0.15)",
    backdropFilter: "blur(6px)",
    WebkitBackdropFilter: "blur(6px)",
    transition: "all 0.15s",
  });

  return (
    <div style={{position:"relative",width:"100%",height:"100%"}}>
      {/* Stil-väljare top-left */}
      <div style={{position:"absolute",top:12,left:12,zIndex:1000,display:"flex",gap:5,background:"rgba(255,255,255,0.92)",padding:4,borderRadius:10,border:"1px solid rgba(124,58,237,0.18)",boxShadow:"0 3px 10px rgba(0,0,0,0.15)",backdropFilter:"blur(6px)",WebkitBackdropFilter:"blur(6px)"}}>
        {[
          ["voyager","🗺️","Standard"],
          ["terrain","⛰️","Terräng"],
          ["satellite","🛰️","Satellit"],
        ].map(([code,icon,label])=>(
          <button key={code} onClick={()=>changeStyle(code)} title={label} style={{...ctrlBtn(mapStyle===code),padding:"6px 9px",fontSize:11,boxShadow:"none",border:"none",background:mapStyle===code?"linear-gradient(135deg,#7c3aed,#5b21b6)":"transparent",color:mapStyle===code?"#fff":"#1a0a36"}}>
            <span style={{fontSize:13}}>{icon}</span>
          </button>
        ))}
      </div>

      {/* Tema-toggle top-right */}
      <button onClick={toggleMapMode} style={{position:"absolute",top:12,right:12,zIndex:1000,...ctrlBtn(false),display:"flex",alignItems:"center",gap:5}} title="Växla mellan ljust/mörkt karttema">
        <span style={{fontSize:13}}>{mapMode === "dark" ? "☀️" : "🌙"}</span>
        <span>{mapMode === "dark" ? "Ljust" : "Mörkt"}</span>
      </button>

      {/* Legend bottom-right */}
      <div className="sp-legend">
        <div style={{fontSize:9,fontWeight:700,letterSpacing:1,textTransform:"uppercase",color:"#7c3aed",marginBottom:1}}>Spökfaktor</div>
        <div className="sp-legend-row"><span className="sp-legend-dot" style={{background:"linear-gradient(135deg,#dc2626,#7c2d12)"}}/>Ohyggligt (5)</div>
        <div className="sp-legend-row"><span className="sp-legend-dot" style={{background:"linear-gradient(135deg,#9333ea,#5b21b6)"}}/>Mycket aktivt (4)</div>
        <div className="sp-legend-row"><span className="sp-legend-dot" style={{background:"linear-gradient(135deg,#7c3aed,#6d28d9)"}}/>Aktivt (3)</div>
        <div className="sp-legend-row"><span className="sp-legend-dot" style={{background:"linear-gradient(135deg,#a78bfa,#7c3aed)"}}/>Lugnt (1–2)</div>
        <div className="sp-legend-row"><span className="sp-legend-dot" style={{background:"linear-gradient(135deg,#34d399,#059669)"}}/>🏨 Bokningsbart</div>
      </div>

      <div ref={ref} style={{width:"100%",height:"100%"}}/>
    </div>
  );
}

// ── AUTH MODAL ────────────────────────────────────────────────
function AuthModal({initMode,onClose,onSuccess}) {
  const [mode,setMode]=useState(initMode||"login");
  const [name,setName]=useState("");
  const [email,setEmail]=useState(initMode==="admin"?ADMIN_EMAIL:"");
  const [pass,setPass]=useState("");
  const [isHunter,setIsHunter]=useState(false);
  const [bio,setBio]=useState(""); const [yt,setYt]=useState(""); const [ig,setIg]=useState("");
  const [recovEmail,setRecovEmail]=useState("");
  const [recovCode,setRecovCode]=useState("");
  const [genCode,setGenCode]=useState("");
  const [newPass,setNewPass]=useState(""); const [newPass2,setNewPass2]=useState("");
  const [err,setErr]=useState(""); const [msg,setMsg]=useState("");
  const [loading,setLoading]=useState(false);
  const [showP,setShowP]=useState(false);

  const isAdminMode = initMode==="admin";

  async function doLogin(e){
    e?.preventDefault();
    setErr("");setLoading(true);
    await new Promise(r=>setTimeout(r,600));
    const key=email.trim().toLowerCase();
    const u=USERS_DB[key];
    if(!u||u.pass!==pass){setErr("Fel e-post eller lösenord.");setLoading(false);return;}
    onSuccess(u);
  }
  async function doRegister(e){
    e?.preventDefault();
    setErr("");setLoading(true);
    await new Promise(r=>setTimeout(r,700));
    if(!name.trim()||!email.trim()||!pass){setErr("Fyll i namn, e-post och lösenord.");setLoading(false);return;}
    if(pass.length<6){setErr("Lösenordet måste vara minst 6 tecken.");setLoading(false);return;}
    const key=email.trim().toLowerCase();
    if(USERS_DB[key]){setErr("E-posten är redan registrerad.");setLoading(false);return;}
    const u={id:`u${Date.now()}`,name:name.trim(),email:key,pass,
      role:isHunter?"pending_hunter":"user",pro:false,
      bio,yt,ig,fb:"",created:new Date().toISOString().slice(0,10),
      verified:!isHunter,avatar:""};
    USERS_DB[key]=u;
    onSuccess(u);
  }
  async function doRecovSend(e){
    e?.preventDefault();
    setErr("");setLoading(true);
    await new Promise(r=>setTimeout(r,800));
    const u=USERS_DB[recovEmail.trim().toLowerCase()];
    if(!u){setErr("Ingen användare med den e-postadressen.");setLoading(false);return;}
    const code=String(Math.floor(100000+Math.random()*900000));
    setGenCode(code);
    setMsg(`Kod skickad! (Demo: koden är ${code})`);
    setMode("recov_code");setLoading(false);
  }
  async function doRecovCode(e){
    e?.preventDefault();
    if(recovCode.trim()!==genCode){setErr("Fel kod.");return;}
    setMode("recov_pass");setMsg("");setErr("");
  }
  async function doRecovPass(e){
    e?.preventDefault();
    if(newPass.length<6){setErr("Minst 6 tecken.");return;}
    if(newPass!==newPass2){setErr("Lösenorden matchar inte.");return;}
    setLoading(true);
    await new Promise(r=>setTimeout(r,500));
    USERS_DB[recovEmail.trim().toLowerCase()].pass=newPass;
    // Also update admin if it's admin
    if(recovEmail.trim().toLowerCase()===ADMIN_EMAIL) USERS_DB[ADMIN_EMAIL].pass=newPass;
    setLoading(false);
    setMode("login");setMsg("✅ Lösenordet uppdaterat!");setEmail(recovEmail);setPass("");
  }

  const T={login:"Logga in",register:"Skapa konto",admin:"Admin Login",recovery:"Glömt lösenord",recov_code:"Ange koden",recov_pass:"Nytt lösenord"};
  const lbl={fontSize:11,fontWeight:600,color:"var(--tx3)",marginBottom:4,letterSpacing:0.3,display:"block"};

  return(
    <div className="modal-overlay" onClick={e=>{if(e.target===e.currentTarget)onClose();}}>
      <div className="modal-sheet au">
        <div className="modal-handle"/>
        <button onClick={onClose} style={{position:"absolute",top:16,right:16,background:"none",border:"none",color:"var(--tx3)",cursor:"pointer",fontSize:22,lineHeight:1,padding:4}}>✕</button>

        <div style={{textAlign:"center",marginBottom:20}}>
          <div style={{fontSize:36,marginBottom:8}} className={mode==="admin"?"":"af"}>
            {mode==="admin"?"⚙️":"👻"}
          </div>
          <h2 style={{fontSize:20,fontWeight:800,color:"var(--tx)",marginBottom:3}}>{T[mode]||"Konto"}</h2>
          {mode==="login"&&!isAdminMode&&<p style={{fontSize:12,color:"var(--tx3)"}}>Välkommen tillbaka till Spökkartan</p>}
          {mode==="admin"&&<p style={{fontSize:12,color:"var(--tx3)"}}>Spökkartan Admin Dashboard</p>}
        </div>

        {/* ── Google login button (skickas direkt till OAuth) ── */}
        {(mode==="login"||mode==="register")&&!isAdminMode&&(
          <>
            <button
              type="button"
              onClick={async ()=>{
                try { setErr(""); await signInWithGoogle(); }
                catch(e){ setErr("Google-login fel: "+e.message); }
              }}
              style={{width:"100%",background:"#fff",color:"#1f1f1f",border:"none",borderRadius:11,padding:"12px 16px",fontSize:14,fontWeight:600,cursor:"pointer",display:"flex",alignItems:"center",justifyContent:"center",gap:10,marginBottom:14,boxShadow:"0 1px 2px rgba(0,0,0,0.18)"}}
            >
              <svg width="18" height="18" viewBox="0 0 24 24" aria-hidden="true">
                <path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"/>
                <path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"/>
                <path fill="#FBBC05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"/>
                <path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"/>
              </svg>
              Fortsätt med Google
            </button>
            <div style={{display:"flex",alignItems:"center",gap:10,margin:"4px 0 14px"}}>
              <div style={{flex:1,height:1,background:"var(--b)"}}/>
              <span style={{fontSize:11,color:"var(--tx4)"}}>eller med e-post</span>
              <div style={{flex:1,height:1,background:"var(--b)"}}/>
            </div>
          </>
        )}

        {/* Status message */}
        {msg&&<div style={{background:msg.startsWith("✅")?"rgba(52,211,153,0.1)":"rgba(96,165,250,0.08)",border:`1px solid ${msg.startsWith("✅")?"rgba(52,211,153,0.35)":"rgba(96,165,250,0.3)"}`,borderRadius:10,padding:"10px 13px",fontSize:12,color:msg.startsWith("✅")?"#34d399":"#60a5fa",marginBottom:16,lineHeight:1.5}}>{msg}</div>}

        {/* 19 kr offer */}
        {(mode==="login"||mode==="register")&&!isAdminMode&&(
          <div style={{background:"rgba(212,175,55,0.08)",border:"1px solid rgba(212,175,55,0.3)",borderRadius:12,padding:"11px 14px",marginBottom:16}}>
            <div style={{fontSize:12,fontWeight:700,color:"#d4af37",marginBottom:2}}>🎉 Ny användare? Prova PRO för 19 kr första månaden</div>
            <div style={{fontSize:10,color:"var(--tx3)"}}>Sedan 49 kr/mån · Avbryt när som helst</div>
          </div>
        )}

        {/* LOGIN */}
        {(mode==="login"||mode==="admin")&&(
          <form onSubmit={doLogin} style={{display:"flex",flexDirection:"column",gap:14}}>
            <div><label style={lbl}>E-POSTADRESS</label>
              <input className="inp" type="email" value={email} onChange={e=>setEmail(e.target.value)} placeholder="din@email.com" autoComplete="email" required/>
            </div>
            <div>
              <div style={{display:"flex",justifyContent:"space-between",marginBottom:4}}>
                <span style={lbl}>LÖSENORD</span>
                {mode==="login"&&<span style={{fontSize:11,color:"#a78bfa",cursor:"pointer"}} onClick={()=>{setMode("recovery");setErr("");setMsg("");setRecovEmail(email);}}>Glömt lösenord?</span>}
                {mode==="admin"&&<span style={{fontSize:11,color:"#a78bfa",cursor:"pointer"}} onClick={()=>{setMode("recovery");setErr("");setMsg("");setRecovEmail(ADMIN_EMAIL);}}>Glömt?</span>}
              </div>
              <div style={{position:"relative"}}>
                <input className="inp" type={showP?"text":"password"} value={pass} onChange={e=>setPass(e.target.value)} placeholder="••••••••" style={{paddingRight:44}} autoComplete="current-password" required/>
                <button type="button" onClick={()=>setShowP(s=>!s)} style={{position:"absolute",right:12,top:"50%",transform:"translateY(-50%)",background:"none",border:"none",cursor:"pointer",fontSize:16,color:"var(--tx3)",padding:4}}>{showP?"🙈":"👁️"}</button>
              </div>
            </div>
            {err&&<div style={{background:"rgba(248,113,113,0.12)",border:"1px solid rgba(248,113,113,0.35)",borderRadius:9,padding:"10px 13px",fontSize:13,color:"#f87171"}}>{err}</div>}
            <button type="submit" className="btn btn-p btn-full" disabled={loading} style={{marginTop:4}}>
              {loading?<Spinner/>:(mode==="admin"?"Logga in som admin →":"Logga in →")}
            </button>
            {mode==="login"&&<div style={{textAlign:"center",fontSize:12,color:"var(--tx4)"}}>Ny här? <span style={{color:"#a78bfa",cursor:"pointer"}} onClick={()=>{setMode("register");setErr("");setMsg("");}}>Skapa konto</span></div>}
          </form>
        )}

        {/* REGISTER */}
        {mode==="register"&&(
          <form onSubmit={doRegister} style={{display:"flex",flexDirection:"column",gap:12}}>
            <div><label style={lbl}>DITT NAMN</label><input className="inp" value={name} onChange={e=>setName(e.target.value)} placeholder="Förnamn Efternamn" required autoFocus/></div>
            <div><label style={lbl}>E-POSTADRESS</label><input className="inp" type="email" value={email} onChange={e=>setEmail(e.target.value)} placeholder="din@email.com" autoComplete="email" required/></div>
            <div>
              <label style={lbl}>LÖSENORD (min. 6 tecken)</label>
              <div style={{position:"relative"}}>
                <input className="inp" type={showP?"text":"password"} value={pass} onChange={e=>setPass(e.target.value)} placeholder="••••••••" style={{paddingRight:44}} required/>
                <button type="button" onClick={()=>setShowP(s=>!s)} style={{position:"absolute",right:12,top:"50%",transform:"translateY(-50%)",background:"none",border:"none",cursor:"pointer",fontSize:16,color:"var(--tx3)",padding:4}}>{showP?"🙈":"👁️"}</button>
              </div>
            </div>
            <label style={{display:"flex",gap:10,alignItems:"flex-start",cursor:"pointer",background:"var(--bg3)",border:`1px solid ${isHunter?"#7c3aed":"var(--b)"}`,borderRadius:11,padding:"12px 13px",transition:"border-color 0.2s"}}>
              <input type="checkbox" checked={isHunter} onChange={e=>setIsHunter(e.target.checked)} style={{accentColor:"#7c3aed",width:18,height:18,marginTop:1,flexShrink:0}}/>
              <div><div style={{fontSize:13,fontWeight:600,color:"var(--tx)"}}>🔍 Registrera mig som Spökjägare</div><div style={{fontSize:11,color:"var(--tx4)",marginTop:2}}>Kräver verifiering av admin. Ger tillgång till Anslagstavlan.</div></div>
            </label>
            {isHunter&&(
              <>
                <div><label style={lbl}>BIO (valfritt)</label><textarea className="inp" value={bio} onChange={e=>setBio(e.target.value)} rows={2} style={{resize:"none"}} placeholder="Berätta om din spökjakt…"/></div>
                <div style={{display:"grid",gridTemplateColumns:"1fr 1fr",gap:8}}>
                  <div><label style={lbl}>YOUTUBE</label><input className="inp inp-sm" value={yt} onChange={e=>setYt(e.target.value)} placeholder="youtube.com/…"/></div>
                  <div><label style={lbl}>INSTAGRAM</label><input className="inp inp-sm" value={ig} onChange={e=>setIg(e.target.value)} placeholder="instagram.com/…"/></div>
                </div>
              </>
            )}
            {err&&<div style={{background:"rgba(248,113,113,0.12)",border:"1px solid rgba(248,113,113,0.35)",borderRadius:9,padding:"10px 13px",fontSize:13,color:"#f87171"}}>{err}</div>}
            <button type="submit" className="btn btn-p btn-full" disabled={loading}>{loading?<Spinner/>:"Skapa konto →"}</button>
            <div style={{textAlign:"center",fontSize:12,color:"var(--tx4)"}}>Har konto? <span style={{color:"#a78bfa",cursor:"pointer"}} onClick={()=>{setMode("login");setErr("");setMsg("");}}>Logga in</span></div>
          </form>
        )}

        {/* RECOVERY */}
        {mode==="recovery"&&(
          <form onSubmit={doRecovSend} style={{display:"flex",flexDirection:"column",gap:12}}>
            <div><label style={lbl}>DIN E-POSTADRESS</label><input className="inp" type="email" value={recovEmail} onChange={e=>setRecovEmail(e.target.value)} required autoFocus placeholder="din@email.com"/></div>
            {err&&<div style={{background:"rgba(248,113,113,0.12)",border:"1px solid rgba(248,113,113,0.35)",borderRadius:9,padding:"10px 13px",fontSize:13,color:"#f87171"}}>{err}</div>}
            <button type="submit" className="btn btn-p btn-full" disabled={loading}>{loading?<Spinner/>:"Skicka återställningskod →"}</button>
            <button type="button" onClick={()=>{setMode(isAdminMode?"admin":"login");setErr("");}} style={{background:"none",border:"none",fontSize:12,color:"var(--tx3)",cursor:"pointer",textAlign:"center"}}>← Tillbaka</button>
          </form>
        )}
        {mode==="recov_code"&&(
          <form onSubmit={doRecovCode} style={{display:"flex",flexDirection:"column",gap:12}}>
            <div><label style={lbl}>KOD (6 SIFFROR)</label><input className="inp" value={recovCode} onChange={e=>setRecovCode(e.target.value.replace(/\D/g,"").slice(0,6))} maxLength={6} style={{letterSpacing:8,fontSize:22,textAlign:"center",fontWeight:700}} autoFocus/></div>
            {err&&<div style={{background:"rgba(248,113,113,0.12)",border:"1px solid rgba(248,113,113,0.35)",borderRadius:9,padding:"10px 13px",fontSize:13,color:"#f87171"}}>{err}</div>}
            <button type="submit" className="btn btn-p btn-full">Verifiera →</button>
          </form>
        )}
        {mode==="recov_pass"&&(
          <form onSubmit={doRecovPass} style={{display:"flex",flexDirection:"column",gap:12}}>
            <div><label style={lbl}>NYTT LÖSENORD</label>
              <div style={{position:"relative"}}>
                <input className="inp" type={showP?"text":"password"} value={newPass} onChange={e=>setNewPass(e.target.value)} style={{paddingRight:44}} autoFocus required/>
                <button type="button" onClick={()=>setShowP(s=>!s)} style={{position:"absolute",right:12,top:"50%",transform:"translateY(-50%)",background:"none",border:"none",cursor:"pointer",fontSize:16,color:"var(--tx3)",padding:4}}>{showP?"🙈":"👁️"}</button>
              </div>
            </div>
            <div><label style={lbl}>BEKRÄFTA</label><input className="inp" type="password" value={newPass2} onChange={e=>setNewPass2(e.target.value)} required/>
              {newPass2&&newPass!==newPass2&&<div style={{fontSize:11,color:"#f87171",marginTop:4}}>Matchar inte</div>}
            </div>
            {err&&<div style={{background:"rgba(248,113,113,0.12)",border:"1px solid rgba(248,113,113,0.35)",borderRadius:9,padding:"10px 13px",fontSize:13,color:"#f87171"}}>{err}</div>}
            <button type="submit" className="btn btn-g btn-full" disabled={loading||newPass.length<6||newPass!==newPass2}>{loading?<Spinner/>:"✅ Spara nytt lösenord"}</button>
          </form>
        )}
      </div>
    </div>
  );
}

// ── PRO MODAL ─────────────────────────────────────────────────
function ProModal({onClose,onSuccess,isPro}) {
  const [step,setStep]=useState("pick"); // pick | done
  const [method,setMethod]=useState("");
  const [loading,setLoading]=useState(false);

  function pay(m){
    setMethod(m);setLoading(true);
    // Redirect to Stripe Payment Link — intro for new users (19kr), full for upgraders
    const url = isPro ? "https://buy.stripe.com/5kQ3cu12naMk64l8im3oA03" : "https://buy.stripe.com/9B614m3av07GcsJdCG3oA02";
    setTimeout(()=>{ window.location.href = url; }, 200);
  }

  return(
    <div className="modal-overlay" onClick={e=>{if(e.target===e.currentTarget)onClose();}}>
      <div className="modal-sheet au">
        <div className="modal-handle"/>
        <button onClick={onClose} style={{position:"absolute",top:16,right:16,background:"none",border:"none",color:"var(--tx3)",cursor:"pointer",fontSize:22,padding:4}}>✕</button>

        {step==="pick"&&(
          <>
            <div style={{textAlign:"center",marginBottom:16}}>
              <div style={{fontSize:38,marginBottom:8}} className="af">👻</div>
              <h2 style={{fontSize:20,fontWeight:800,color:"var(--tx)",marginBottom:4}}>Ghost Hunter PRO</h2>
              {/* 19 kr offer */}
              <div style={{background:"rgba(212,175,55,0.1)",border:"1px solid rgba(212,175,55,0.35)",borderRadius:12,padding:"12px 16px",margin:"12px 0",textAlign:"left"}}>
                <div style={{fontSize:13,fontWeight:700,color:"#d4af37",marginBottom:2}}>🎉 Introduktionserbjudande</div>
                <div style={{display:"flex",alignItems:"baseline",gap:8}}>
                  <span style={{fontSize:28,fontWeight:900,color:"#d4af37"}}>19 kr</span>
                  <span style={{fontSize:13,color:"var(--tx3)"}}>första månaden</span>
                </div>
                <div style={{fontSize:11,color:"var(--tx4)",marginTop:2}}>Sedan 49 kr/mån · Avbryt när som helst</div>
              </div>
            </div>
            {/* What you get */}
            <div style={{background:"var(--bg3)",borderRadius:11,padding:"12px 14px",marginBottom:16}}>
              {["Alla 308+ platser upplåsta","GPS-koordinater & navigering","Roadtrip-planerare","Anslagstavlan (spökjägare)","E-bok-builder — alla platser"].map(f=>(
                <div key={f} style={{fontSize:12,color:"var(--tx2)",display:"flex",gap:8,alignItems:"center",padding:"4px 0"}}>
                  <span style={{color:"#34d399",fontSize:11}}>✓</span>{f}
                </div>
              ))}
            </div>
            {/* Payment methods (Stripe Checkout handles Card, Swish, Klarna) */}
            <div style={{display:"flex",flexDirection:"column",gap:10}}>
              {[["🔒","Fortsätt till säker betalning →"]].map(([icon,label],i)=>(
                <button key={i} onClick={()=>pay(label)} disabled={loading} style={{background:"var(--bg3)",border:"1px solid var(--b)",borderRadius:13,padding:"14px 16px",cursor:"pointer",display:"flex",gap:12,alignItems:"center",width:"100%",transition:"border-color 0.18s"}} onTouchStart={e=>e.currentTarget.style.borderColor="#7c3aed"} onTouchEnd={e=>e.currentTarget.style.borderColor="var(--b)"}>
                  <span style={{fontSize:22}}>{loading&&method===label?<Spinner/>:icon}</span>
                  <span style={{fontSize:14,fontWeight:500,color:"var(--tx)"}}>{label}</span>
                </button>
              ))}
            </div>
            <div style={{textAlign:"center",fontSize:11,color:"var(--tx4)",marginTop:12}}>🔒 Säker betalning · Ingen bindningstid</div>
          </>
        )}
        {step==="done"&&(
          <div style={{textAlign:"center",padding:"20px 0"}}>
            <div style={{fontSize:52,marginBottom:12}}>🎉</div>
            <h2 style={{fontSize:20,fontWeight:800,color:"var(--tx)",marginBottom:6}}>Välkommen, Ghost Hunter!</h2>
            <p style={{fontSize:13,color:"var(--tx2)"}}>Alla 308 platser är nu upplåsta. Laddar…</p>
          </div>
        )}
      </div>
    </div>
  );
}

// ── PLACE POPUP (map) ─────────────────────────────────────────
function PlacePopup({place,isPro,onRead,onClose,onAddRoadtrip,inRoadtrip}) {
  const locked=!place.free&&!isPro;
  return(
    <div className="modal-overlay" onClick={e=>{if(e.target===e.currentTarget)onClose();}}>
      <div className="modal-sheet au" style={{padding:0,overflow:"hidden"}}>
        {/* Image header */}
        <div style={{height:130,background:"linear-gradient(135deg,#110828,#0a0517)",position:"relative",overflow:"hidden"}}>
          {place.img&&<img src={place.img} alt="" style={{position:"absolute",inset:0,width:"100%",height:"100%",objectFit:"cover",opacity:0.5}} onError={e=>e.target.style.display="none"}/>}
          <div style={{position:"absolute",inset:0,background:"linear-gradient(to top,rgba(7,6,15,0.95),transparent 55%)"}}/>
          <button onClick={onClose} style={{position:"absolute",top:12,right:12,background:"rgba(0,0,0,0.5)",border:"none",color:"#fff",fontSize:14,cursor:"pointer",borderRadius:"50%",width:28,height:28,display:"flex",alignItems:"center",justifyContent:"center"}}>✕</button>
          <div style={{position:"absolute",top:10,left:12,display:"flex",gap:5}}>
            {place.free?<Tag ch="GRATIS" c="#34d399"/>:<Tag ch="PRO" c="#a78bfa"/>}
          </div>
          <div style={{position:"absolute",bottom:10,left:12}}><Scary n={place.scary||3}/></div>
        </div>
        <div style={{padding:"14px 18px 24px"}}>
          <div style={{fontSize:10,color:"var(--tx3)",marginBottom:4}}>{FLAG[place.country]||"🌍"} {place.region} · {place.type}</div>
          <div style={{fontSize:17,fontWeight:700,color:"var(--tx)",marginBottom:6,lineHeight:1.3}}>{place.name}</div>
          <div style={{fontSize:12,color:"var(--tx3)",lineHeight:1.6,marginBottom:14}}>{place.teaser?.slice(0,100)}…</div>
          <Btn ch={locked?"🔒 Kräver PRO":"Läs berättelsen →"} v="p" full onClick={()=>{onClose();onRead(place);}} style={{marginBottom:10}}/>
          <button onClick={()=>{onAddRoadtrip(place.id);onClose();}} style={{width:"100%",background:inRoadtrip?"rgba(251,191,36,0.1)":"transparent",border:`1px solid ${inRoadtrip?"#fbbf24":"var(--b)"}`,borderRadius:10,padding:"11px",fontSize:12,fontWeight:600,color:inRoadtrip?"#fbbf24":"var(--tx4)",cursor:"pointer"}}>
            {inRoadtrip?"✓ I din roadtrip":"+ Lägg till roadtrip"}
          </button>
        </div>
      </div>
    </div>
  );
}

// ── READER ────────────────────────────────────────────────────
function Reader({place,allPlaces,isPro,onClose,onNavigate,upgrade,roadtrip,setRoadtrip,visited,setVisited,user,onShare}) {
  const locked=!place.free&&!isPro;
  // Build gallery: prefer place.images array, fallback to single img
  const gallery = (Array.isArray(place.images) && place.images.length > 0)
    ? place.images
    : (place.img ? [{url:place.img,license:place.img_credit||'',author:place.img_author||'',source_url:''}] : []);
  const [currentImg,setCurrentImg]=useState(0);
  const activeImg = gallery[currentImg] || null;
  const hasImg = !!activeImg;

  // Prev / Next navigation
  const idx=allPlaces.findIndex(p=>p.id===place.id);
  const prev=idx>0?allPlaces[idx-1]:null;
  const next=idx<allPlaces.length-1?allPlaces[idx+1]:null;

  // Related: same type or same country, max 4
  const related=allPlaces
    .filter(p=>p.id!==place.id&&(p.type===place.type||p.country===place.country))
    .sort(()=>Math.random()-0.5)
    .slice(0,4);

  // Haunted hotel suggestion if place is a hotel/castle or scary>=4
  const hotelSuggestions=HAUNTED_HOTELS
    .filter(h=>h.country===place.country||h.scary>=4)
    .slice(0,2);

  const isVisited=visited.includes(place.id);

  return(
    <div style={{position:"fixed",inset:0,background:"var(--bg)",zIndex:800,display:"flex",flexDirection:"column",fontFamily:"'Poppins',sans-serif"}}>
      <style>{CSS}</style>

      {/* ── Top bar ── */}
      <div style={{background:"rgba(7,6,15,0.97)",backdropFilter:"blur(16px)",WebkitBackdropFilter:"blur(16px)",borderBottom:"1px solid var(--b)",padding:"11px 14px",display:"flex",alignItems:"center",gap:8,flexShrink:0,zIndex:10}}>
        <button onClick={onClose} style={{display:"flex",alignItems:"center",gap:4,background:"none",border:"none",color:"var(--tx2)",cursor:"pointer",fontSize:14,fontWeight:500,padding:"4px 0",flexShrink:0,minWidth:70}}>
          ← Tillbaka
        </button>
        <span style={{flex:1,fontSize:12,fontWeight:600,color:"var(--tx)",overflow:"hidden",textOverflow:"ellipsis",whiteSpace:"nowrap",textAlign:"center"}}>{place.name}</span>
        <div style={{display:"flex",gap:6,flexShrink:0}}>
          <button onClick={()=>{const url=`https://spokkartan.se/${place.slug||place.id}`;if(navigator.share)navigator.share({title:place.name,text:place.teaser,url}).catch(()=>{});else onShare?.(place.name,url);}} style={{background:"var(--bg3)",border:"1px solid var(--b)",borderRadius:8,padding:"6px 10px",fontSize:12,cursor:"pointer",color:"var(--tx2)"}}>📤</button>
        </div>
      </div>

      {/* ── Scrollable content ── */}
      <div style={{flex:1,overflowY:"auto",WebkitOverflowScrolling:"touch"}}>
        <div style={{maxWidth:680,margin:"0 auto",paddingBottom:120}}>

          {/* Hero image with gallery */}
          {hasImg?(
            <>
            <div style={{height:240,position:"relative",overflow:"hidden",background:"linear-gradient(135deg,#110828,#0a0517)"}}>
              <img src={activeImg.url} alt={place.name} loading="lazy" style={{width:"100%",height:"100%",objectFit:"cover",opacity:0.78,transition:"opacity 0.3s"}} onError={e=>e.target.style.display="none"}/>
              <div style={{position:"absolute",inset:0,background:"linear-gradient(to top,var(--bg) 0%,rgba(7,6,15,0.2) 55%,transparent 100%)"}}/>
              {(activeImg.author||activeImg.license)&&(
                <a href={activeImg.source_url||"#"} target="_blank" rel="noreferrer" style={{position:"absolute",bottom:6,right:10,fontSize:9,color:"rgba(255,255,255,0.55)",textDecoration:"none",background:"rgba(0,0,0,0.4)",padding:"2px 7px",borderRadius:4}}>
                  📷 {activeImg.author?`${activeImg.author} · `:""}{activeImg.license||""}
                </a>
              )}
              {gallery.length>1&&(
                <div style={{position:"absolute",top:10,right:10,fontSize:10,fontWeight:600,color:"#fff",background:"rgba(0,0,0,0.55)",padding:"3px 8px",borderRadius:10}}>
                  {currentImg+1}/{gallery.length}
                </div>
              )}
            </div>
            {gallery.length>1&&(
              <div style={{display:"flex",gap:6,padding:"8px 12px",overflowX:"auto",WebkitOverflowScrolling:"touch",background:"var(--bg)",borderBottom:"1px solid var(--b)"}}>
                {gallery.map((g,i)=>(
                  <button key={i} onClick={()=>setCurrentImg(i)} style={{flexShrink:0,width:60,height:44,padding:0,border:`2px solid ${i===currentImg?"#a78bfa":"var(--b)"}`,borderRadius:6,overflow:"hidden",cursor:"pointer",background:"none",transition:"border-color 0.18s"}}>
                    <img src={g.url} alt="" loading="lazy" style={{width:"100%",height:"100%",objectFit:"cover",display:"block"}}/>
                  </button>
                ))}
              </div>
            )}
            </>
          ):(
            <div style={{height:100,background:"linear-gradient(135deg,#110828,#0a0517)",display:"flex",alignItems:"center",justifyContent:"center"}}>
              <span style={{fontSize:48,opacity:0.12}}>{TYPE_ICON[place.type]||"👻"}</span>
            </div>
          )}

          <div style={{padding:"18px 16px"}}>
            {/* Tags */}
            <div style={{display:"flex",gap:5,marginBottom:10,flexWrap:"wrap"}}>
              <Tag ch={`${FLAG[place.country]||"🌍"} ${place.country}`}/>
              {place.region&&<Tag ch={place.region} c="var(--tx3)"/>}
              <Tag ch={`${TYPE_ICON[place.type]||"👻"} ${place.type}`} c="var(--acc)"/>
              {place.free?<Tag ch="Gratis" c="#34d399"/>:<Tag ch="PRO" c="#a78bfa"/>}
            </div>

            <h1 style={{fontSize:"clamp(20px,5vw,30px)",fontWeight:800,color:"var(--tx)",marginBottom:8,lineHeight:1.2}}>{place.name}</h1>

            <div style={{display:"flex",gap:10,alignItems:"center",paddingBottom:14,borderBottom:"1px solid var(--b)",marginBottom:18,flexWrap:"wrap"}}>
              <Scary n={place.scary||3}/>
              {place.region&&<span style={{fontSize:11,color:"var(--tx3)"}}>{place.region}</span>}
              {isVisited&&<Tag ch="✓ Besökt" c="#34d399"/>}
            </div>

            {/* ── LOCKED ── */}
            {locked?(
              <>
                <div style={{background:"rgba(124,58,237,0.07)",border:"1px solid rgba(124,58,237,0.2)",borderRadius:12,padding:"14px 16px",marginBottom:20}}>
                  <p style={{fontSize:14,fontStyle:"italic",color:"var(--tx)",lineHeight:1.8,margin:0}}>{place.teaser}</p>
                </div>

                {/* PRO upsell */}
                <div style={{background:"linear-gradient(135deg,#1a0a36,#0d0b1a)",border:"1px solid var(--b2)",borderRadius:16,padding:"22px 18px",textAlign:"center",marginBottom:20}}>
                  <div style={{fontSize:36,marginBottom:10}} className="af">👻</div>
                  <div style={{fontSize:17,fontWeight:800,color:"var(--tx)",marginBottom:5}}>Lås upp med Ghost Hunter PRO</div>
                  <div style={{background:"rgba(212,175,55,0.1)",border:"1px solid rgba(212,175,55,0.3)",borderRadius:10,padding:"10px 14px",margin:"12px 0 16px",textAlign:"left"}}>
                    <div style={{fontSize:12,fontWeight:700,color:"#d4af37"}}>🎉 Prova för 19 kr — första månaden</div>
                    <div style={{fontSize:10,color:"var(--tx3)",marginTop:2}}>Sedan 49 kr/mån · Avbryt när som helst</div>
                  </div>
                  <Btn ch="👻 Bli Ghost Hunter →" v="p" full onClick={upgrade}/>
                </div>

                {/* Related free places */}
                <div style={{marginBottom:20}}>
                  <div style={{fontSize:11,fontWeight:700,color:"var(--tx2)",marginBottom:10}}>👻 Andra platser du kan läsa gratis</div>
                  {related.filter(p=>p.free).slice(0,3).map(p=>(
                    <div key={p.id} onClick={()=>onNavigate(p)} style={{display:"flex",gap:10,alignItems:"center",padding:"10px 12px",background:"var(--card)",border:"1px solid var(--b)",borderRadius:11,marginBottom:7,cursor:"pointer"}} onTouchStart={e=>e.currentTarget.style.background="var(--card2)"} onTouchEnd={e=>e.currentTarget.style.background="var(--card)"}>
                      <span style={{fontSize:20,flexShrink:0}}>{TYPE_ICON[p.type]||"👻"}</span>
                      <div style={{flex:1,minWidth:0}}>
                        <div style={{fontSize:12,fontWeight:600,color:"var(--tx)",overflow:"hidden",textOverflow:"ellipsis",whiteSpace:"nowrap"}}>{p.name}</div>
                        <div style={{fontSize:10,color:"var(--tx3)"}}>{FLAG[p.country]||"🌍"} {p.type} · {p.region}</div>
                      </div>
                      <Scary n={p.scary||3} sz={4}/>
                    </div>
                  ))}
                </div>
              </>
            ):(
              <>
                {/* Teaser */}
                <div style={{background:"rgba(124,58,237,0.07)",border:"1px solid rgba(124,58,237,0.2)",borderRadius:12,padding:"14px 16px",marginBottom:18}}>
                  <p style={{fontSize:14,fontStyle:"italic",color:"var(--tx)",lineHeight:1.8,margin:0}}>{place.teaser}</p>
                </div>

                {/* Description — uppdelad i stycken */}
                {place.description&&(
                  <div style={{marginBottom:24}}>
                    <div style={{fontSize:10,fontWeight:700,color:"var(--acc2)",letterSpacing:1.5,textTransform:"uppercase",marginBottom:12}}>📜 Historik & Berättelse</div>
                    <div className="reader-prose">
                      {splitParagraphs(place.description).map((para,i)=>(
                        <p key={i} style={{
                          fontSize:15,
                          color:"var(--tx)",
                          lineHeight:1.85,
                          marginBottom:14,
                          textAlign:"left"
                        }}>{para}</p>
                      ))}
                    </div>
                  </div>
                )}

                {/* GPS */}
                {place.lat&&<div style={{background:"var(--bg3)",border:"1px solid var(--b)",borderRadius:11,padding:"12px 14px",marginBottom:12,display:"flex",justifyContent:"space-between",alignItems:"center"}}>
                  <div><div style={{fontSize:9,fontWeight:700,color:"var(--tx3)",marginBottom:2,letterSpacing:1}}>📍 GPS</div><div style={{fontSize:12,fontFamily:"monospace",color:"var(--tx)"}}>{place.lat.toFixed(5)}, {place.lng?.toFixed(5)}</div></div>
                  <a href={`https://maps.google.com/?q=${place.lat},${place.lng}`} target="_blank" rel="noreferrer" style={{background:"rgba(52,211,153,0.12)",border:"1px solid rgba(52,211,153,0.3)",borderRadius:8,padding:"7px 12px",fontSize:11,fontWeight:600,color:"#34d399"}}>Navigera →</a>
                </div>}

                {/* Actions */}
                <div style={{display:"grid",gridTemplateColumns:"1fr 1fr",gap:10,marginBottom:14}}>
                  <button onClick={()=>setVisited(v=>v.includes(place.id)?v.filter(x=>x!==place.id):[...v,place.id])} style={{background:isVisited?"rgba(52,211,153,0.1)":"var(--bg3)",border:`1px solid ${isVisited?"#34d399":"var(--b)"}`,borderRadius:11,padding:"13px",cursor:"pointer",display:"flex",flexDirection:"column",alignItems:"center",gap:4,transition:"all 0.18s"}}>
                    <span style={{fontSize:22}}>{isVisited?"✅":"📍"}</span>
                    <span style={{fontSize:10,fontWeight:600,color:isVisited?"#34d399":"var(--tx3)"}}>{isVisited?"BESÖKT":"BOCKA AV"}</span>
                    {place.points&&<span style={{fontSize:9,color:"var(--tx4)"}}>{place.points}p</span>}
                  </button>
                  <button onClick={()=>setRoadtrip(r=>r.includes(place.id)?r.filter(x=>x!==place.id):[...r,place.id])} style={{background:roadtrip.includes(place.id)?"rgba(251,191,36,0.1)":"var(--bg3)",border:`1px solid ${roadtrip.includes(place.id)?"#fbbf24":"var(--b)"}`,borderRadius:11,padding:"13px",cursor:"pointer",display:"flex",flexDirection:"column",alignItems:"center",gap:4,transition:"all 0.18s"}}>
                    <span style={{fontSize:22}}>🚗</span>
                    <span style={{fontSize:10,fontWeight:600,color:roadtrip.includes(place.id)?"#fbbf24":"var(--tx3)"}}>{roadtrip.includes(place.id)?"I ROADTRIP":"+ ROADTRIP"}</span>
                  </button>
                </div>

                {/* Booking */}
                {place.bookable&&place.bookingUrl&&(
                  <a href={place.bookingUrl} target="_blank" rel="noreferrer" style={{display:"block",textAlign:"center",background:"rgba(52,211,153,0.07)",border:"1px solid rgba(52,211,153,0.22)",borderRadius:11,padding:"13px",fontSize:13,fontWeight:600,color:"#34d399",marginBottom:20}}>
                    🏨 Boka boende här (affiliate) →
                  </a>
                )}

                {/* ── Hotel upsell (om platsen är scary>=4 eller hotell i närheten) ── */}
                {hotelSuggestions.length>0&&(
                  <div style={{background:"linear-gradient(135deg,rgba(52,211,153,0.05),rgba(52,211,153,0.02))",border:"1px solid rgba(52,211,153,0.18)",borderRadius:14,padding:"16px",marginBottom:20}}>
                    <div style={{fontSize:11,fontWeight:700,color:"#34d399",marginBottom:3}}>🏨 Tänk om du kunde bo på ett hemsökt ställe?</div>
                    <div style={{fontSize:12,color:"var(--tx3)",marginBottom:12}}>
                      {place.country==="Sverige"?"I Sverige finns det faktiskt hotell och herrgårdar du kan övernatta på — och uppleva precis det du just läst om.":place.country==="Norge"?"Norge har ett par av Nordens mest kända spökhotell. Boka ett rum och ta med din ficklampa.":"Vill du sova på ett äkta hemsökt ställe? Här är ett urval nära dig."}
                    </div>
                    {hotelSuggestions.map((h,i)=>(
                      <a key={i} href={h.url} target="_blank" rel="noreferrer" style={{display:"flex",gap:10,alignItems:"center",background:"var(--card)",border:"1px solid var(--b)",borderRadius:10,padding:"11px 12px",marginBottom:i<hotelSuggestions.length-1?7:0,textDecoration:"none"}}>
                        <span style={{fontSize:22,flexShrink:0}}>🏰</span>
                        <div style={{flex:1,minWidth:0}}>
                          <div style={{fontSize:12,fontWeight:700,color:"var(--tx)",overflow:"hidden",textOverflow:"ellipsis",whiteSpace:"nowrap"}}>{h.name}</div>
                          <div style={{fontSize:10,color:"var(--tx3)"}}>{h.region} · {h.price}</div>
                        </div>
                        <div style={{fontSize:11,fontWeight:600,color:"#34d399",flexShrink:0}}>Boka →</div>
                      </a>
                    ))}
                  </div>
                )}

                {/* ── Related places ── */}
                {related.length>0&&(
                  <div style={{marginBottom:20}}>
                    <div style={{fontSize:11,fontWeight:700,color:"var(--tx2)",marginBottom:10}}>
                      {place.type==="Hotell"||place.type==="Herrgård"?"🏰 Fler hemsökta boenden":"👻 Liknande platser som kan intressera dig"}
                    </div>
                    {related.map(p=>{
                      const lk=!p.free&&!isPro;
                      return(
                        <div key={p.id} onClick={()=>onNavigate(p)} style={{display:"flex",gap:10,alignItems:"center",padding:"10px 12px",background:"var(--card)",border:"1px solid var(--b)",borderRadius:11,marginBottom:7,cursor:"pointer",transition:"border-color 0.15s"}} onTouchStart={e=>e.currentTarget.style.borderColor="var(--acc)"} onTouchEnd={e=>e.currentTarget.style.borderColor="var(--b)"}>
                          <div style={{width:40,height:40,borderRadius:8,background:"var(--bg3)",display:"flex",alignItems:"center",justifyContent:"center",flexShrink:0,overflow:"hidden"}}>
                            {p.img?<img src={p.img} alt="" style={{width:"100%",height:"100%",objectFit:"cover"}} onError={e=>e.target.style.display="none"}/>:<span style={{fontSize:18,opacity:0.5}}>{TYPE_ICON[p.type]||"👻"}</span>}
                          </div>
                          <div style={{flex:1,minWidth:0}}>
                            <div style={{fontSize:12,fontWeight:600,color:lk?"var(--tx3)":"var(--tx)",overflow:"hidden",textOverflow:"ellipsis",whiteSpace:"nowrap"}}>{lk?"🔒 ":""}{p.name}</div>
                            <div style={{fontSize:10,color:"var(--tx3)"}}>{FLAG[p.country]||"🌍"} {p.type} · {p.region}</div>
                          </div>
                          <div style={{flexShrink:0,display:"flex",flexDirection:"column",alignItems:"flex-end",gap:3}}>
                            <Scary n={p.scary||3} sz={4}/>
                            <span style={{fontSize:10,color:"var(--acc2)"}}>Läs →</span>
                          </div>
                        </div>
                      );
                    })}
                  </div>
                )}
              </>
            )}
          </div>
        </div>
      </div>

      {/* ── Fixed bottom: prev/next nav ── */}
      <div style={{position:"sticky",bottom:0,background:"rgba(7,6,15,0.97)",backdropFilter:"blur(16px)",WebkitBackdropFilter:"blur(16px)",borderTop:"1px solid var(--b)",padding:"10px 14px",display:"flex",gap:10,alignItems:"center",zIndex:10,flexShrink:0}}>
        <button onClick={()=>prev&&onNavigate(prev)} disabled={!prev} style={{background:"var(--bg3)",border:"1px solid var(--b)",borderRadius:10,padding:"10px 14px",cursor:prev?"pointer":"not-allowed",opacity:prev?1:0.35,display:"flex",alignItems:"center",gap:6,fontSize:12,fontWeight:600,color:"var(--tx2)",flexShrink:0}}>
          ← <span style={{overflow:"hidden",textOverflow:"ellipsis",whiteSpace:"nowrap",maxWidth:80}}>{prev?.name||""}</span>
        </button>
        <div style={{flex:1,textAlign:"center"}}>
          <div style={{fontSize:9,color:"var(--tx4)"}}>{idx+1} / {allPlaces.length}</div>
        </div>
        <button onClick={()=>next&&onNavigate(next)} disabled={!next} style={{background:"var(--bg3)",border:"1px solid var(--b)",borderRadius:10,padding:"10px 14px",cursor:next?"pointer":"not-allowed",opacity:next?1:0.35,display:"flex",alignItems:"center",gap:6,fontSize:12,fontWeight:600,color:"var(--tx2)",flexShrink:0}}>
          <span style={{overflow:"hidden",textOverflow:"ellipsis",whiteSpace:"nowrap",maxWidth:80}}>{next?.name||""}</span> →
        </button>
      </div>
    </div>
  );
}

// ── EBOOK BUILDER ─────────────────────────────────────────────
// ── PRICING FUNCTION ─────────────────────────────────────────
function ebookPrice(n) {
  if(n<=0) return 0;
  const t1=Math.min(n,10)*2.90;
  const t2=Math.max(0,n-10)*1.20;
  return Math.max(9,Math.round(t1+t2));
}

// ── EBOOK COVER DESIGNS ───────────────────────────────────────
const COVER_DESIGNS = [
  {id:"dark",name:"Mörk Klassiker",desc:"Djup lila med guldtext — elegant och skrämmande",
   preview:({title,n})=>(
    <div style={{width:"100%",aspectRatio:"0.707",background:"linear-gradient(160deg,#0a0517,#1a0a36)",borderRadius:10,display:"flex",flexDirection:"column",alignItems:"center",justifyContent:"center",padding:"14px 12px",position:"relative",overflow:"hidden"}}>
      <div style={{position:"absolute",top:0,left:0,right:0,height:3,background:"linear-gradient(90deg,#d4af37,#a78bfa,#d4af37)"}}/>
      <div style={{fontSize:24,marginBottom:8,filter:"drop-shadow(0 0 12px #7c3aed)"}}>👻</div>
      <div style={{fontSize:9,fontWeight:700,color:"#d4af37",letterSpacing:3,textTransform:"uppercase",marginBottom:6}}>SPÖKKARTAN</div>
      <div style={{fontSize:11,fontWeight:800,color:"#f0ecff",textAlign:"center",lineHeight:1.3,marginBottom:6}}>{title||"Din E-bok"}</div>
      <div style={{fontSize:8,color:"#6b5e8a"}}>{n} hemsökta platser</div>
      <div style={{position:"absolute",bottom:0,left:0,right:0,height:3,background:"linear-gradient(90deg,#d4af37,#a78bfa,#d4af37)"}}/>
    </div>
  )},
  {id:"photo",name:"Fotografisk",desc:"Mörk fotobakgrund med vit text och subtil röd accent",
   preview:({title,n})=>(
    <div style={{width:"100%",aspectRatio:"0.707",background:"linear-gradient(160deg,#1a0505,#0a0000)",borderRadius:10,display:"flex",flexDirection:"column",alignItems:"flex-start",justifyContent:"flex-end",padding:"14px 12px",position:"relative",overflow:"hidden"}}>
      <div style={{position:"absolute",inset:0,background:"radial-gradient(ellipse at 30% 30%,rgba(139,0,0,0.3),transparent 60%)"}}/>
      <div style={{position:"absolute",top:12,right:12,fontSize:20,opacity:0.4}}>🕯️</div>
      <div style={{position:"relative"}}>
        <div style={{width:28,height:2,background:"#dc2626",marginBottom:7}}/>
        <div style={{fontSize:11,fontWeight:900,color:"#fff",lineHeight:1.2,marginBottom:4}}>{title||"Din E-bok"}</div>
        <div style={{fontSize:8,color:"rgba(255,255,255,0.5)"}}>SPÖKKARTAN · {n} PLATSER</div>
      </div>
    </div>
  )},
  {id:"minimal",name:"Minimalistisk",desc:"Ljus bakgrund med mörk typografi — modern och ren",
   preview:({title,n})=>(
    <div style={{width:"100%",aspectRatio:"0.707",background:"#f0ecff",borderRadius:10,display:"flex",flexDirection:"column",alignItems:"flex-start",justifyContent:"space-between",padding:"16px 14px",position:"relative",overflow:"hidden"}}>
      <div style={{fontSize:9,fontWeight:700,color:"#352d52",letterSpacing:2}}>SPÖKKARTAN.SE</div>
      <div>
        <div style={{fontSize:28,marginBottom:8,color:"#7c3aed"}}>👻</div>
        <div style={{fontSize:12,fontWeight:900,color:"#07060f",lineHeight:1.2,marginBottom:4}}>{title||"Din E-bok"}</div>
        <div style={{fontSize:8,color:"#6b5e8a"}}>{n} hemsökta platser</div>
      </div>
      <div style={{width:"100%",height:2,background:"#7c3aed"}}/>
    </div>
  )},
  {id:"vintage",name:"Vintage Karta",desc:"Sepiafärgad med kartdetaljer — historisk och mystisk",
   preview:({title,n})=>(
    <div style={{width:"100%",aspectRatio:"0.707",background:"linear-gradient(160deg,#2a1a08,#1a0f05)",borderRadius:10,display:"flex",flexDirection:"column",alignItems:"center",justifyContent:"center",padding:"14px 12px",position:"relative",overflow:"hidden"}}>
      <div style={{position:"absolute",inset:0,opacity:0.06,backgroundImage:"repeating-linear-gradient(0deg,#d4af37 0,#d4af37 1px,transparent 1px,transparent 20px),repeating-linear-gradient(90deg,#d4af37 0,#d4af37 1px,transparent 1px,transparent 20px)"}}/>
      <div style={{position:"relative",textAlign:"center"}}>
        <div style={{fontSize:20,marginBottom:8,filter:"sepia(1)"}}>🗺️</div>
        <div style={{fontSize:9,fontWeight:700,color:"#d4af37",letterSpacing:2,marginBottom:5}}>── SPÖKKARTAN ──</div>
        <div style={{fontSize:11,fontWeight:700,color:"#f5e6c8",lineHeight:1.3,marginBottom:8}}>{title||"Din E-bok"}</div>
        <div style={{fontSize:7,color:"#8b7355",letterSpacing:1}}>{n} HEMSÖKTA PLATSER</div>
      </div>
    </div>
  )},
];

function EbookBuilder({allPlaces}) {
  const [search,setSearch]=useState("");
  const [fType,setFType]=useState("Alla");
  const [fCountry,setFCountry]=useState("Alla");
  const [selected,setSelected]=useState([]);
  const [email,setEmail]=useState("");
  const [customTitle,setCustomTitle]=useState("");
  const [coverDesign,setCoverDesign]=useState("dark");
  const [step,setStep]=useState("build"); // build | cover | checkout | processing | done
  const [progress,setProgress]=useState(0);

  const types=useMemo(()=>["Alla",...new Set(allPlaces.map(p=>p.type).filter(Boolean))].sort(a=>a==="Alla"?-1:0),[allPlaces]);
  const countries=useMemo(()=>["Alla",...new Set(allPlaces.map(p=>p.country).filter(Boolean))].sort(a=>a==="Alla"?-1:0),[allPlaces]);
  const filtered=useMemo(()=>{
    const q=search.toLowerCase().trim();
    return allPlaces.filter(p=>{
      if(fType!=="Alla"&&p.type!==fType) return false;
      if(fCountry!=="Alla"&&p.country!==fCountry) return false;
      if(q&&!p.name?.toLowerCase().includes(q)&&!p.region?.toLowerCase().includes(q)&&!p.country?.toLowerCase().includes(q)&&!p.type?.toLowerCase().includes(q)&&!p.teaser?.toLowerCase().includes(q)) return false;
      return true;
    });
  },[allPlaces,fType,fCountry,search]);

  const MAX=20;
  const n=selected.length;
  const price=ebookPrice(n);
  const pricePerPage=n>0?Math.round(price/n*100)/100:0;
  const canAdd=n<MAX;

  function toggle(id){setSelected(s=>s.includes(id)?s.filter(x=>x!==id):canAdd?[...s,id]:s);}

  function generate(){
    if(!email||!email.includes("@")){alert("Ange en giltig e-postadress.");return;}
    // Build Stripe Payment Link URL with email pre-filled and metadata for fulfillment
    const baseUrl = n > 20 ? "https://buy.stripe.com/4gM28q4ezbQo1O58im3oA00" : "https://buy.stripe.com/5kQ4gy3avcUsgIZfKO3oA01";
    const params = new URLSearchParams({
      prefilled_email: email,
      client_reference_id: "ebook_" + n + "_" + Date.now(),
    });
    // Pass selected place IDs and book metadata so admin can fulfill manually
    try {
      sessionStorage.setItem("spokkartan_ebook_pending", JSON.stringify({
        email, places: selected, title: bookTitle, design: coverDesign, n, ts: Date.now(),
      }));
    } catch(e) {}
    window.location.href = baseUrl + "?" + params.toString();
  }

  const chosenDesign=COVER_DESIGNS.find(d=>d.id===coverDesign)||COVER_DESIGNS[0];
  const bookTitle=customTitle.trim()||("Spökkartan — "+selected.slice(0,2).map(id=>allPlaces.find(p=>p.id===id)?.name).filter(Boolean).join(" & ")+(selected.length>2?" m.fl.":""));

  // ── Processing screen
  if(step==="processing") return(
    <div style={{flex:1,display:"flex",flexDirection:"column",alignItems:"center",justifyContent:"center",padding:32,textAlign:"center"}}>
      <div style={{width:80,height:80,marginBottom:20,background:"linear-gradient(135deg,#1a0a36,#0d0b1a)",borderRadius:16,display:"flex",alignItems:"center",justifyContent:"center",fontSize:40}}>📖</div>
      <div style={{fontSize:18,fontWeight:800,color:"var(--tx)",marginBottom:6}}>Skapar din e-bok…</div>
      <div style={{fontSize:12,color:"var(--tx3)",marginBottom:20}}>{n} sidor sammanställs med {chosenDesign.name}-omslag</div>
      <div style={{background:"var(--b)",borderRadius:999,height:6,width:"100%",maxWidth:280,overflow:"hidden",marginBottom:8}}>
        <div style={{height:"100%",background:"linear-gradient(90deg,#7c3aed,#a78bfa)",borderRadius:999,width:progress+"%",transition:"width 0.2s"}}/>
      </div>
      <div style={{fontSize:12,fontWeight:700,color:"#a78bfa"}}>{progress}%</div>
    </div>
  );

  // ── Done screen
  if(step==="done") return(
    <div style={{flex:1,display:"flex",flexDirection:"column",alignItems:"center",justifyContent:"center",padding:24,textAlign:"center"}}>
      <div style={{width:120,marginBottom:20}}>
        {chosenDesign.preview({title:bookTitle,n})}
      </div>
      <div style={{fontSize:20,fontWeight:800,color:"var(--tx)",marginBottom:4}}>🎉 E-boken är klar!</div>
      <div style={{fontSize:13,color:"var(--tx3)",marginBottom:4}}>{n} sidor · {chosenDesign.name} omslag</div>
      <div style={{fontSize:12,color:"var(--tx4)",marginBottom:20}}>PDF skickas till {email}</div>
      <Btn ch="✨ Skapa en ny bok" v="p" onClick={()=>{setStep("build");setSelected([]);setProgress(0);setEmail("");setCustomTitle("");}}/>
    </div>
  );

  // ── Cover selection screen
  if(step==="cover") return(
    <div style={{flex:1,overflowY:"auto",padding:16}}>
      <div style={{display:"flex",alignItems:"center",gap:10,marginBottom:16}}>
        <button onClick={()=>setStep("build")} style={{background:"none",border:"none",color:"var(--tx3)",cursor:"pointer",fontSize:14}}>← Tillbaka</button>
        <div style={{fontSize:15,fontWeight:800,color:"var(--tx)"}}>Välj omslag</div>
      </div>
      {/* Custom title */}
      <div style={{marginBottom:16}}>
        <label style={{fontSize:10,fontWeight:700,color:"var(--tx3)",letterSpacing:0.5,display:"block",marginBottom:5}}>EGEN TITEL (valfritt)</label>
        <input className="inp" value={customTitle} onChange={e=>setCustomTitle(e.target.value)} placeholder={bookTitle} style={{fontSize:13}}/>
      </div>
      {/* Cover grid */}
      <div style={{display:"grid",gridTemplateColumns:"1fr 1fr",gap:12,marginBottom:20}}>
        {COVER_DESIGNS.map(d=>(
          <div key={d.id} onClick={()=>setCoverDesign(d.id)} style={{cursor:"pointer",borderRadius:12,border:`2px solid ${coverDesign===d.id?"#7c3aed":"var(--b)"}`,overflow:"hidden",transition:"border-color 0.2s"}}>
            <div style={{padding:8}}>
              {d.preview({title:bookTitle,n})}
            </div>
            <div style={{padding:"8px 10px",borderTop:"1px solid var(--b)",background:coverDesign===d.id?"rgba(124,58,237,0.08)":"var(--card)"}}>
              <div style={{fontSize:11,fontWeight:700,color:coverDesign===d.id?"#a78bfa":"var(--tx)",marginBottom:1}}>{d.name}</div>
              <div style={{fontSize:9,color:"var(--tx4)"}}>{d.desc}</div>
            </div>
          </div>
        ))}
      </div>
      {/* Price summary + checkout */}
      <div style={{background:"var(--bg3)",border:"1px solid var(--b)",borderRadius:14,padding:"14px 16px",marginBottom:14}}>
        <div style={{display:"flex",justifyContent:"space-between",marginBottom:6}}>
          <span style={{fontSize:13,color:"var(--tx2)"}}>{n} sidor</span>
          <span style={{fontSize:18,fontWeight:800,color:"#d4af37"}}>{price} kr</span>
        </div>
        <div style={{fontSize:10,color:"var(--tx4)",marginBottom:12}}>{pricePerPage} kr per sida · {n>10?`Du sparar ${Math.round((n*2.90)-price)} kr vs. styckpris`:"Fyllig e-bok redo att ladda ner"}</div>
        <input className="inp" type="email" placeholder="Din e-postadress" value={email} onChange={e=>setEmail(e.target.value)} style={{fontSize:13,marginBottom:10}}/>
        <Btn ch={`📖 Köp för ${price} kr →`} v="gold" full onClick={generate} disabled={!email||!email.includes("@")}/>
        <div style={{textAlign:"center",fontSize:10,color:"var(--tx4)",marginTop:8}}>🔒 Stripe · PDF direkt till din e-post</div>
      </div>
    </div>
  );

  // ── Main build screen
  return(
    <div style={{flex:1,display:"flex",flexDirection:"column",overflow:"hidden",minHeight:0}}>
      {/* Filter */}
      <div style={{padding:"10px 12px",borderBottom:"1px solid var(--b)",flexShrink:0}}>
        <div style={{position:"relative",marginBottom:8}}>
          <input className="inp inp-sm" placeholder="Sök namn, typ, region, spöke…" value={search} onChange={e=>setSearch(e.target.value)} style={{paddingLeft:28}}/>
          <span style={{position:"absolute",left:9,top:"50%",transform:"translateY(-50%)",fontSize:12,color:"var(--tx4)",pointerEvents:"none"}}>🔍</span>
          {search&&<button onClick={()=>setSearch("")} style={{position:"absolute",right:8,top:"50%",transform:"translateY(-50%)",background:"none",border:"none",color:"var(--tx3)",cursor:"pointer",fontSize:14}}>✕</button>}
        </div>
        <div style={{display:"flex",gap:5,overflowX:"auto",paddingBottom:2,marginBottom:7}}>
          {types.map(t=><button key={t} className={"pill"+(fType===t?" on":"")} onClick={()=>setFType(t)}>{TYPE_ICON[t]||""} {t}</button>)}
        </div>
        <div style={{display:"flex",gap:7,alignItems:"center"}}>
          <select className="inp inp-sm" value={fCountry} onChange={e=>setFCountry(e.target.value)} style={{width:120}}>
            {countries.map(c=><option key={c}>{c}</option>)}
          </select>
          <span style={{fontSize:10,color:"var(--tx4)",marginLeft:"auto"}}>{filtered.length} platser</span>
        </div>
      </div>

      <div style={{flex:1,display:"flex",overflow:"hidden",minHeight:0}}>
        {/* Place list */}
        <div style={{flex:1,overflowY:"auto",padding:"5px 8px"}}>
          {filtered.length===0&&<div style={{textAlign:"center",padding:"32px 12px",color:"var(--tx4)",fontSize:12}}>Inga platser — prova annat sökord</div>}
          {filtered.map(p=>{
            const sel=selected.includes(p.id),dis=!canAdd&&!sel;
            return(
              <div key={p.id} className={"place-row"+(sel?" sel":"")} style={{opacity:dis?0.35:1,pointerEvents:dis?"none":"auto"}} onClick={()=>toggle(p.id)}>
                <div style={{width:20,height:20,borderRadius:"50%",border:"2px solid "+(sel?"#7c3aed":"var(--b2)"),background:sel?"#7c3aed":"transparent",display:"flex",alignItems:"center",justifyContent:"center",flexShrink:0,transition:"all 0.15s"}}>
                  {sel&&<span style={{color:"#fff",fontSize:9,fontWeight:700}}>✓</span>}
                </div>
                <div style={{flex:1,minWidth:0}}>
                  <div style={{fontSize:12,fontWeight:600,color:sel?"var(--tx)":"var(--tx2)",overflow:"hidden",textOverflow:"ellipsis",whiteSpace:"nowrap"}}>{FLAG[p.country]||"🌍"} {p.name}</div>
                  <div style={{fontSize:9,color:"var(--tx4)"}}>{p.type} · {p.region||p.country}</div>
                </div>
                <Scary n={p.scary||3} sz={4}/>
              </div>
            );
          })}
        </div>

        {/* Summary panel */}
        <div style={{width:170,borderLeft:"1px solid var(--b)",display:"flex",flexDirection:"column",flexShrink:0}}>
          {/* Price display */}
          <div style={{padding:"10px 10px",borderBottom:"1px solid var(--b)",flexShrink:0}}>
            <div style={{display:"flex",justifyContent:"space-between",alignItems:"baseline",marginBottom:5}}>
              <span style={{fontSize:14,fontWeight:800,color:"var(--tx)"}}>{n}<span style={{fontSize:9,fontWeight:400,color:"var(--tx3)"}}>/{MAX} sidor</span></span>
              <span style={{fontSize:15,fontWeight:800,color:n>0?"#d4af37":"var(--tx4)"}}>{n>0?price+" kr":"—"}</span>
            </div>
            {/* Progress bar */}
            <div style={{background:"var(--b)",borderRadius:999,height:4,overflow:"hidden",marginBottom:5}}>
              <div style={{height:"100%",background:"linear-gradient(90deg,#7c3aed,#a78bfa)",borderRadius:999,width:(n/MAX*100)+"%",transition:"width 0.3s"}}/>
            </div>
            {n>0&&<div style={{fontSize:9,color:"var(--tx4)"}}>{pricePerPage} kr/sida{n>10&&<span style={{color:"#34d399"}}> · −{Math.round((n*2.90)-price)} kr rabatt</span>}</div>}
            {/* Volume tiers visual */}
            <div style={{marginTop:8,display:"flex",flexDirection:"column",gap:3}}>
              {[[1,10,"2.90"],[11,15,"1.20"],[16,20,"1.20"]].map(([from,to,rate],i)=>{
                const active=n>=from;
                return(
                  <div key={i} style={{display:"flex",justifyContent:"space-between",fontSize:8,color:active?"#34d399":"var(--tx4)",padding:"2px 0",borderBottom:"1px solid var(--b)"}}>
                    <span>Sid {from}-{to}</span>
                    <span style={{fontWeight:active?700:400}}>{i===0?"2.90":"1.20"} kr/sida</span>
                  </div>
                );
              })}
            </div>
          </div>

          {/* Selected list */}
          <div style={{flex:1,overflowY:"auto",padding:"5px 8px"}}>
            {n===0&&<div style={{fontSize:9,color:"var(--tx4)",textAlign:"center",marginTop:16}}>Välj platser ←</div>}
            {selected.map((id,i)=>{const p=allPlaces.find(x=>x.id===id);return p?(
              <div key={id} style={{display:"flex",gap:4,alignItems:"center",padding:"4px 0",borderBottom:"1px solid var(--b)"}}>
                <span style={{fontSize:8,fontWeight:700,color:"#a78bfa",flexShrink:0,width:12}}>{i+1}.</span>
                <span style={{flex:1,fontSize:9,fontWeight:500,color:"var(--tx2)",overflow:"hidden",textOverflow:"ellipsis",whiteSpace:"nowrap"}}>{p.name}</span>
                <button onClick={e=>{e.stopPropagation();toggle(id);}} style={{background:"none",border:"none",color:"var(--tx4)",cursor:"pointer",fontSize:11,padding:0,flexShrink:0}}>×</button>
              </div>
            ):null;})}
          </div>

          {/* CTA */}
          <div style={{padding:"8px",borderTop:"1px solid var(--b)",flexShrink:0}}>
            {n>=1?(
              <Btn ch="Välj omslag →" v="p" full onClick={()=>setStep("cover")} style={{fontSize:11,padding:"9px"}}/>
            ):<div style={{fontSize:9,color:"var(--tx4)",textAlign:"center"}}>Välj 1+ sida</div>}
            {n>=1&&<button onClick={()=>setSelected([])} style={{width:"100%",background:"none",border:"none",fontSize:9,color:"var(--tx4)",cursor:"pointer",marginTop:4}}>Rensa</button>}
          </div>
        </div>
      </div>
    </div>
  );
}


// ── BULLETIN BOARD ────────────────────────────────────────────
function BulletinBoard({user}) {
  const [posts,setPosts]=useState(BOARD_POSTS_INIT);
  const [showNew,setShowNew]=useState(false);
  const [fCat,setFCat]=useState("alla");
  const [liked,setLiked]=useState([]);
  const [title,setTitle]=useState("");
  const [body,setBody]=useState("");
  const [cat,setCat]=useState("samarbete");
  const CATS=[{id:"alla",icon:"📋",l:"Alla"},{id:"samarbete",icon:"🤝",l:"Samarbeten"},{id:"tipsar",icon:"👻",l:"Tips"},{id:"säljer",icon:"🏷️",l:"Säljer"},{id:"köper",icon:"🛒",l:"Köper"},{id:"event",icon:"📅",l:"Events"}];
  const filtered=fCat==="alla"?posts:posts.filter(p=>p.cat===fCat);
  function timeAgo(ts){const d=(Date.now()-new Date(ts))/1000;if(d<3600)return`${Math.floor(d/60)}m`;if(d<86400)return`${Math.floor(d/3600)}h`;return`${Math.floor(d/86400)}d`;}
  function submit(e){
    e.preventDefault();if(!title.trim()||!body.trim())return;
    setPosts(p=>[{id:`b${Date.now()}`,authorId:user.id,author:user.name,avatar:user.avatar||"",verified:user.role==="ghosthunter"||user.role==="admin",cat,title:title.trim(),body:body.trim(),ts:new Date().toISOString(),likes:0},...p]);
    setTitle("");setBody("");setShowNew(false);
  }
  return(
    <div style={{flex:1,display:"flex",flexDirection:"column",overflow:"hidden"}}>
      <div style={{padding:"12px 14px",borderBottom:"1px solid var(--b)",flexShrink:0}}>
        <div style={{display:"flex",justifyContent:"space-between",alignItems:"center",marginBottom:10}}>
          <div><div style={{fontSize:15,fontWeight:800,color:"var(--tx)"}}>📋 Anslagstavlan</div><div style={{fontSize:10,color:"var(--tx3)"}}>Samarbeten · Tips · Köp & sälj · Events</div></div>
          <Btn ch="+ Inlägg" v="p" sz="sm" onClick={()=>setShowNew(s=>!s)}/>
        </div>
        <div style={{display:"flex",gap:5,overflowX:"auto",paddingBottom:2}}>
          {CATS.map(c=><button key={c.id} className={`pill${fCat===c.id?" on":""}`} onClick={()=>setFCat(c.id)}>{c.icon} {c.l}</button>)}
        </div>
      </div>
      {showNew&&(
        <form onSubmit={submit} style={{padding:"12px 14px",borderBottom:"1px solid var(--b)",background:"var(--bg2)",flexShrink:0}}>
          <div style={{display:"flex",gap:7,marginBottom:8}}>
            <select className="inp inp-sm" value={cat} onChange={e=>setCat(e.target.value)} style={{width:130}}>
              {CATS.filter(c=>c.id!=="alla").map(c=><option key={c.id} value={c.id}>{c.icon} {c.l}</option>)}
            </select>
            <input className="inp inp-sm" value={title} onChange={e=>setTitle(e.target.value)} placeholder="Rubrik…" required style={{flex:1}}/>
          </div>
          <textarea className="inp" value={body} onChange={e=>setBody(e.target.value)} placeholder="Beskriv…" rows={2} style={{resize:"none",marginBottom:8,fontSize:13}} required/>
          <div style={{display:"flex",gap:7}}><Btn ch="Publicera" v="p" sz="sm"/><Btn ch="Avbryt" v="ghost" sz="sm" onClick={()=>setShowNew(false)}/></div>
        </form>
      )}
      <div style={{flex:1,overflowY:"auto",padding:"10px 14px"}}>
        {filtered.map((p,i)=>(
          <div key={p.id} className="au card" style={{padding:"14px",marginBottom:10,animationDelay:`${i*0.06}s`}}>
            <div style={{display:"flex",gap:9,alignItems:"center",marginBottom:8}}>
              <div style={{width:32,height:32,borderRadius:"50%",overflow:"hidden",border:"2px solid #34d399",flexShrink:0,background:"var(--bg3)"}}>
                {p.avatar?<img src={p.avatar} alt="" style={{width:"100%",height:"100%",objectFit:"cover"}} onError={e=>e.target.style.display="none"}/>:<div style={{width:"100%",height:"100%",display:"flex",alignItems:"center",justifyContent:"center",fontSize:14}}>👻</div>}
              </div>
              <div style={{flex:1,minWidth:0}}>
                <div style={{fontSize:12,fontWeight:700,color:"var(--tx)",display:"flex",gap:5,alignItems:"center",flexWrap:"wrap"}}>
                  {p.author}{p.verified&&<Tag ch="✓" c="#34d399" style={{fontSize:8,padding:"1px 5px"}}/>}
                </div>
                <div style={{fontSize:9,color:"var(--tx4)"}}>{timeAgo(p.ts)}</div>
              </div>
              <span className="tag" style={{background:CAT_C[p.cat]+"1a",border:`1px solid ${CAT_C[p.cat]}44`,color:CAT_C[p.cat],fontSize:9}}>{CATS.find(c=>c.id===p.cat)?.icon} {CATS.find(c=>c.id===p.cat)?.l}</span>
            </div>
            <div style={{fontSize:13,fontWeight:700,color:"var(--tx)",marginBottom:4}}>{p.title}</div>
            <div style={{fontSize:12,color:"var(--tx2)",lineHeight:1.65,marginBottom:10}}>{p.body}</div>
            <button onClick={()=>{setLiked(prev=>prev.includes(p.id)?prev.filter(x=>x!==p.id):[...prev,p.id]);setPosts(prev=>prev.map(x=>x.id===p.id?{...x,likes:x.likes+(liked.includes(p.id)?-1:1)}:x));}} style={{background:liked.includes(p.id)?"rgba(248,113,113,0.1)":"transparent",border:`1px solid ${liked.includes(p.id)?"rgba(248,113,113,0.4)":"var(--b)"}`,borderRadius:7,padding:"5px 10px",cursor:"pointer",fontSize:11,fontWeight:600,color:liked.includes(p.id)?"#f87171":"var(--tx3)"}}>
              {liked.includes(p.id)?"❤️":"🤍"} {p.likes}
            </button>
          </div>
        ))}
      </div>
    </div>
  );
}

// ── HUNTERS PAGE ──────────────────────────────────────────────
function HuntersPage({user,setAuth,setView}) {
  const [search,setSearch]=useState("");
  const [openProfile,setOpenProfile]=useState(null);
  const [showUpgrade,setShowUpgrade]=useState(false);

  // Slå ihop bas-datat med ev. registrerade spökjägare i USERS_DB
  const all = [
    ...BASE_HUNTERS,
    ...Object.values(USERS_DB).filter(u=>u.role==="ghosthunter"&&u.verified).map(u=>({
      id:u.id,name:u.name,verified:true,speciality:"",since:u.created?.slice(0,4)||"2025",
      places:0, tier:"free",
      bio:u.bio||"",img:u.avatar||"",yt:u.yt||"",ig:u.ig||"",fb:"",
      tagline:"",bestPlace:"",bestReason:"",upcoming:"",visitedPlaces:[],
    })),
  ];

  const filtered = all.filter(h => !search ||
    h.name.toLowerCase().includes(search.toLowerCase()) ||
    h.bio.toLowerCase().includes(search.toLowerCase()) ||
    h.speciality?.toLowerCase().includes(search.toLowerCase())
  );

  // Sortering: spotlight först, sedan premium, sedan resten
  const tierOrder = { spotlight: 0, premium: 1, free: 2 };
  const sorted = [...filtered].sort((a,b)=>(tierOrder[a.tier]??9)-(tierOrder[b.tier]??9));

  const featured = sorted.find(h => h.tier === "spotlight");
  const others = sorted.filter(h => h.id !== featured?.id);

  const isHunter = user?.role === "ghosthunter" || user?.role === "admin";

  return (
    <div style={{flex:1,overflowY:"auto",paddingBottom:90}}>
      {/* HERO */}
      <div style={{background:"linear-gradient(160deg,#1a0a36,#08070e)",padding:"22px 16px 16px",borderBottom:"1px solid var(--b)"}}>
        <div style={{fontSize:10,fontWeight:700,color:"#a78bfa",letterSpacing:3,textTransform:"uppercase",marginBottom:6}}>🔍 Spökjägare</div>
        <h1 style={{fontSize:"clamp(20px,5.5vw,28px)",fontWeight:800,color:"var(--tx)",lineHeight:1.15,marginBottom:8}}>Möt dem som jagar <span className="gt">spökena</span></h1>
        <p style={{fontSize:13,color:"var(--tx2)",lineHeight:1.65,marginBottom:14}}>
          Sveriges mest aktiva spökjägare — verkliga personer som dokumenterat hundratals nattundersökningar. Klicka in på en profil för bilder, plats-logg, sociala kanaler och bästa platsen.
        </p>
        <div style={{position:"relative"}}>
          <input className="inp" placeholder="Sök efter namn, specialitet, plats…" value={search} onChange={e=>setSearch(e.target.value)} style={{paddingLeft:32}}/>
          <span style={{position:"absolute",left:11,top:"50%",transform:"translateY(-50%)",fontSize:12,color:"var(--tx4)",pointerEvents:"none"}}>🔍</span>
        </div>

        {/* Status-rad */}
        <div style={{marginTop:11}}>
          {!user && <div style={{background:"rgba(124,58,237,0.08)",border:"1px solid rgba(124,58,237,0.25)",borderRadius:10,padding:"9px 12px",fontSize:12,color:"var(--tx2)",display:"flex",justifyContent:"space-between",alignItems:"center",gap:8}}>
            <span>👻 Är du spökjägare?</span>
            <button onClick={()=>setAuth("register")} style={{background:"none",border:"1px solid #7c3aed",borderRadius:7,padding:"4px 10px",fontSize:11,fontWeight:600,color:"#a78bfa",cursor:"pointer"}}>Skapa profil →</button>
          </div>}
          {user?.role==="pending_hunter" && <div style={{background:"rgba(251,191,36,0.07)",border:"1px solid rgba(251,191,36,0.25)",borderRadius:10,padding:"9px 12px",fontSize:12,color:"#fbbf24"}}>⏳ Din ansökan väntar på verifiering.</div>}
          {isHunter && <div style={{background:"rgba(52,211,153,0.07)",border:"1px solid rgba(52,211,153,0.2)",borderRadius:10,padding:"9px 12px",fontSize:12,color:"#34d399",display:"flex",justifyContent:"space-between",alignItems:"center",gap:8,flexWrap:"wrap"}}>
            <span>✓ Du är verifierad spökjägare</span>
            <div style={{display:"flex",gap:6}}>
              <button onClick={()=>setShowUpgrade(true)} style={{background:"rgba(124,58,237,0.18)",border:"1px solid #7c3aed",borderRadius:7,padding:"4px 10px",fontSize:11,fontWeight:600,color:"#a78bfa",cursor:"pointer"}}>✨ Uppgradera</button>
              <button onClick={()=>setView("board")} style={{background:"none",border:"1px solid rgba(52,211,153,0.35)",borderRadius:7,padding:"4px 10px",fontSize:11,fontWeight:600,color:"#34d399",cursor:"pointer"}}>Anslagstavla →</button>
            </div>
          </div>}
        </div>
      </div>

      {/* SPOTLIGHT — månadens spökjägare */}
      {featured && (
        <div style={{padding:"14px 14px 0"}}>
          <div style={{fontSize:11,fontWeight:700,color:"#fbbf24",letterSpacing:1.5,textTransform:"uppercase",marginBottom:9}}>★ Månadens spökjägare</div>
          <div onClick={()=>setOpenProfile(featured)} style={{background:"linear-gradient(135deg,#241245,#0d0b1a)",border:"1px solid #fbbf24",borderRadius:16,padding:16,cursor:"pointer",position:"relative",overflow:"hidden",boxShadow:"0 6px 24px rgba(251,191,36,0.15)"}}>
            <div style={{position:"absolute",top:-30,right:-30,fontSize:120,opacity:0.06}}>👻</div>
            <div style={{display:"flex",gap:14,alignItems:"flex-start",position:"relative"}}>
              <div style={{position:"relative",flexShrink:0}}>
                <div style={{width:78,height:78,borderRadius:"50%",overflow:"hidden",border:"3px solid #fbbf24",background:"var(--bg3)"}}>
                  {featured.img?<img src={featured.img} alt={featured.name} style={{width:"100%",height:"100%",objectFit:"cover"}}/>:<div style={{width:"100%",height:"100%",display:"flex",alignItems:"center",justifyContent:"center",fontSize:28}}>👻</div>}
                </div>
                <div style={{position:"absolute",bottom:-3,right:-3,background:"linear-gradient(90deg,#fbbf24,#f59e0b)",borderRadius:"50%",width:24,height:24,display:"flex",alignItems:"center",justifyContent:"center",fontSize:11,border:"2px solid #0d0b1a"}}>★</div>
              </div>
              <div style={{flex:1,minWidth:0}}>
                <div style={{display:"flex",gap:6,alignItems:"center",flexWrap:"wrap",marginBottom:3}}>
                  <span style={{fontSize:16,fontWeight:800,color:"var(--tx)"}}>{featured.name}</span>
                  <span style={{fontSize:9,fontWeight:800,color:"#1a0a36",background:"linear-gradient(90deg,#fbbf24,#f59e0b)",borderRadius:5,padding:"2px 7px",letterSpacing:0.5}}>★ SPOTLIGHT</span>
                </div>
                {featured.tagline && <div style={{fontSize:12,color:"var(--tx2)",lineHeight:1.55,marginBottom:6,fontStyle:"italic"}}>"{featured.tagline}"</div>}
                <div style={{fontSize:11,color:"var(--tx3)",marginBottom:8}}>🔍 {featured.speciality} · {featured.places} platser · sedan {featured.since}</div>
                <div style={{display:"flex",gap:8}}>
                  <span style={{fontSize:11,fontWeight:700,color:"#fbbf24"}}>Se hela profilen →</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      )}

      {/* GRID — alla spökjägare */}
      <div style={{padding:"16px 14px 0"}}>
        <div style={{fontSize:11,fontWeight:700,color:"var(--tx3)",letterSpacing:1.5,textTransform:"uppercase",marginBottom:10,display:"flex",justifyContent:"space-between",alignItems:"center"}}>
          <span>Alla spökjägare</span>
          <span style={{fontSize:10,color:"var(--tx4)",letterSpacing:0,textTransform:"none"}}>{others.length} st</span>
        </div>

        {others.length === 0 ? (
          <div style={{textAlign:"center",padding:"40px",color:"var(--tx4)"}}>Inga spökjägare matchade din sökning.</div>
        ) : (
          <div style={{display:"grid",gap:10}}>
            {others.map((h,i) => <HunterMiniCard key={h.id} h={h} delay={i*0.05} onClick={()=>setOpenProfile(h)}/>)}
          </div>
        )}
      </div>

      {/* CTA — bli spökjägare */}
      <div style={{padding:"22px 14px 0"}}>
        <div style={{background:"linear-gradient(135deg,#1a0a36,#0d0b1a)",border:"1px solid var(--b2)",borderRadius:16,padding:18,textAlign:"center"}}>
          <div style={{fontSize:32,marginBottom:8}}>🔍</div>
          <div style={{fontSize:16,fontWeight:800,color:"var(--tx)",marginBottom:6}}>Är du spökjägare?</div>
          <p style={{fontSize:12,color:"var(--tx2)",lineHeight:1.65,marginBottom:14}}>
            Skapa en profil — beskriv dig själv, ladda upp bilder, logga platser du varit på, markera bästa platsen och länka YouTube/IG/pod. Gratis att komma igång. Uppgradera till Premium (79 kr/mån) för att featuras emellanåt.
          </p>
          <Btn ch="Ansök om spökjägar-profil →" v="p" onClick={()=>user?setShowUpgrade(true):setAuth("register")}/>
        </div>
      </div>

      {/* Premium-tiers info */}
      <div style={{padding:"18px 14px 4px"}}>
        <div style={{fontSize:11,fontWeight:700,color:"var(--tx3)",letterSpacing:1.5,textTransform:"uppercase",marginBottom:9}}>✨ Synas mer som spökjägare</div>
        <div style={{display:"grid",gap:9}}>
          {Object.entries(HUNTER_TIERS).filter(([k])=>k!=="free").map(([code,t])=>(
            <div key={code} style={{background:"var(--card)",border:`1px solid ${t.color}55`,borderTop:`3px solid ${t.color}`,borderRadius:11,padding:"12px 14px"}}>
              <div style={{display:"flex",justifyContent:"space-between",alignItems:"flex-start",gap:8,marginBottom:5}}>
                <div>
                  <div style={{fontSize:13,fontWeight:800,color:t.color}}>{t.label}</div>
                  <div style={{fontSize:11,color:"var(--tx3)",marginTop:1,lineHeight:1.45}}>{t.pitch}</div>
                </div>
                <div style={{textAlign:"right",flexShrink:0}}>
                  <div style={{fontSize:18,fontWeight:800,color:t.color}}>{t.price.toLocaleString("sv-SE")} kr</div>
                  {t.period && <div style={{fontSize:9,color:"var(--tx4)"}}>{t.period}</div>}
                </div>
              </div>
              <ul style={{listStyle:"none",padding:0,margin:"4px 0 8px",display:"grid",gap:3}}>
                {t.perks.map((perk,i)=>(<li key={i} style={{fontSize:11,color:"var(--tx2)",display:"flex",gap:6}}><span style={{color:t.color}}>✓</span> {perk}</li>))}
              </ul>
              <Btn ch={code==="article"?"Beställ artikel →":`Uppgradera till ${t.label} →`} v="ghost" sz="sm" onClick={()=>user?setShowUpgrade(true):setAuth("login")}/>
            </div>
          ))}
        </div>
      </div>

      {/* MODALER */}
      {openProfile && <HunterDetailModal h={openProfile} user={user} onClose={()=>setOpenProfile(null)} onUpgrade={()=>{setOpenProfile(null);setShowUpgrade(true);}}/>}
      {showUpgrade && <HunterUpgradeModal user={user} onClose={()=>setShowUpgrade(false)}/>}
    </div>
  );
}

// ── SPÖKJÄGAR-MINIKORT (för listan) ───────────────────────────
function HunterMiniCard({ h, delay, onClick }) {
  const tierMeta = HUNTER_TIERS[h.tier] || HUNTER_TIERS.free;
  const isPremium = h.tier && h.tier !== "free";
  return (
    <div onClick={onClick} className="au" style={{animationDelay:`${delay}s`,background:"var(--card)",border:`1px solid ${isPremium?tierMeta.color+"55":"var(--b)"}`,borderRadius:14,padding:13,cursor:"pointer",transition:"all 0.18s",position:"relative"}}
         onMouseEnter={e=>{e.currentTarget.style.transform="translateY(-1px)";e.currentTarget.style.borderColor=isPremium?tierMeta.color:"var(--b2)";}}
         onMouseLeave={e=>{e.currentTarget.style.transform="none";e.currentTarget.style.borderColor=isPremium?tierMeta.color+"55":"var(--b)";}}>
      <div style={{display:"flex",gap:12,alignItems:"flex-start"}}>
        <div style={{width:54,height:54,borderRadius:"50%",overflow:"hidden",border:`2px solid ${isPremium?tierMeta.color:"#34d399"}`,background:"var(--bg3)",flexShrink:0}}>
          {h.img?<img src={h.img} alt={h.name} style={{width:"100%",height:"100%",objectFit:"cover"}}/>:<div style={{width:"100%",height:"100%",display:"flex",alignItems:"center",justifyContent:"center",fontSize:22}}>👻</div>}
        </div>
        <div style={{flex:1,minWidth:0}}>
          <div style={{display:"flex",gap:5,alignItems:"center",flexWrap:"wrap",marginBottom:3}}>
            <span style={{fontSize:14,fontWeight:700,color:"var(--tx)"}}>{h.name}</span>
            {h.verified && <span style={{fontSize:10,color:"#34d399"}} title="Verifierad">✓</span>}
            {isPremium && <span style={{fontSize:8,fontWeight:700,color:tierMeta.color,background:`${tierMeta.color}1f`,border:`1px solid ${tierMeta.color}55`,borderRadius:4,padding:"1px 5px",textTransform:"uppercase"}}>{tierMeta.label}</span>}
          </div>
          {h.speciality && <div style={{fontSize:11,color:"#a78bfa",marginBottom:3}}>🔍 {h.speciality}</div>}
          {h.tagline && <div style={{fontSize:11,color:"var(--tx2)",lineHeight:1.5,marginBottom:5,overflow:"hidden",display:"-webkit-box",WebkitLineClamp:2,WebkitBoxOrient:"vertical"}}>{h.tagline}</div>}
          <div style={{display:"flex",gap:6,alignItems:"center",justifyContent:"space-between"}}>
            <span style={{fontSize:9,color:"var(--tx4)"}}>Sedan {h.since} · {h.places} platser</span>
            <span style={{fontSize:11,fontWeight:700,color:"#a78bfa"}}>Se profil →</span>
          </div>
        </div>
      </div>
    </div>
  );
}

// ── DETALJVY FÖR SPÖKJÄGARE (modal) ───────────────────────────
function HunterDetailModal({ h, user, onClose, onUpgrade }) {
  const tierMeta = HUNTER_TIERS[h.tier] || HUNTER_TIERS.free;
  const isPremium = h.tier && h.tier !== "free";
  const [contactMsg, setContactMsg] = useState("");
  const [sent, setSent] = useState(false);

  function sendContact() {
    if (!contactMsg.trim()) return;
    // I produktion: spara i hunter_questions / partner_questions med hunter_id
    setSent(true);
    setContactMsg("");
  }

  return (
    <div className="modal-overlay" onClick={e=>{if(e.target===e.currentTarget)onClose();}}>
      <div className="modal-sheet au" style={{maxHeight:"94vh",overflowY:"auto",maxWidth:580,padding:0}}>
        {/* HERO BANNER */}
        <div style={{height:120,background:`linear-gradient(135deg,${isPremium?tierMeta.color+"55":"#241245"},#0d0b1a)`,position:"relative",borderRadius:"16px 16px 0 0"}}>
          {isPremium && <div style={{position:"absolute",top:14,left:14,background:`linear-gradient(90deg,${tierMeta.color},${tierMeta.color}aa)`,fontSize:9,fontWeight:800,color:"#1a0a36",padding:"4px 10px",borderRadius:7,letterSpacing:0.5}}>{h.tier==="spotlight"?"★ SPOTLIGHT":"✨ PREMIUM"}</div>}
          <button onClick={onClose} style={{position:"absolute",top:14,right:14,background:"rgba(7,6,15,0.7)",border:"1px solid var(--b)",color:"var(--tx)",cursor:"pointer",fontSize:16,width:32,height:32,borderRadius:"50%"}}>✕</button>
        </div>

        <div style={{padding:"0 22px 22px",marginTop:-40}}>
          {/* AVATAR + NAMN */}
          <div style={{display:"flex",gap:12,alignItems:"flex-end",marginBottom:14}}>
            <div style={{width:80,height:80,borderRadius:"50%",overflow:"hidden",border:`3px solid ${isPremium?tierMeta.color:"#34d399"}`,background:"var(--bg2)",flexShrink:0,boxShadow:"0 4px 16px rgba(0,0,0,0.5)"}}>
              {h.img?<img src={h.img} alt={h.name} style={{width:"100%",height:"100%",objectFit:"cover"}}/>:<div style={{width:"100%",height:"100%",display:"flex",alignItems:"center",justifyContent:"center",fontSize:32}}>👻</div>}
            </div>
            <div style={{flex:1,paddingBottom:6,minWidth:0}}>
              <div style={{display:"flex",gap:6,alignItems:"center",flexWrap:"wrap",marginBottom:2}}>
                <h2 style={{fontSize:18,fontWeight:800,color:"var(--tx)"}}>{h.name}</h2>
                {h.verified && <span style={{fontSize:10,fontWeight:700,color:"#34d399",background:"rgba(52,211,153,0.12)",border:"1px solid rgba(52,211,153,0.3)",borderRadius:4,padding:"1px 5px"}}>✓ VERIFIERAD</span>}
              </div>
              {h.speciality && <div style={{fontSize:11,color:"#a78bfa"}}>🔍 {h.speciality}</div>}
              <div style={{fontSize:10,color:"var(--tx4)",marginTop:2}}>Aktiv sedan {h.since} · {h.places} platser undersökta</div>
            </div>
          </div>

          {/* TAGLINE */}
          {h.tagline && <div style={{fontSize:14,fontWeight:600,color:"var(--tx)",lineHeight:1.5,marginBottom:14,padding:"11px 13px",background:"rgba(124,58,237,0.08)",border:"1px solid rgba(124,58,237,0.2)",borderRadius:10,fontStyle:"italic"}}>"{h.tagline}"</div>}

          {/* OM */}
          {h.bio && (
            <div style={{marginBottom:16}}>
              <div style={{fontSize:10,fontWeight:700,color:"var(--tx3)",letterSpacing:1.5,textTransform:"uppercase",marginBottom:6}}>Om mig</div>
              <div style={{fontSize:13,color:"var(--tx2)",lineHeight:1.7,whiteSpace:"pre-wrap"}}>{h.bio}</div>
            </div>
          )}

          {/* BÄSTA PLATSEN */}
          {h.bestPlace && (
            <div style={{marginBottom:16,background:"linear-gradient(135deg,rgba(124,58,237,0.12),rgba(251,191,36,0.06))",border:"1px solid rgba(124,58,237,0.3)",borderRadius:12,padding:"14px 14px"}}>
              <div style={{fontSize:10,fontWeight:700,color:"#fbbf24",letterSpacing:1.5,textTransform:"uppercase",marginBottom:6}}>★ Bästa platsen</div>
              <div style={{fontSize:15,fontWeight:800,color:"var(--tx)",marginBottom:5}}>{h.bestPlace}</div>
              {h.bestReason && <div style={{fontSize:13,color:"var(--tx2)",lineHeight:1.65,fontStyle:"italic"}}>"{h.bestReason}"</div>}
            </div>
          )}

          {/* BESÖKTA PLATSER */}
          {h.visitedPlaces?.length > 0 && (
            <div style={{marginBottom:16}}>
              <div style={{fontSize:10,fontWeight:700,color:"var(--tx3)",letterSpacing:1.5,textTransform:"uppercase",marginBottom:8}}>Platser jag besökt</div>
              <div style={{display:"grid",gap:6}}>
                {h.visitedPlaces.map((v,i)=>(
                  <div key={i} style={{display:"flex",gap:10,alignItems:"center",padding:"8px 11px",background:"var(--bg3)",border:"1px solid var(--b)",borderRadius:8}}>
                    <span style={{fontSize:14}}>{FLAG[v.country]||"📍"}</span>
                    <span style={{flex:1,fontSize:12,fontWeight:600,color:"var(--tx)"}}>{v.name}</span>
                    <div style={{display:"flex",gap:1}}>
                      {[1,2,3,4,5].map(n=><span key={n} style={{fontSize:10,color:n<=v.spook?"#7c3aed":"var(--b2)"}}>👻</span>)}
                    </div>
                  </div>
                ))}
              </div>
            </div>
          )}

          {/* KOMMANDE */}
          {h.upcoming && (
            <div style={{marginBottom:16,background:"var(--bg3)",border:"1px solid var(--b)",borderRadius:11,padding:"12px 14px"}}>
              <div style={{fontSize:10,fontWeight:700,color:"#34d399",letterSpacing:1.5,textTransform:"uppercase",marginBottom:6}}>📅 Kommande projekt</div>
              <div style={{fontSize:13,color:"var(--tx2)",lineHeight:1.65,whiteSpace:"pre-wrap"}}>{h.upcoming}</div>
            </div>
          )}

          {/* SOCIALA & KANALER */}
          {(h.yt || h.ig || h.fb || h.podcast || h.website) && (
            <div style={{marginBottom:16}}>
              <div style={{fontSize:10,fontWeight:700,color:"var(--tx3)",letterSpacing:1.5,textTransform:"uppercase",marginBottom:8}}>Mina kanaler — följ & stötta</div>
              <div style={{display:"flex",gap:7,flexWrap:"wrap"}}>
                {h.yt && <a href={h.yt} target="_blank" rel="noreferrer" style={{display:"flex",alignItems:"center",gap:5,background:"rgba(239,68,68,0.1)",border:"1px solid rgba(239,68,68,0.3)",borderRadius:8,padding:"6px 11px",fontSize:11,fontWeight:600,color:"#f87171",textDecoration:"none"}}>▶ YouTube</a>}
                {h.podcast && <a href={h.podcast} target="_blank" rel="noreferrer" style={{display:"flex",alignItems:"center",gap:5,background:"rgba(52,211,153,0.1)",border:"1px solid rgba(52,211,153,0.3)",borderRadius:8,padding:"6px 11px",fontSize:11,fontWeight:600,color:"#34d399",textDecoration:"none"}}>🎙️ Podcast</a>}
                {h.ig && <a href={h.ig} target="_blank" rel="noreferrer" style={{display:"flex",alignItems:"center",gap:5,background:"rgba(236,72,153,0.1)",border:"1px solid rgba(236,72,153,0.3)",borderRadius:8,padding:"6px 11px",fontSize:11,fontWeight:600,color:"#f472b6",textDecoration:"none"}}>📷 Instagram</a>}
                {h.fb && <a href={h.fb} target="_blank" rel="noreferrer" style={{display:"flex",alignItems:"center",gap:5,background:"rgba(96,165,250,0.1)",border:"1px solid rgba(96,165,250,0.3)",borderRadius:8,padding:"6px 11px",fontSize:11,fontWeight:600,color:"#60a5fa",textDecoration:"none"}}>👥 Facebook</a>}
                {h.website && <a href={h.website} target="_blank" rel="noreferrer" style={{display:"flex",alignItems:"center",gap:5,background:"var(--card)",border:"1px solid var(--b2)",borderRadius:8,padding:"6px 11px",fontSize:11,fontWeight:600,color:"var(--tx2)",textDecoration:"none"}}>🔗 Hemsida</a>}
              </div>
            </div>
          )}

          {/* KONTAKTFORM */}
          <div style={{padding:"12px 14px",background:"var(--bg3)",border:"1px solid var(--b)",borderRadius:11,marginBottom:12}}>
            <div style={{fontSize:11,fontWeight:700,color:"var(--tx2)",marginBottom:6}}>💬 Kontakta {h.name.split(" ")[0]}</div>
            {sent ? (
              <div style={{fontSize:12,color:"#34d399",padding:"6px 0"}}>✓ Skickat — landar i adminpanelen och vidarebefordras till {h.name.split(" ")[0]}.</div>
            ) : (
              <>
                {!user && <div style={{fontSize:11,color:"#fbbf24",marginBottom:8}}>⚠️ Logga in för att skicka meddelande.</div>}
                <textarea className="inp" rows={3} placeholder={`Hej ${h.name.split(" ")[0]}!…`} value={contactMsg} onChange={e=>setContactMsg(e.target.value)} style={{resize:"vertical",marginBottom:8,fontSize:12}} disabled={!user}/>
                <Btn ch="📨 Skicka meddelande" v="p" sz="sm" disabled={!user||!contactMsg.trim()} onClick={sendContact}/>
              </>
            )}
          </div>

          {/* ÄR DETTA DU? — uppgradera */}
          {user && user.id === h.id && (
            <div style={{padding:"11px 13px",background:"rgba(124,58,237,0.08)",border:"1px solid rgba(124,58,237,0.3)",borderRadius:10}}>
              <div style={{fontSize:11,fontWeight:700,color:"#a78bfa",marginBottom:4}}>Det här är din profil</div>
              <div style={{fontSize:11,color:"var(--tx3)",marginBottom:8,lineHeight:1.5}}>Vill du synas mer? Uppgradera till Premium (79 kr/mån) för att featuras emellanåt eller Spotlight (129 kr/mån) för permanent topp-placering.</div>
              <Btn ch="✨ Se uppgraderingar" v="p" sz="sm" onClick={onUpgrade}/>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}

// ── UPPGRADERA SPÖKJÄGAR-PROFIL (modal) ───────────────────────
function HunterUpgradeModal({ user, onClose }) {
  const [selected, setSelected] = useState("premium");
  const [loading, setLoading] = useState(false);
  const [done, setDone] = useState(false);
  const [err, setErr] = useState("");

  async function order() {
    if (!user) { setErr("Logga in först"); return; }
    setLoading(true); setErr("");
    try {
      const t = HUNTER_TIERS[selected];
      // I produktion: call createHunterOrder + redirect till Stripe Checkout
      // Här simulerar vi en pending order (kräver inloggning)
      try {
        await createHunterOrder({
          product: selected==="premium"?"premium_79":selected==="spotlight"?"spotlight_129":"article_1299",
          amount: t.price,
          notes: ""
        });
      } catch(_) { /* funkar inte utan Supabase-uppkoppling, men funkar lokalt */ }
      setDone(true);
    } catch(e) { setErr("Något gick fel: " + e.message); }
    finally { setLoading(false); }
  }

  if (done) return (
    <div className="modal-overlay" onClick={e=>{if(e.target===e.currentTarget)onClose();}}>
      <div className="modal-sheet au" style={{textAlign:"center",padding:"32px 22px"}}>
        <div style={{fontSize:48,marginBottom:12}}>📨</div>
        <h2 style={{fontSize:18,fontWeight:800,color:"var(--tx)",marginBottom:8}}>Tack — beställning mottagen!</h2>
        <p style={{fontSize:13,color:"var(--tx2)",lineHeight:1.65,marginBottom:18}}>
          Fredrik kontaktar dig inom 24 timmar med betalningslänk för <strong style={{color:HUNTER_TIERS[selected].color}}>{HUNTER_TIERS[selected].label}</strong>.
          {selected === "article" && " För artikeln bokar vi in en intervju (ca 30 min)."}
        </p>
        <Btn ch="Stäng" v="p" full onClick={onClose}/>
      </div>
    </div>
  );

  return (
    <div className="modal-overlay" onClick={e=>{if(e.target===e.currentTarget)onClose();}}>
      <div className="modal-sheet au" style={{maxHeight:"94vh",overflowY:"auto"}}>
        <div className="modal-handle"/>
        <button onClick={onClose} style={{position:"absolute",top:14,right:14,background:"none",border:"none",color:"var(--tx3)",cursor:"pointer",fontSize:22,padding:4}}>✕</button>
        <h2 style={{fontSize:20,fontWeight:800,color:"var(--tx)",marginBottom:6}}>✨ Synas mer som spökjägare</h2>
        <p style={{fontSize:12,color:"var(--tx3)",marginBottom:16,lineHeight:1.55}}>
          Vill du marknadsföra din pod, kanal eller dig själv på Spökkartan? Välj nivå nedan.
        </p>

        <div style={{display:"grid",gap:11,marginBottom:14}}>
          {Object.entries(HUNTER_TIERS).filter(([k])=>k!=="free").map(([code,t])=>{
            const sel = selected===code;
            return (
              <button key={code} onClick={()=>setSelected(code)} style={{background:sel?`${t.color}1a`:"var(--bg3)",border:`2px solid ${sel?t.color:"var(--b)"}`,borderRadius:12,padding:"14px",cursor:"pointer",textAlign:"left",position:"relative"}}>
                <div style={{display:"flex",justifyContent:"space-between",alignItems:"flex-start",gap:10,marginBottom:6}}>
                  <div>
                    <div style={{fontSize:14,fontWeight:800,color:sel?t.color:"var(--tx)"}}>{t.label}</div>
                    <div style={{fontSize:11,color:"var(--tx3)",marginTop:1}}>{t.pitch}</div>
                  </div>
                  <div style={{textAlign:"right",flexShrink:0}}>
                    <div style={{fontSize:18,fontWeight:800,color:sel?t.color:"var(--tx)"}}>{t.price.toLocaleString("sv-SE")} kr</div>
                    {t.period && <div style={{fontSize:9,color:"var(--tx4)"}}>{t.period}</div>}
                  </div>
                </div>
                <ul style={{listStyle:"none",padding:0,margin:0,display:"grid",gap:3}}>
                  {t.perks.map((perk,i)=>(<li key={i} style={{fontSize:11,color:"var(--tx2)",display:"flex",gap:6}}><span style={{color:t.color}}>✓</span> {perk}</li>))}
                </ul>
                {sel && <span style={{position:"absolute",top:12,right:12,color:t.color,fontSize:18,fontWeight:800}}>✓</span>}
              </button>
            );
          })}
        </div>

        <div style={{fontSize:11,color:"var(--tx3)",marginBottom:12,padding:"9px 11px",background:"rgba(96,165,250,0.07)",border:"1px solid rgba(96,165,250,0.2)",borderRadius:9,lineHeight:1.55}}>
          ℹ️ Du beställer nu — Fredrik skickar betalningslänk inom 24h. Avbryt när du vill.
        </div>

        {err && <div style={{background:"rgba(239,68,68,0.1)",border:"1px solid rgba(239,68,68,0.3)",borderRadius:8,padding:"8px 12px",fontSize:12,color:"#ef4444",marginBottom:10}}>{err}</div>}

        <Btn ch={loading?"Skickar…":`Beställ ${HUNTER_TIERS[selected].label} →`} v="p" full onClick={order} disabled={loading}/>
      </div>
    </div>
  );
}


// ── SIMULATED SCRAPER DATA ────────────────────────────────────
const SCRAPER_QUEUE = [
  {id:"sc1",name:"Ancient Ram Inn",country:"UK",region:"Gloucestershire",type:"Spökhus",scary:5,source:"BBC Travel",url:"https://www.bbc.com",status:"new",lat:51.733,lng:-2.267,teaser:"Englands mörkaste hus — djävulsbesvärjelse, barngravar och poltergeister sedan 1100-talet.",description:"Ancient Ram Inn i Wotton-under-Edge, Gloucestershire, är av många ansett som det mest hemsökta huset i England. Byggt på en hednisk begravningsplats från 5000 f.Kr, och senare på en saxisk kyrkogård. Ägaren John Humphries bodde ensam i det förfallna huset och välkomnade paranormala utredare i decennier."},
  {id:"sc2",name:"Leap Castle",country:"Irland",region:"County Offaly",type:"Slott",scary:5,source:"VisitIreland",url:"https://www.ireland.com",status:"new",lat:52.950,lng:-7.874,teaser:"Oublietten med hundratals skelett — Leap Castle anses vara Irlands mest hemsökta slott med en elemental som bevakar ruinen.",description:"Leap Castle i County Offaly byggdes av O'Bannons på 1400-talet. I en oubliett hittades hundratals skelett med spett, vilket vittnar om massaker. En 'elemental' — ett litet apliknande väsen med rutten lukt — rapporteras fortfarande."},
  {id:"sc3",name:"Château de Brissac",country:"Frankrike",region:"Maine-et-Loire",type:"Slott",scary:4,source:"Wikipedia",url:"https://fr.wikipedia.org",status:"new",lat:47.359,lng:-0.441,teaser:"La Dame Verte — den gröna damen som dödades av sin make på 1400-talet hemsöker det franska slottets övre rum.",description:"Château de Brissac i Loire-dalen är ett av Frankrikes vackraste slott med 204 rum. La Dame Verte, Charlotte de Brézé, mördades av sin make efter att ha tagit en älskare. Hennes gestalt rapporteras i det övre tornet."},
  {id:"sc4",name:"Corvin Castle",country:"Rumänien",region:"Hunedoara",type:"Slott",scary:5,source:"Wikipedia",url:"https://ro.wikipedia.org",status:"new",lat:45.749,lng:22.889,teaser:"Vlad Impalaren fängslades här i 7 år — ett av Europas bäst bevarade gotiska slott med blodiga historier.",description:"Corvins slott i Hunedoara är ett av Europas vackraste och mest hemsökta gotiska slott. Vlad III Impaler (Dracula-inspirationen) hölls fången här 1462-1475. Tortyrkammaren och brunnstunneln är platsens mörkaste hörn."},
  {id:"sc5",name:"Eastern State Penitentiary",country:"USA",region:"Philadelphia, PA",type:"Fängelse",scary:5,source:"easternstate.org",url:"https://www.easternstate.org",status:"pending",lat:39.968,lng:-75.173,teaser:"Det gotiska fängelset som pionjärade isolationssystemet 1829 — tusentals sinnen knäcktes här.",description:"Eastern State Penitentiary öppnade 1829 som ett revolutionärt experiment i isolationsbestraffning. Fångarna hölls i fullständig isolering och fick aldrig tala. Al Capone satt i cell 8."},
  {id:"sc6",name:"Château de Chambord",country:"Frankrike",region:"Loire-et-Cher",type:"Slott",scary:3,source:"UNESCO",url:"https://www.chambord.org",status:"new",lat:47.616,lng:1.517,teaser:"Francis I:s drömslott med Leonardo da Vincis dubbla spiraltrappa — en kunglig gestalt ska vandra de 440 rummen.",description:"Château de Chambord är ett av världens vackraste renässansslott med 440 rum och 365 eldstäder. En kunglig gestalt i jaktdräkt ses ibland i de övre salarna."},
];

const SIMULATED_USERS = [
  {id:"u1",name:"Anna Lindqvist",email:"anna@example.com",role:"user",pro:true,created:"2025-12-01",country:"Sverige",visits:12},
  {id:"u2",name:"Erik Svensson",email:"erik@example.com",role:"user",pro:false,created:"2026-01-15",country:"Sverige",visits:3},
  {id:"u3",name:"Gunnar Borg",email:"gunnar@example.com",role:"ghosthunter",pro:true,created:"2026-02-20",country:"Sverige",visits:34},
  {id:"u4",name:"Maria Hansen",email:"maria@example.com",role:"user",pro:true,created:"2026-03-05",country:"Norge",visits:8},
  {id:"u5",name:"Lars Petersen",email:"lars@example.com",role:"user",pro:false,created:"2026-04-01",country:"Danmark",visits:2},
];

const SCRAPER_JOBS = [
  {id:"j1",name:"Europa — Slott & Herrgårdar",region:"Europa",status:"running",last:"2026-04-24 09:15",found:12,queue:6,progress:68},
  {id:"j2",name:"Skandinavien — Okänt material",region:"Sverige/Norge/Danmark",status:"done",last:"2026-04-23 22:00",found:8,queue:0,progress:100},
  {id:"j3",name:"British Isles — Haunted Houses",region:"UK/Irland",status:"scheduled",last:"2026-04-25 03:00",found:0,queue:0,progress:0},
  {id:"j4",name:"USA — Paranormal Hotspots",region:"USA/Kanada",status:"scheduled",last:"2026-04-26 03:00",found:0,queue:0,progress:0},
];

function AdminDash({allPlaces,setAllPlaces,user,onLogout}) {
  const [tab,setTab]=useState("overview");
  const [search,setSearch]=useState("");
  const [sel,setSel]=useState([]);
  const [editing,setEditing]=useState(null);
  const [instruction,setInstruction]=useState("");
  const [instructions,setInstructions]=useState([
    {id:1,text:"Prioritera platser i Rumänien, Polen och Tjeckien näst",done:false,ts:"2026-04-20"},
    {id:2,text:"Sök efter hemsökta hotell i Australien och Nya Zeeland",done:false,ts:"2026-04-22"},
  ]);
  const [scraperQueue,setScraperQueue]=useState(SCRAPER_QUEUE);

  const pub=allPlaces.filter(p=>p.status==="published");
  const drafts=allPlaces.filter(p=>p.status==="draft");
  const newScrapes=scraperQueue.filter(p=>p.status==="new");
  const allUsers=[...SIMULATED_USERS,...Object.values(USERS_DB).filter(u=>u.id!=="admin-1").map(u=>({...u,visits:0}))];
  const proUsers=allUsers.filter(u=>u.pro);
  const hunterUsers=allUsers.filter(u=>u.role==="ghosthunter"||u.role==="pending_hunter");

  const shown=allPlaces.filter(p=>!search||p.name?.toLowerCase().includes(search.toLowerCase()));

  function publishSel(){setAllPlaces(prev=>prev.map(p=>sel.includes(p.id)?{...p,status:"published"}:p));setSel([]);}
  function approveScrape(id){
    const item=scraperQueue.find(x=>x.id===id);
    if(!item) return;
    const newPlace={...item,id:"p"+Date.now(),status:"draft",free:false,bookable:false,bookingUrl:"",img:"",img_credit:"",date:new Date().toISOString().slice(0,10),points:item.scary*20,categories:[item.type,item.country],featured:false,new:true,slug:item.name.toLowerCase().replace(/\s+/g,"-")};
    setAllPlaces(prev=>[...prev,newPlace]);
    setScraperQueue(prev=>prev.filter(x=>x.id!==id));
  }
  function rejectScrape(id){setScraperQueue(prev=>prev.filter(x=>x.id!==id));}
  function addInstruction(){
    if(!instruction.trim()) return;
    setInstructions(prev=>[...prev,{id:Date.now(),text:instruction.trim(),done:false,ts:new Date().toISOString().slice(0,10)}]);
    setInstruction("");
  }

  const TABS=[["overview","📊","Översikt"],["places","📍","Platser"],["scraper","🔍","Scraper"],["users","👤","Användare"],["settings","⚙️","Inställningar"]];

  return(
    <div style={{flex:1,display:"flex",flexDirection:"column",overflow:"hidden"}}>
      {/* Admin header */}
      <div style={{background:"rgba(7,6,15,0.97)",borderBottom:"1px solid var(--b)",padding:"10px 14px",display:"flex",gap:8,alignItems:"center",flexShrink:0,flexWrap:"wrap"}}>
        <span style={{fontSize:14,fontWeight:800,color:"var(--tx)"}}>⚙️ Admin</span>
        <div style={{display:"flex",gap:2,background:"var(--bg3)",border:"1px solid var(--b)",borderRadius:9,padding:2,overflowX:"auto"}}>
          {TABS.map(([v,icon,label])=>(
            <button key={v} onClick={()=>setTab(v)} style={{background:tab===v?"#7c3aed":"transparent",border:"none",borderRadius:7,padding:"6px 10px",fontSize:11,fontWeight:600,color:tab===v?"#fff":"var(--tx3)",cursor:"pointer",whiteSpace:"nowrap",display:"flex",alignItems:"center",gap:4}}>
              {icon}<span className="resp-label">{label}</span>
              {v==="scraper"&&newScrapes.length>0&&<span style={{background:"#fbbf24",borderRadius:"50%",width:14,height:14,display:"inline-flex",alignItems:"center",justifyContent:"center",fontSize:8,fontWeight:700,color:"#000"}}>{newScrapes.length}</span>}
            </button>
          ))}
        </div>
        <div style={{display:"flex",gap:7,marginLeft:"auto",alignItems:"center",flexWrap:"wrap"}}>
          <span style={{fontSize:10,color:"#34d399"}}>✅ {pub.length}</span>
          <span style={{fontSize:10,color:"#fbbf24"}}>📝 {drafts.length}</span>
          <span style={{fontSize:10,color:"#a78bfa"}}>👻 {newScrapes.length} nya</span>
          <Btn ch="Logga ut" v="ghost" sz="sm" onClick={onLogout}/>
        </div>
      </div>

      <div style={{flex:1,overflowY:"auto",padding:"14px"}}>

        {/* ── OVERVIEW ── */}
        {tab==="overview"&&(
          <div>
            {/* Stats grid */}
            <div style={{display:"grid",gridTemplateColumns:"repeat(auto-fill,minmax(130px,1fr))",gap:10,marginBottom:16}}>
              {[
                ["Platser",allPlaces.length,"📍","#a78bfa"],
                ["Live",pub.length,"✅","#34d399"],
                ["Utkast",drafts.length,"📝","#fbbf24"],
                ["Användare",allUsers.length,"👤","#60a5fa"],
                ["PRO",proUsers.length,"💎","#d4af37"],
                ["Jägare",hunterUsers.length,"🔍","#f472b6"],
              ].map(([l,v,icon,c])=>(
                <div key={l} style={{background:"var(--card)",border:"1px solid var(--b)",borderRadius:12,padding:"12px 14px",borderTop:"2px solid "+c}}>
                  <div style={{fontSize:16,marginBottom:3}}>{icon}</div>
                  <div style={{fontSize:22,fontWeight:800,color:"var(--tx)"}}>{v}</div>
                  <div style={{fontSize:10,color:"var(--tx3)"}}>{l}</div>
                </div>
              ))}
            </div>

            {/* Scraper jobs */}
            <div style={{background:"var(--card)",border:"1px solid var(--b)",borderRadius:12,padding:"14px",marginBottom:14}}>
              <div style={{fontSize:13,fontWeight:700,color:"var(--tx)",marginBottom:10,display:"flex",justifyContent:"space-between"}}>🔍 Scraper-jobb<button onClick={()=>setTab("scraper")} style={{background:"none",border:"none",fontSize:11,color:"#a78bfa",cursor:"pointer"}}>Se alla →</button></div>
              {SCRAPER_JOBS.map(j=>(
                <div key={j.id} style={{display:"flex",gap:10,alignItems:"center",padding:"7px 0",borderBottom:"1px solid var(--b)"}}>
                  <div style={{width:7,height:7,borderRadius:"50%",flexShrink:0,background:j.status==="running"?"#34d399":j.status==="done"?"#60a5fa":j.status==="scheduled"?"#fbbf24":"#f87171"}}/>
                  <div style={{flex:1,minWidth:0}}>
                    <div style={{fontSize:11,fontWeight:600,color:"var(--tx)",overflow:"hidden",textOverflow:"ellipsis",whiteSpace:"nowrap"}}>{j.name}</div>
                    <div style={{fontSize:9,color:"var(--tx4)"}}>{j.status==="running"?"Kör nu…":j.status==="done"?"Klar · "+j.found+" hittade":j.status==="scheduled"?"Schemalagd: "+j.last:"Väntar"}</div>
                  </div>
                  {j.status==="running"&&<div style={{width:60,height:4,background:"var(--b)",borderRadius:2,overflow:"hidden"}}><div style={{height:"100%",background:"#34d399",width:j.progress+"%"}}/></div>}
                  {j.found>0&&<span style={{fontSize:9,fontWeight:700,color:"#fbbf24"}}>{j.found} nya</span>}
                </div>
              ))}
            </div>

            {/* Quick actions */}
            <div style={{background:"var(--card)",border:"1px solid var(--b)",borderRadius:12,padding:"14px",marginBottom:14}}>
              <div style={{fontSize:13,fontWeight:700,color:"var(--tx)",marginBottom:10}}>🚀 Snabbåtgärder</div>
              <div style={{display:"flex",gap:8,flexWrap:"wrap"}}>
                <Btn ch={"✅ Publicera alla "+drafts.length+" utkast"} v="g" sz="sm" onClick={()=>setAllPlaces(prev=>prev.map(p=>({...p,status:"published"})))}/>
                <Btn ch="📍 Platser" v="ghost" sz="sm" onClick={()=>setTab("places")}/>
                <Btn ch={"🔍 Granska "+newScrapes.length+" nya"} v="ghost" sz="sm" onClick={()=>setTab("scraper")}/>
              </div>
            </div>

            {/* Instruction inbox */}
            <div style={{background:"var(--card)",border:"1px solid var(--b)",borderRadius:12,padding:"14px"}}>
              <div style={{fontSize:13,fontWeight:700,color:"var(--tx)",marginBottom:10}}>📝 Instruktioner till scrapern</div>
              <div style={{display:"flex",gap:8,marginBottom:12}}>
                <input className="inp inp-sm" value={instruction} onChange={e=>setInstruction(e.target.value)} placeholder="Lägg till instruktion…" style={{flex:1}} onKeyDown={e=>e.key==="Enter"&&addInstruction()}/>
                <Btn ch="+ Lägg till" v="p" sz="sm" onClick={addInstruction}/>
              </div>
              {instructions.map(ins=>(
                <div key={ins.id} style={{display:"flex",gap:8,alignItems:"center",padding:"7px 0",borderBottom:"1px solid var(--b)",opacity:ins.done?0.5:1}}>
                  <input type="checkbox" checked={ins.done} onChange={()=>setInstructions(prev=>prev.map(x=>x.id===ins.id?{...x,done:!x.done}:x))} style={{accentColor:"#7c3aed",flexShrink:0}}/>
                  <span style={{flex:1,fontSize:12,color:"var(--tx2)",textDecoration:ins.done?"line-through":"none"}}>{ins.text}</span>
                  <span style={{fontSize:9,color:"var(--tx4)"}}>{ins.ts}</span>
                  <button onClick={()=>setInstructions(prev=>prev.filter(x=>x.id!==ins.id))} style={{background:"none",border:"none",color:"var(--tx4)",cursor:"pointer",fontSize:12}}>✕</button>
                </div>
              ))}
            </div>
          </div>
        )}

        {/* ── PLACES ── */}
        {tab==="places"&&(
          <div>
            <div style={{display:"flex",gap:7,marginBottom:12,flexWrap:"wrap",alignItems:"center"}}>
              <input className="inp inp-sm" placeholder="Sök plats…" value={search} onChange={e=>setSearch(e.target.value)} style={{flex:1,minWidth:120}}/>
              {sel.length>0&&<Btn ch={"✅ Publicera ("+sel.length+")"} v="g" sz="sm" onClick={publishSel}/>}
              {sel.length>0&&<Btn ch={"🗑️ Radera ("+sel.length+")"} v="danger" sz="sm" onClick={()=>{setAllPlaces(prev=>prev.filter(p=>!sel.includes(p.id)));setSel([]);}}/>}
              <span style={{fontSize:10,color:"var(--tx4)"}}>{shown.length} platser</span>
            </div>
            <div style={{background:"var(--card)",border:"1px solid var(--b)",borderRadius:12,overflow:"hidden"}}>
              <div style={{overflowX:"auto"}}>
                <table className="atbl">
                  <thead><tr>
                    <th><input type="checkbox" onChange={e=>setSel(e.target.checked?shown.slice(0,100).map(p=>p.id):[])} style={{accentColor:"#7c3aed"}}/></th>
                    <th>Namn</th><th>Land</th><th>Typ</th><th>Status</th><th style={{textAlign:"right"}}>✏️</th>
                  </tr></thead>
                  <tbody>{shown.slice(0,100).map(p=>(
                    <tr key={p.id}>
                      <td><input type="checkbox" checked={sel.includes(p.id)} onChange={e=>setSel(s=>e.target.checked?[...s,p.id]:s.filter(x=>x!==p.id))} style={{accentColor:"#7c3aed"}}/></td>
                      <td style={{maxWidth:160,overflow:"hidden",textOverflow:"ellipsis",whiteSpace:"nowrap",fontWeight:500,color:"var(--tx)",fontSize:12}}>{p.name}</td>
                      <td style={{whiteSpace:"nowrap",fontSize:11}}>{FLAG[p.country]||"🌍"} {p.country}</td>
                      <td style={{fontSize:10,color:"var(--tx3)",whiteSpace:"nowrap"}}>{p.type}</td>
                      <td><span style={{background:p.status==="published"?"rgba(52,211,153,0.15)":"rgba(251,191,36,0.15)",border:"1px solid "+(p.status==="published"?"rgba(52,211,153,0.4)":"rgba(251,191,36,0.4)"),borderRadius:5,padding:"2px 6px",fontSize:9,fontWeight:700,color:p.status==="published"?"#34d399":"#fbbf24"}}>{p.status==="published"?"✅":"📝"}</span></td>
                      <td style={{textAlign:"right"}}><button onClick={()=>setEditing({...p})} style={{background:"none",border:"none",cursor:"pointer",color:"#a78bfa",fontSize:14}}>✏️</button></td>
                    </tr>
                  ))}</tbody>
                </table>
              </div>
            </div>
          </div>
        )}

        {/* ── SCRAPER ── */}
        {tab==="scraper"&&(
          <div>
            {/* Job status */}
            <div style={{background:"var(--card)",border:"1px solid var(--b)",borderRadius:12,padding:"14px",marginBottom:14}}>
              <div style={{fontSize:13,fontWeight:700,color:"var(--tx)",marginBottom:10}}>🤖 Automatiska sökningar</div>
              {SCRAPER_JOBS.map(j=>(
                <div key={j.id} style={{padding:"10px 0",borderBottom:"1px solid var(--b)"}}>
                  <div style={{display:"flex",gap:8,alignItems:"center",marginBottom:5}}>
                    <div style={{width:8,height:8,borderRadius:"50%",flexShrink:0,background:j.status==="running"?"#34d399":j.status==="done"?"#60a5fa":j.status==="scheduled"?"#fbbf24":"#6b5e8a"}}/>
                    <span style={{fontSize:12,fontWeight:600,color:"var(--tx)",flex:1}}>{j.name}</span>
                    <span style={{fontSize:9,fontWeight:700,color:"var(--tx3)",background:"var(--bg3)",borderRadius:5,padding:"2px 6px"}}>{j.status==="running"?"KÖR":j.status==="done"?"KLAR":j.status==="scheduled"?"SCHEMALAGD":"VÄNTAR"}</span>
                  </div>
                  {j.status==="running"&&<div style={{background:"var(--b)",borderRadius:999,height:4,overflow:"hidden",marginLeft:16}}><div style={{height:"100%",background:"linear-gradient(90deg,#34d399,#60a5fa)",borderRadius:999,width:j.progress+"%",transition:"width 1s"}}/></div>}
                  <div style={{fontSize:10,color:"var(--tx4)",marginLeft:16,marginTop:3}}>{j.region} · {j.status==="done"?j.found+" platser hittade":j.status==="scheduled"?"Nästa: "+j.last:"Senast: "+j.last}</div>
                </div>
              ))}
            </div>

            {/* New places queue */}
            <div style={{fontSize:13,fontWeight:700,color:"var(--tx)",marginBottom:10}}>
              🆕 Nya platser att granska ({scraperQueue.filter(p=>p.status==="new").length})
            </div>
            {scraperQueue.length===0&&<div style={{background:"var(--card)",border:"1px solid var(--b)",borderRadius:12,padding:"20px",textAlign:"center",color:"var(--tx4)",fontSize:12}}>✅ Kön är tom — inga platser att granska just nu.</div>}
            {scraperQueue.map((p,i)=>(
              <div key={p.id} className="au" style={{animationDelay:i*0.06+"s",background:"var(--card)",border:"1px solid "+(p.status==="pending"?"rgba(251,191,36,0.3)":"var(--b)"),borderRadius:12,padding:"14px",marginBottom:10}}>
                <div style={{display:"flex",gap:8,alignItems:"flex-start",marginBottom:8}}>
                  <div style={{flex:1}}>
                    <div style={{display:"flex",gap:5,marginBottom:4,flexWrap:"wrap"}}>
                      <span style={{background:"rgba(124,58,237,0.12)",border:"1px solid rgba(124,58,237,0.3)",borderRadius:5,padding:"1px 7px",fontSize:9,fontWeight:700,color:"#a78bfa"}}>{p.status==="pending"?"⏳ VÄNTAR":"🆕 NY"}</span>
                      <Tag ch={FLAG[p.country]||"🌍"+" "+p.country} c="var(--tx3)"/>
                      <Tag ch={p.type} c="var(--acc)"/>
                    </div>
                    <div style={{fontSize:14,fontWeight:700,color:"var(--tx)",marginBottom:3}}>{p.name}</div>
                    <div style={{fontSize:11,color:"var(--tx3)",marginBottom:5}}>{p.region}</div>
                    <div style={{fontSize:12,color:"var(--tx2)",lineHeight:1.6}}>{p.teaser}</div>
                    {p.source&&<div style={{fontSize:10,color:"var(--tx4)",marginTop:5}}>Källa: <a href={p.url} target="_blank" rel="noreferrer" style={{color:"#a78bfa"}}>{p.source}</a></div>}
                  </div>
                  <div style={{display:"flex",flexDirection:"column",gap:6,flexShrink:0}}>
                    <Btn ch="✅ Godkänn" v="g" sz="sm" onClick={()=>approveScrape(p.id)}/>
                    <Btn ch="✕ Avvisa" v="danger" sz="sm" onClick={()=>rejectScrape(p.id)}/>
                  </div>
                </div>
                <Scary n={p.scary||3}/>
              </div>
            ))}

            {/* Instruction input */}
            <div style={{background:"var(--card)",border:"1px solid var(--b)",borderRadius:12,padding:"14px",marginTop:14}}>
              <div style={{fontSize:12,fontWeight:700,color:"var(--tx)",marginBottom:8}}>📝 Ge instruktioner till scrapern</div>
              <div style={{display:"flex",gap:8}}>
                <input className="inp inp-sm" value={instruction} onChange={e=>setInstruction(e.target.value)} placeholder="T.ex. 'Sök hemsökta platser i Australien'" style={{flex:1}} onKeyDown={e=>e.key==="Enter"&&addInstruction()}/>
                <Btn ch="Skicka" v="p" sz="sm" onClick={addInstruction}/>
              </div>
              <div style={{marginTop:10,display:"flex",flexDirection:"column",gap:5}}>
                {instructions.map(ins=>(
                  <div key={ins.id} style={{display:"flex",gap:8,alignItems:"center",fontSize:11,color:ins.done?"var(--tx4)":"var(--tx2)",textDecoration:ins.done?"line-through":"none"}}>
                    <input type="checkbox" checked={ins.done} onChange={()=>setInstructions(p=>p.map(x=>x.id===ins.id?{...x,done:!x.done}:x))} style={{accentColor:"#7c3aed"}}/>
                    <span style={{flex:1}}>{ins.text}</span>
                    <span style={{fontSize:9,color:"var(--tx4)"}}>{ins.ts}</span>
                    <button onClick={()=>setInstructions(p=>p.filter(x=>x.id!==ins.id))} style={{background:"none",border:"none",color:"var(--tx4)",cursor:"pointer"}}>✕</button>
                  </div>
                ))}
              </div>
            </div>
          </div>
        )}

        {/* ── USERS ── */}
        {tab==="users"&&(
          <div>
            <div style={{display:"grid",gridTemplateColumns:"repeat(auto-fill,minmax(130px,1fr))",gap:10,marginBottom:16}}>
              {[["Totalt",allUsers.length,"👤","#60a5fa"],["PRO",proUsers.length,"💎","#d4af37"],["Spökjägare",hunterUsers.filter(u=>u.role==="ghosthunter").length,"🔍","#f472b6"],["Väntar",hunterUsers.filter(u=>u.role==="pending_hunter").length,"⏳","#fbbf24"]].map(([l,v,icon,c])=>(
                <div key={l} style={{background:"var(--card)",border:"1px solid var(--b)",borderRadius:12,padding:"12px 14px",borderTop:"2px solid "+c}}>
                  <div style={{fontSize:16,marginBottom:3}}>{icon}</div>
                  <div style={{fontSize:22,fontWeight:800,color:"var(--tx)"}}>{v}</div>
                  <div style={{fontSize:10,color:"var(--tx3)"}}>{l}</div>
                </div>
              ))}
            </div>
            <div style={{background:"var(--card)",border:"1px solid var(--b)",borderRadius:12,overflow:"hidden"}}>
              <div style={{overflowX:"auto"}}>
                <table className="atbl">
                  <thead><tr><th>Namn</th><th>Roll</th><th>PRO</th><th>Land</th><th>Besök</th><th>Skapad</th></tr></thead>
                  <tbody>{allUsers.map(u=>(
                    <tr key={u.id}>
                      <td style={{fontWeight:500,color:"var(--tx)"}}><div style={{fontSize:12}}>{u.name}</div><div style={{fontSize:9,color:"var(--tx4)"}}>{u.email}</div></td>
                      <td><span style={{fontSize:9,fontWeight:700,color:u.role==="admin"?"#f87171":u.role==="ghosthunter"?"#f472b6":u.role==="pending_hunter"?"#fbbf24":"var(--tx3)"}}>{u.role}</span></td>
                      <td>{u.pro?<span style={{color:"#d4af37",fontSize:11}}>✓</span>:<span style={{color:"var(--tx4)",fontSize:11}}>—</span>}</td>
                      <td style={{fontSize:11}}>{FLAG[u.country]||"🌍"}</td>
                      <td style={{fontSize:11,color:"var(--tx3)"}}>{u.visits||0}</td>
                      <td style={{fontSize:10,color:"var(--tx4)"}}>{u.created?.slice(0,10)}</td>
                    </tr>
                  ))}</tbody>
                </table>
              </div>
            </div>
          </div>
        )}

        {/* ── SETTINGS ── */}
        {tab==="settings"&&(
          <div style={{maxWidth:480}}>
            <div style={{background:"var(--card)",border:"1px solid var(--b)",borderRadius:12,padding:"14px",marginBottom:12}}>
              <div style={{fontSize:12,fontWeight:700,color:"var(--tx)",marginBottom:6}}>Admin-konto</div>
              <div style={{fontSize:12,color:"var(--tx3)",marginBottom:4}}>E-post: <span style={{color:"#a78bfa"}}>{user.email}</span></div>
              <div style={{fontSize:11,color:"var(--tx4)",lineHeight:1.7}}>Koppla Supabase Auth + Resend för produktionsmiljö.</div>
            </div>
            <div style={{background:"var(--card)",border:"1px solid var(--b)",borderRadius:12,padding:"14px"}}>
              <div style={{fontSize:12,fontWeight:700,color:"var(--tx)",marginBottom:10}}>🔗 Affiliate-ID:n</div>
              {[["Booking.com",""],["GetYourGuide",""],["Amazon","spokkartan-21"],["TripAdvisor",""]].map(([name,val])=>(
                <div key={name} style={{display:"flex",gap:8,alignItems:"center",marginBottom:9}}>
                  <span style={{fontSize:11,color:"var(--tx3)",width:100,flexShrink:0}}>{name}</span>
                  <input className="inp inp-sm" defaultValue={val} placeholder="Ditt affiliate-ID" style={{flex:1}}/>
                </div>
              ))}
              <Btn ch="Spara" v="p" sz="sm"/>
            </div>
          </div>
        )}

      </div>

      {/* Edit modal */}
      {editing&&(
        <div className="modal-overlay" onClick={e=>{if(e.target===e.currentTarget)setEditing(null);}}>
          <div className="modal-sheet au">
            <div className="modal-handle"/>
            <button onClick={()=>setEditing(null)} style={{position:"absolute",top:14,right:14,background:"none",border:"none",color:"var(--tx3)",cursor:"pointer",fontSize:20}}>✕</button>
            <h3 style={{fontSize:14,fontWeight:700,color:"var(--tx)",marginBottom:14}}>✏️ {editing.name}</h3>
            {[["name","Namn"],["region","Region"],["type","Typ"],["teaser","Teaser"]].map(([k,l])=>(
              <div key={k} style={{marginBottom:10}}>
                <label style={{fontSize:10,fontWeight:600,color:"var(--tx3)",marginBottom:3,display:"block"}}>{l}</label>
                {k==="teaser"?<textarea className="inp" value={editing[k]||""} onChange={e=>setEditing({...editing,[k]:e.target.value})} rows={2} style={{resize:"none"}}/>:<input className="inp" value={editing[k]||""} onChange={e=>setEditing({...editing,[k]:e.target.value})}/>}
              </div>
            ))}
            <div style={{display:"flex",gap:6,marginBottom:12}}>
              {["published","draft"].map(s=><button key={s} className={"pill"+(editing.status===s?" on":"")} onClick={()=>setEditing({...editing,status:s})}>{s==="published"?"✅ Live":"📝 Utkast"}</button>)}
            </div>
            <div style={{display:"flex",gap:8}}>
              <Btn ch="💾 Spara" v="g" full onClick={()=>{setAllPlaces(prev=>prev.map(p=>p.id===editing.id?editing:p));setEditing(null);}}/>
              <Btn ch="Avbryt" v="ghost" onClick={()=>setEditing(null)}/>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}


// ── SHARE UTILS ───────────────────────────────────────────────
function shareToSocial(platform, title, url) {
  const encoded = encodeURIComponent(url);
  const text = encodeURIComponent(title + " — Spökkartan.se");
  const links = {
    facebook: `https://www.facebook.com/sharer/sharer.php?u=${encoded}`,
    twitter: `https://twitter.com/intent/tweet?text=${text}&url=${encoded}`,
    whatsapp: `https://wa.me/?text=${text}%20${encoded}`,
    copy: null,
  };
  if(platform==="copy") {
    navigator.clipboard?.writeText(url).catch(()=>{});
    return "copied";
  }
  window.open(links[platform], "_blank", "width=600,height=400");
}

function ShareMenu({title,url,onClose}) {
  const [copied,setCopied]=useState(false);
  return(
    <div className="modal-overlay" onClick={e=>{if(e.target===e.currentTarget)onClose();}}>
      <div className="modal-sheet au">
        <div className="modal-handle"/>
        <div style={{fontSize:15,fontWeight:700,color:"var(--tx)",marginBottom:4}}>Dela</div>
        <div style={{fontSize:12,color:"var(--tx3)",marginBottom:16,overflow:"hidden",textOverflow:"ellipsis",whiteSpace:"nowrap"}}>{title}</div>
        <div style={{display:"flex",flexDirection:"column",gap:10}}>
          {[
            ["facebook","📘","Facebook","rgba(59,130,246,0.1)","rgba(59,130,246,0.3)","#60a5fa"],
            ["twitter","🐦","X / Twitter","rgba(17,24,39,0.5)","rgba(75,85,99,0.5)","var(--tx2)"],
            ["whatsapp","💬","WhatsApp","rgba(37,211,102,0.1)","rgba(37,211,102,0.3)","#34d399"],
          ].map(([p,icon,label,bg,border,c])=>(
            <button key={p} onClick={()=>{shareToSocial(p,title,url);onClose();}} style={{background:bg,border:"1px solid "+border,borderRadius:12,padding:"13px 16px",cursor:"pointer",display:"flex",gap:12,alignItems:"center",width:"100%"}}>
              <span style={{fontSize:20}}>{icon}</span><span style={{fontSize:14,fontWeight:600,color:c}}>{label}</span>
            </button>
          ))}
          <button onClick={()=>{shareToSocial("copy",title,url);setCopied(true);setTimeout(()=>setCopied(false),2000);}} style={{background:"var(--bg3)",border:"1px solid var(--b)",borderRadius:12,padding:"13px 16px",cursor:"pointer",display:"flex",gap:12,alignItems:"center",width:"100%"}}>
            <span style={{fontSize:20}}>{copied?"✅":"🔗"}</span><span style={{fontSize:14,fontWeight:600,color:"var(--tx2)"}}>{copied?"Kopierat!":"Kopiera länk"}</span>
          </button>
        </div>
      </div>
    </div>
  );
}

// ── CANCEL SUBSCRIPTION MODAL ─────────────────────────────────
function CancelSubModal({onClose,onConfirm}) {
  const [reason,setReason]=useState("");
  return(
    <div className="modal-overlay" onClick={e=>{if(e.target===e.currentTarget)onClose();}}>
      <div className="modal-sheet au">
        <div className="modal-handle"/>
        <button onClick={onClose} style={{position:"absolute",top:14,right:14,background:"none",border:"none",color:"var(--tx3)",cursor:"pointer",fontSize:20}}>✕</button>
        <div style={{textAlign:"center",marginBottom:16}}>
          <div style={{fontSize:36,marginBottom:8}}>😢</div>
          <div style={{fontSize:17,fontWeight:800,color:"var(--tx)",marginBottom:4}}>Avsluta PRO?</div>
          <div style={{fontSize:12,color:"var(--tx3)",lineHeight:1.6}}>Du förlorar tillgång till alla PRO-platser, koordinater och roadtrip-planeraren.</div>
        </div>
        <div style={{background:"rgba(248,113,113,0.07)",border:"1px solid rgba(248,113,113,0.2)",borderRadius:10,padding:"11px 14px",marginBottom:14}}>
          <div style={{fontSize:11,color:"var(--tx2)",lineHeight:1.6}}>Ditt abonnemang löper ut vid periodens slut. Du debiteras inte mer efter det.</div>
        </div>
        <div style={{marginBottom:14}}>
          <label style={{fontSize:10,fontWeight:700,color:"var(--tx3)",marginBottom:5,display:"block",letterSpacing:0.5}}>ANLEDNING (valfritt)</label>
          <textarea className="inp" rows={2} value={reason} onChange={e=>setReason(e.target.value)} placeholder="Berätta gärna varför…" style={{resize:"none",fontSize:13}}/>
        </div>
        <Btn ch="Avsluta PRO" v="danger" full onClick={()=>{onConfirm();onClose();}}/>
        <Btn ch="Ångra — behåll PRO" v="p" full onClick={onClose} style={{marginTop:8}}/>
      </div>
    </div>
  );
}


// ── PARTNERS ─────────────────────────────────────────────────
// Kategorier — visas både som filter och som "hjältekort" på partners-hubben.
const PARTNER_TYPES = [
  { code: "all",    label: "Alla",            icon: "🌐", short: "Alla partners",            tag: "Bläddra allt" },
  { code: "medium", label: "Medium",          icon: "🔮", short: "Sittningar & seanser",     tag: "Spirituell vägledning" },
  { code: "tarot",  label: "Tarot & spådom",  icon: "🃏", short: "Tarotläggningar online & på plats", tag: "Online & fysiskt" },
  { code: "tour",   label: "Spökvandring",    icon: "🚶", short: "Guidade nattvandringar",   tag: "Kvällsupplevelser" },
  { code: "event",  label: "Event & företag", icon: "🎭", short: "Bolag som arrangerar event", tag: "Privat & företag" },
  { code: "hotel",  label: "Hemsökt boende",  icon: "🏰", short: "Övernatta i spökhus",      tag: "Boka natt" },
  { code: "dinner", label: "Spökmiddag",      icon: "🍽️", short: "Middag med spökhistorier", tag: "Mat + skräck" },
  { code: "hunter", label: "Spökjägare",      icon: "🔍", short: "Yrkesutredare till uthyrning", tag: "Boka utredning" },
  { code: "author", label: "Författare & Pod",icon: "🎙️", short: "Boka för pod, intervju, signering", tag: "Media & innehåll" },
];

// Paket-tiers för PARTNERS (företag som listar sig)
// Lägsta nivå för att vara listad: Bas 29 kr/mån (ingen gratisversion).
const TIER_CONFIG = {
  basic:   { label: "Bas",      color: "#34d399", price: 29,
             pitch: "Lägsta nivån — kom igång och syns på Spökkartan.",
             perks: ["Listas i sökresultat","Egen profilsida","Kontaktknapp","1 paket","Frågeformulär landar hos dig"] },
  pro:     { label: "Pro",      color: "#a78bfa", price: 299,
             pitch: "Sticker ut — högre upp i resultaten + verifierad.",
             perks: ["Allt i Bas","✓ Verified-badge","Prioritet i sök","Obegränsade paket","Bildgalleri (6 bilder)","Egen banner-bild","Statistik (visningar, klick)"] },
  featured:{ label: "Featured", color: "#fbbf24", price: 799,
             pitch: "Förstasidan + cross-promo i nyhetsbrev till tusentals.",
             perks: ["Allt i Pro","Förstasidesvisning emellanåt","Featured-band runt kortet","Cross-promo i nyhetsbrev (10k+)","En sponsrad blogg per kvartal","Snabbsupport av Fredrik"] },
};

// Tiers för SPÖKJÄGARE (privatpersoner som syns på spökjägarsidan)
const HUNTER_TIERS = {
  free:      { label: "Gratis",       color: "#6b7280", price: 0,    period: "",
               pitch: "Skapa profil och visa upp dig — kostar inget.",
               perks: ["Profil med bio & bilder","Lista platser du varit på","Länka YouTube/IG/pod","Synlig i spökjägarlistan"] },
  premium:   { label: "Premium",      color: "#a78bfa", price: 79,   period: "/mån",
               pitch: "Featured emellanåt på första sidan + extra synlighet.",
               perks: ["Allt i Gratis","Featured på spökjägar-startsidan emellanåt","Premium-badge","Egen banner & galleri","Push när vi lyfter dig"] },
  spotlight: { label: "Spotlight",    color: "#fbbf24", price: 129,  period: "/mån",
               pitch: "Permanent topp-placering + cross-promo i sociala medier.",
               perks: ["Allt i Premium","Topp-placering hela månaden","Annons i nyhetsbrevet","Cross-promo i Spökkartans IG/Facebook","Direktkontakt med Fredrik"] },
  article:   { label: "Egen artikel", color: "#f472b6", price: 1299, period: " engångskostnad",
               pitch: "Skräddarsydd artikel skriven om dig + permanent länk.",
               perks: ["Personlig intervju (30 min)","Artikel ~800–1200 ord skriven av redaktionen","Publiceras under 'Möt spökjägaren'","Permanent featured-länk på din profil","Delas i nyhetsbrev + sociala kanaler"] },
};

// ── PARTNERS-VYN ──────────────────────────────────────────────
function PartnersView({ user, onAuth, onCreate }) {
  const [partners, setPartners] = useState([]);
  const [filter, setFilter] = useState("all");
  const [loading, setLoading] = useState(true);
  const [openPartner, setOpenPartner] = useState(null);

  useEffect(() => {
    setLoading(true);
    fetchPartners({ type: filter === "all" ? undefined : filter }).then(p => {
      setPartners(p || []);
      setLoading(false);
    }).catch(()=>setLoading(false));
  }, [filter]);

  const sorted = useMemo(() => {
    const order = { featured: 0, pro: 1, basic: 2, free: 3 };
    return [...partners].sort((a,b) => (order[a.tier]||9) - (order[b.tier]||9));
  }, [partners]);

  const featured = sorted.filter(p => p.tier === "featured").slice(0,3);
  const others = sorted.filter(p => p.tier !== "featured");

  return (
    <div style={{flex:1,overflowY:"auto",paddingBottom:90}}>
      {/* HERO */}
      <div style={{background:"linear-gradient(160deg,#1a0a36,#08070e)",padding:"22px 16px 18px",borderBottom:"1px solid var(--b)"}}>
        <div style={{fontSize:10,fontWeight:700,color:"#a78bfa",letterSpacing:3,textTransform:"uppercase",marginBottom:6}}>🌟 Partners</div>
        <h1 style={{fontSize:"clamp(20px,5.5vw,28px)",fontWeight:800,color:"var(--tx)",lineHeight:1.15,marginBottom:8}}>Hitta rätt <span className="gt">spökhjälp</span></h1>
        <p style={{fontSize:13,color:"var(--tx2)",lineHeight:1.6,marginBottom:12}}>
          Medium, spökvandringar, eventbolag, hemsökta boenden, spökmiddagar och spökjägare som tar uppdrag — allt på en plats. Klicka in på en partner för att se vad de erbjuder, priser och boka.
        </p>
        <div style={{display:"flex",gap:8,flexWrap:"wrap"}}>
          <Btn ch="✨ Bli partner från 29 kr/mån" v="p" sz="sm" onClick={()=>user?onCreate():onAuth("login")}/>
          <button onClick={()=>document.getElementById("partner-list")?.scrollIntoView({behavior:"smooth"})} style={{background:"var(--bg3)",border:"1px solid var(--b)",borderRadius:9,padding:"7px 12px",fontSize:11,fontWeight:600,color:"var(--tx2)",cursor:"pointer"}}>Bläddra partners ↓</button>
        </div>
      </div>

      {/* KATEGORI-CARDS (stora, visuella) */}
      <div style={{padding:"16px 14px 6px"}}>
        <div style={{fontSize:11,fontWeight:700,color:"var(--tx3)",letterSpacing:1.5,textTransform:"uppercase",marginBottom:10}}>Bläddra efter typ</div>
        <div style={{display:"grid",gridTemplateColumns:"repeat(auto-fill,minmax(140px,1fr))",gap:9}}>
          {PARTNER_TYPES.filter(t=>t.code!=="all").map(pt => {
            const count = partners.filter(p => p.type === pt.code).length;
            const active = filter === pt.code;
            return (
              <button key={pt.code} onClick={()=>setFilter(active?"all":pt.code)} style={{background:active?"rgba(124,58,237,0.15)":"var(--card)",border:`1px solid ${active?"#7c3aed":"var(--b)"}`,borderRadius:13,padding:"13px 11px",cursor:"pointer",textAlign:"left",transition:"all 0.18s",position:"relative",overflow:"hidden"}}>
                <div style={{fontSize:24,marginBottom:5}}>{pt.icon}</div>
                <div style={{fontSize:12,fontWeight:700,color:active?"#a78bfa":"var(--tx)",marginBottom:2}}>{pt.label}</div>
                <div style={{fontSize:9,color:"var(--tx3)",lineHeight:1.45}}>{pt.short}</div>
                {count>0 && <div style={{position:"absolute",top:8,right:9,fontSize:8,fontWeight:700,color:"#a78bfa",background:"rgba(124,58,237,0.15)",padding:"2px 6px",borderRadius:6}}>{count}</div>}
              </button>
            );
          })}
        </div>
      </div>

      {/* AKTIVT FILTER-RAD */}
      {filter !== "all" && (
        <div style={{padding:"6px 14px 0",display:"flex",gap:7,alignItems:"center"}}>
          <span style={{fontSize:10,color:"var(--tx3)"}}>Visar:</span>
          <span style={{background:"rgba(124,58,237,0.15)",border:"1px solid #7c3aed",borderRadius:14,padding:"4px 10px",fontSize:11,fontWeight:600,color:"#a78bfa",display:"flex",gap:5,alignItems:"center"}}>
            {PARTNER_TYPES.find(t=>t.code===filter)?.icon} {PARTNER_TYPES.find(t=>t.code===filter)?.label}
            <button onClick={()=>setFilter("all")} style={{background:"none",border:"none",color:"#a78bfa",cursor:"pointer",fontSize:13,padding:0,marginLeft:3}}>✕</button>
          </span>
        </div>
      )}

      {/* FEATURED-RAD */}
      {featured.length > 0 && filter === "all" && (
        <div style={{padding:"14px 14px 0"}}>
          <div style={{fontSize:11,fontWeight:700,color:"#fbbf24",letterSpacing:1.5,textTransform:"uppercase",marginBottom:9}}>★ Featured partners</div>
          <div style={{display:"flex",gap:10,overflowX:"auto",paddingBottom:6,WebkitOverflowScrolling:"touch"}}>
            {featured.map(p => (
              <div key={p.id} style={{flex:"0 0 240px",minWidth:240}} onClick={()=>setOpenPartner(p)}>
                <PartnerCard p={p} onClick={()=>setOpenPartner(p)}/>
              </div>
            ))}
          </div>
        </div>
      )}

      {/* LISTA */}
      <div id="partner-list" style={{padding:"14px 14px 0"}}>
        <div style={{fontSize:11,fontWeight:700,color:"var(--tx3)",letterSpacing:1.5,textTransform:"uppercase",marginBottom:9,display:"flex",justifyContent:"space-between",alignItems:"center"}}>
          <span>Alla partners {filter!=="all"?`· ${PARTNER_TYPES.find(t=>t.code===filter)?.label}`:""}</span>
          {!loading && <span style={{fontSize:10,color:"var(--tx4)",letterSpacing:0,textTransform:"none"}}>{others.length} st</span>}
        </div>

        {loading ? (
          <div style={{textAlign:"center",padding:40,color:"var(--tx3)"}}>Laddar partners…</div>
        ) : others.length === 0 ? (
          <div style={{textAlign:"center",padding:"30px 16px",background:"var(--card)",border:"1px dashed var(--b2)",borderRadius:14}}>
            <div style={{fontSize:36,marginBottom:8}}>🌟</div>
            <div style={{fontSize:13,fontWeight:700,color:"var(--tx)",marginBottom:5}}>Inga partners än i den här kategorin</div>
            <div style={{fontSize:11,color:"var(--tx3)",marginBottom:14,lineHeight:1.55}}>
              Bli den första i kategorin {PARTNER_TYPES.find(t=>t.code===filter)?.label?.toLowerCase() || "din"} — listing från 29 kr/mån.
            </div>
            <Btn ch="✨ Bli partner →" v="p" onClick={()=>user?onCreate():onAuth("login")}/>
          </div>
        ) : (
          <div style={{display:"grid",gap:10}}>
            {others.map(p => <PartnerCard key={p.id} p={p} onClick={()=>setOpenPartner(p)}/>)}
          </div>
        )}
      </div>

      {/* CTA — bli partner (lång) */}
      <div style={{padding:"22px 14px 0"}}>
        <div style={{background:"linear-gradient(135deg,#1a0a36,#0d0b1a)",border:"1px solid var(--b2)",borderRadius:16,padding:18}}>
          <div style={{fontSize:11,fontWeight:700,color:"#a78bfa",letterSpacing:2,textTransform:"uppercase",marginBottom:6}}>För dig som driver verksamhet</div>
          <div style={{fontSize:17,fontWeight:800,color:"var(--tx)",marginBottom:6,lineHeight:1.25}}>Synas där spökintresserade letar</div>
          <div style={{fontSize:12,color:"var(--tx2)",lineHeight:1.65,marginBottom:12}}>
            Spökkartan har {`${(308).toLocaleString("sv-SE")}+`} platser och tusentals besökare i månaden. Lägg upp paket, priser och låt kunder skicka frågor direkt till dig — vi tar inget bokningsavtryck.
          </div>
          <div style={{display:"grid",gridTemplateColumns:"repeat(auto-fit,minmax(140px,1fr))",gap:7,marginBottom:12}}>
            {Object.entries(TIER_CONFIG).map(([k,t]) => (
              <div key={k} style={{background:"var(--bg3)",border:`1px solid ${t.color}33`,borderTop:`2px solid ${t.color}`,borderRadius:9,padding:"9px 10px"}}>
                <div style={{fontSize:11,fontWeight:700,color:t.color,marginBottom:1}}>{t.label}</div>
                <div style={{fontSize:14,fontWeight:800,color:"var(--tx)"}}>{t.price} kr<span style={{fontSize:9,fontWeight:500,color:"var(--tx3)"}}> /mån</span></div>
              </div>
            ))}
          </div>
          <Btn ch="✨ Bli partner — från 29 kr/mån" v="p" full onClick={()=>user?onCreate():onAuth("login")}/>
        </div>
      </div>

      {/* DETALJVY */}
      {openPartner && <PartnerDetailModal partner={openPartner} user={user} onClose={()=>setOpenPartner(null)}/>}
    </div>
  );
}

// ── PARTNER-KORT ──────────────────────────────────────────────
function PartnerCard({ p, onClick }) {
  const cfg = TIER_CONFIG[p.tier] || TIER_CONFIG.free;
  const typeMeta = PARTNER_TYPES.find(t => t.code === p.type) || PARTNER_TYPES[0];
  const featured = p.tier === "featured";
  return (
    <div onClick={onClick} style={{background:"var(--card)",border:`1px solid ${featured?"#fbbf24":"var(--b)"}`,borderRadius:14,padding:14,position:"relative",boxShadow:featured?"0 4px 20px rgba(251,191,36,0.18)":"none",cursor:"pointer",transition:"transform 0.15s, border-color 0.15s"}}
         onMouseEnter={e=>{e.currentTarget.style.transform="translateY(-1px)";e.currentTarget.style.borderColor=featured?"#fbbf24":"var(--b2)";}}
         onMouseLeave={e=>{e.currentTarget.style.transform="none";e.currentTarget.style.borderColor=featured?"#fbbf24":"var(--b)";}}>
      {featured && (
        <div style={{position:"absolute",top:-9,left:14,background:"linear-gradient(90deg,#fbbf24,#f59e0b)",fontSize:9,fontWeight:800,color:"#1a0a36",padding:"3px 9px",borderRadius:8,letterSpacing:0.5}}>★ FEATURED</div>
      )}
      <div style={{display:"flex",gap:12,alignItems:"flex-start"}}>
        {p.avatar ? (
          <img src={p.avatar} alt={p.name} style={{width:54,height:54,borderRadius:12,objectFit:"cover",flexShrink:0}}/>
        ) : (
          <div style={{width:54,height:54,borderRadius:12,background:"var(--bg3)",display:"flex",alignItems:"center",justifyContent:"center",fontSize:24,flexShrink:0}}>{typeMeta.icon}</div>
        )}
        <div style={{flex:1,minWidth:0}}>
          <div style={{display:"flex",alignItems:"center",gap:6,marginBottom:3}}>
            <div style={{fontSize:14,fontWeight:700,color:"var(--tx)",overflow:"hidden",textOverflow:"ellipsis",whiteSpace:"nowrap"}}>{p.name}</div>
            {p.verified && <span title="Verifierad" style={{color:"#34d399",fontSize:13}}>✓</span>}
            {p.tier!=="free" && p.tier!=="featured" && (
              <span style={{fontSize:8,fontWeight:700,color:cfg.color,background:`${cfg.color}22`,border:`1px solid ${cfg.color}55`,padding:"1px 5px",borderRadius:4,textTransform:"uppercase"}}>{cfg.label}</span>
            )}
          </div>
          <div style={{fontSize:11,color:"var(--tx3)",marginBottom:6,display:"flex",gap:6,alignItems:"center",flexWrap:"wrap"}}>
            <span>{typeMeta.icon} {typeMeta.label}</span>
            {p.regions_covered?.length > 0 && <span>· {p.regions_covered.slice(0,2).join(", ")}</span>}
            {p.rating && <span>· ⭐ {p.rating} ({p.review_count})</span>}
            {p.price_from && <span>· fr. {p.price_from} kr</span>}
          </div>
          {p.tagline && <div style={{fontSize:12,color:"var(--tx2)",lineHeight:1.55,marginBottom:8}}>{p.tagline}</div>}
          <div style={{display:"flex",gap:6,alignItems:"center",justifyContent:"space-between",flexWrap:"wrap"}}>
            <div style={{display:"flex",gap:5,flexWrap:"wrap"}}>
              {p.instagram && <span style={{fontSize:10,color:"var(--tx3)"}}>📷</span>}
              {p.youtube && <span style={{fontSize:10,color:"var(--tx3)"}}>▶</span>}
              {p.website && <span style={{fontSize:10,color:"var(--tx3)"}}>🔗</span>}
              {p.facebook && <span style={{fontSize:10,color:"var(--tx3)"}}>👥</span>}
            </div>
            <span style={{fontSize:11,fontWeight:700,color:"#a78bfa"}}>Se mer →</span>
          </div>
        </div>
      </div>
    </div>
  );
}

// ── PARTNER-DETALJVY (modal) ─────────────────────────────────
function PartnerDetailModal({ partner, user, onClose }) {
  const [packages, setPackages] = useState([]);
  const [loading, setLoading] = useState(true);
  const [showQuestion, setShowQuestion] = useState(false);
  const [selectedPkg, setSelectedPkg] = useState(null);
  const typeMeta = PARTNER_TYPES.find(t => t.code === partner.type) || PARTNER_TYPES[0];

  useEffect(() => {
    fetchPartnerPackages(partner.id).then(pkgs => {
      setPackages(pkgs || []);
      setLoading(false);
    }).catch(()=>setLoading(false));
  }, [partner.id]);

  function handleAskQuestion(pkg) {
    setSelectedPkg(pkg || null);
    setShowQuestion(true);
  }

  return (
    <div className="modal-overlay" onClick={e=>{if(e.target===e.currentTarget)onClose();}}>
      <div className="modal-sheet au" style={{maxHeight:"94vh",overflowY:"auto",maxWidth:560}}>
        <div className="modal-handle"/>
        <button onClick={onClose} style={{position:"absolute",top:14,right:14,background:"rgba(7,6,15,0.7)",border:"1px solid var(--b)",color:"var(--tx)",cursor:"pointer",fontSize:16,width:32,height:32,borderRadius:"50%",zIndex:5}}>✕</button>

        {/* HERO BANNER */}
        {partner.hero_image && (
          <div style={{margin:"-22px -22px 14px",height:140,backgroundImage:`url(${partner.hero_image})`,backgroundSize:"cover",backgroundPosition:"center",borderRadius:"16px 16px 0 0",position:"relative"}}>
            <div style={{position:"absolute",inset:0,background:"linear-gradient(180deg,transparent 40%,rgba(7,6,15,0.85))"}}/>
          </div>
        )}

        {/* HEADER */}
        <div style={{display:"flex",gap:12,alignItems:"flex-start",marginBottom:12}}>
          {partner.avatar ? (
            <img src={partner.avatar} alt={partner.name} style={{width:64,height:64,borderRadius:14,objectFit:"cover",flexShrink:0,border:"2px solid var(--b2)"}}/>
          ) : (
            <div style={{width:64,height:64,borderRadius:14,background:"var(--bg3)",display:"flex",alignItems:"center",justifyContent:"center",fontSize:32,flexShrink:0}}>{typeMeta.icon}</div>
          )}
          <div style={{flex:1}}>
            <div style={{display:"flex",alignItems:"center",gap:6,marginBottom:3,flexWrap:"wrap"}}>
              <h2 style={{fontSize:18,fontWeight:800,color:"var(--tx)"}}>{partner.name}</h2>
              {partner.verified && <span style={{fontSize:11,fontWeight:700,color:"#34d399",background:"rgba(52,211,153,0.12)",border:"1px solid rgba(52,211,153,0.3)",borderRadius:5,padding:"1px 6px"}}>✓ Verified</span>}
              {partner.tier === "featured" && <span style={{fontSize:9,fontWeight:800,color:"#1a0a36",background:"linear-gradient(90deg,#fbbf24,#f59e0b)",borderRadius:5,padding:"2px 7px"}}>★ FEATURED</span>}
            </div>
            <div style={{fontSize:12,color:"#a78bfa",marginBottom:3}}>{typeMeta.icon} {typeMeta.label}</div>
            {partner.regions_covered?.length>0 && <div style={{fontSize:11,color:"var(--tx3)"}}>📍 {partner.regions_covered.join(", ")}</div>}
            {partner.rating && <div style={{fontSize:11,color:"#fbbf24",marginTop:3}}>⭐ {partner.rating} · {partner.review_count} omdömen</div>}
          </div>
        </div>

        {/* TAGLINE */}
        {partner.tagline && <div style={{fontSize:14,fontWeight:600,color:"var(--tx)",lineHeight:1.5,marginBottom:12,padding:"10px 12px",background:"rgba(124,58,237,0.08)",border:"1px solid rgba(124,58,237,0.2)",borderRadius:10}}>"{partner.tagline}"</div>}

        {/* BIO — om verksamheten */}
        {partner.bio && (
          <div style={{marginBottom:14}}>
            <div style={{fontSize:10,fontWeight:700,color:"var(--tx3)",letterSpacing:1.5,textTransform:"uppercase",marginBottom:6}}>Om verksamheten</div>
            <div style={{fontSize:13,color:"var(--tx2)",lineHeight:1.7,whiteSpace:"pre-wrap"}}>{partner.bio}</div>
          </div>
        )}

        {/* VAD FÅR KUNDEN UT */}
        {partner.what_customer_gets && (
          <div style={{marginBottom:14,background:"var(--bg3)",border:"1px solid var(--b)",borderRadius:11,padding:"12px 14px"}}>
            <div style={{fontSize:10,fontWeight:700,color:"#34d399",letterSpacing:1.5,textTransform:"uppercase",marginBottom:6}}>✦ Vad får kunden ut?</div>
            <div style={{fontSize:13,color:"var(--tx)",lineHeight:1.7,whiteSpace:"pre-wrap"}}>{partner.what_customer_gets}</div>
          </div>
        )}

        {/* GALLERI */}
        {partner.gallery?.length > 0 && (
          <div style={{marginBottom:14}}>
            <div style={{fontSize:10,fontWeight:700,color:"var(--tx3)",letterSpacing:1.5,textTransform:"uppercase",marginBottom:6}}>Galleri</div>
            <div style={{display:"flex",gap:6,overflowX:"auto",paddingBottom:4}}>
              {partner.gallery.map((img,i)=>(
                <div key={i} style={{flex:"0 0 110px",height:110,borderRadius:9,overflow:"hidden",background:"var(--bg3)"}}>
                  <img src={img} alt="" style={{width:"100%",height:"100%",objectFit:"cover"}} onError={e=>e.target.style.display="none"}/>
                </div>
              ))}
            </div>
          </div>
        )}

        {/* PAKET / PRISER */}
        <div style={{marginBottom:14}}>
          <div style={{fontSize:10,fontWeight:700,color:"var(--tx3)",letterSpacing:1.5,textTransform:"uppercase",marginBottom:8}}>Paket & priser</div>
          {loading ? (
            <div style={{fontSize:12,color:"var(--tx3)",padding:14,textAlign:"center"}}>Laddar paket…</div>
          ) : packages.length === 0 ? (
            <div style={{fontSize:12,color:"var(--tx3)",padding:"14px 12px",background:"var(--bg3)",border:"1px dashed var(--b2)",borderRadius:10,textAlign:"center"}}>
              {partner.price_from ? <>Från <strong style={{color:"var(--tx)"}}>{partner.price_from} kr</strong> — kontakta {partner.name.split(" ")[0]} för aktuella priser.</> : <>Kontakta {partner.name.split(" ")[0]} för pris och paket.</>}
            </div>
          ) : (
            <div style={{display:"grid",gap:9}}>
              {packages.map(pkg => (
                <div key={pkg.id} style={{background:"var(--card2)",border:`1px solid ${pkg.highlight?"#fbbf24":"var(--b)"}`,borderRadius:12,padding:"12px 14px",position:"relative"}}>
                  {pkg.highlight && <div style={{position:"absolute",top:-8,right:14,background:"linear-gradient(90deg,#fbbf24,#f59e0b)",fontSize:8,fontWeight:800,color:"#1a0a36",padding:"3px 8px",borderRadius:6,letterSpacing:0.5}}>★ MEST POPULÄR</div>}
                  <div style={{display:"flex",justifyContent:"space-between",alignItems:"flex-start",gap:10,marginBottom:5}}>
                    <div style={{flex:1,minWidth:0}}>
                      <div style={{fontSize:14,fontWeight:700,color:"var(--tx)"}}>{pkg.name}</div>
                      {pkg.duration_min && <div style={{fontSize:10,color:"var(--tx3)"}}>⏱ {pkg.duration_min} min{pkg.max_participants?` · max ${pkg.max_participants} pers.`:""}</div>}
                    </div>
                    <div style={{textAlign:"right",flexShrink:0}}>
                      <div style={{fontSize:18,fontWeight:800,color:"#d4af37"}}>{pkg.price.toLocaleString("sv-SE")} kr</div>
                      <div style={{fontSize:9,color:"var(--tx4)"}}>{pkg.price_unit==="per_person"?"/person":pkg.price_unit==="per_timme"?"/timme":pkg.price_unit==="per_natt"?"/natt":""}</div>
                    </div>
                  </div>
                  {pkg.description && <div style={{fontSize:12,color:"var(--tx2)",lineHeight:1.55,marginBottom:7}}>{pkg.description}</div>}
                  {pkg.includes?.length > 0 && (
                    <ul style={{listStyle:"none",padding:0,margin:"0 0 9px",display:"grid",gap:3}}>
                      {pkg.includes.map((inc,i)=>(
                        <li key={i} style={{fontSize:11,color:"var(--tx2)",display:"flex",gap:6,alignItems:"flex-start"}}><span style={{color:"#34d399",flexShrink:0}}>✓</span> {inc}</li>
                      ))}
                    </ul>
                  )}
                  <div style={{display:"flex",gap:6,flexWrap:"wrap"}}>
                    {pkg.booking_link ? (
                      <a href={pkg.booking_link} target="_blank" rel="noreferrer" style={{background:"linear-gradient(135deg,var(--acc),var(--acc3))",borderRadius:8,padding:"7px 13px",fontSize:11,fontWeight:700,color:"#fff",textDecoration:"none"}}>Boka nu →</a>
                    ) : null}
                    <Btn ch="💬 Fråga om paketet" v="ghost" sz="sm" onClick={()=>handleAskQuestion(pkg)}/>
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>

        {/* KONTAKT */}
        <div style={{marginBottom:14,padding:"12px 14px",background:"var(--bg3)",border:"1px solid var(--b)",borderRadius:11}}>
          <div style={{fontSize:10,fontWeight:700,color:"var(--tx3)",letterSpacing:1.5,textTransform:"uppercase",marginBottom:8}}>Kontakt & länkar</div>
          <div style={{display:"flex",gap:7,flexWrap:"wrap"}}>
            {partner.booking_url && <a href={partner.booking_url} target="_blank" rel="noreferrer" style={{background:"rgba(52,211,153,0.12)",border:"1px solid rgba(52,211,153,0.3)",borderRadius:8,padding:"6px 11px",fontSize:11,fontWeight:600,color:"#34d399",textDecoration:"none"}}>🎟️ Boka direkt</a>}
            {partner.website && <a href={partner.website} target="_blank" rel="noreferrer" style={{background:"var(--card)",border:"1px solid var(--b2)",borderRadius:8,padding:"6px 11px",fontSize:11,fontWeight:600,color:"var(--tx2)",textDecoration:"none"}}>🔗 Webb</a>}
            {partner.contact_email && <a href={`mailto:${partner.contact_email}`} style={{background:"var(--card)",border:"1px solid var(--b2)",borderRadius:8,padding:"6px 11px",fontSize:11,fontWeight:600,color:"var(--tx2)",textDecoration:"none"}}>✉️ E-post</a>}
            {partner.contact_phone && <a href={`tel:${partner.contact_phone}`} style={{background:"var(--card)",border:"1px solid var(--b2)",borderRadius:8,padding:"6px 11px",fontSize:11,fontWeight:600,color:"var(--tx2)",textDecoration:"none"}}>📞 Ring</a>}
            {partner.instagram && <a href={partner.instagram} target="_blank" rel="noreferrer" style={{background:"rgba(236,72,153,0.1)",border:"1px solid rgba(236,72,153,0.3)",borderRadius:8,padding:"6px 11px",fontSize:11,fontWeight:600,color:"#f472b6",textDecoration:"none"}}>📷 Instagram</a>}
            {partner.youtube && <a href={partner.youtube} target="_blank" rel="noreferrer" style={{background:"rgba(239,68,68,0.1)",border:"1px solid rgba(239,68,68,0.3)",borderRadius:8,padding:"6px 11px",fontSize:11,fontWeight:600,color:"#f87171",textDecoration:"none"}}>▶ YouTube</a>}
            {partner.facebook && <a href={partner.facebook} target="_blank" rel="noreferrer" style={{background:"rgba(96,165,250,0.1)",border:"1px solid rgba(96,165,250,0.3)",borderRadius:8,padding:"6px 11px",fontSize:11,fontWeight:600,color:"#60a5fa",textDecoration:"none"}}>👥 Facebook</a>}
            {partner.tiktok && <a href={partner.tiktok} target="_blank" rel="noreferrer" style={{background:"var(--card)",border:"1px solid var(--b2)",borderRadius:8,padding:"6px 11px",fontSize:11,fontWeight:600,color:"var(--tx2)",textDecoration:"none"}}>🎵 TikTok</a>}
          </div>
        </div>

        {/* FRÅGA-KNAPP */}
        <Btn ch="💬 Skicka en fråga till partnern" v="p" full onClick={()=>handleAskQuestion(null)}/>
        <div style={{fontSize:10,color:"var(--tx4)",textAlign:"center",marginTop:8,lineHeight:1.5}}>
          Frågan landar i Spökkartans adminpanel — Fredrik vidarebefordrar till partnern. Förvänta svar inom 1–2 dagar.
        </div>

        {showQuestion && <PartnerQuestionModal partner={partner} pkg={selectedPkg} user={user} onClose={()=>setShowQuestion(false)}/>}
      </div>
    </div>
  );
}

// ── FRÅGEFORMULÄR (modal) ─────────────────────────────────────
function PartnerQuestionModal({ partner, pkg, user, onClose }) {
  const [name, setName] = useState(user?.name || "");
  const [email, setEmail] = useState(user?.email || "");
  const [phone, setPhone] = useState("");
  const [subject, setSubject] = useState(pkg?`Fråga om ${pkg.name}`:"");
  const [message, setMessage] = useState("");
  const [loading, setLoading] = useState(false);
  const [done, setDone] = useState(false);
  const [err, setErr] = useState("");

  async function send() {
    if (!name.trim() || !email.trim() || !message.trim()) {
      setErr("Namn, e-post och meddelande krävs"); return;
    }
    setLoading(true); setErr("");
    try {
      await submitPartnerQuestion({
        partner_id: partner.id,
        asker_name: name.trim(),
        asker_email: email.trim(),
        asker_phone: phone.trim() || null,
        subject: subject.trim() || null,
        message: message.trim(),
        package_id: pkg?.id || null,
      });
      setDone(true);
    } catch(e) { setErr("Kunde inte skicka: " + e.message); }
    finally { setLoading(false); }
  }

  const inp = {width:"100%",background:"var(--bg3)",border:"1px solid var(--b)",borderRadius:9,padding:"10px 12px",fontSize:13,color:"var(--tx)",marginBottom:9};
  const lbl = {fontSize:11,fontWeight:600,color:"var(--tx3)",marginBottom:4,marginTop:4,display:"block"};

  if (done) return (
    <div className="modal-overlay" onClick={e=>{if(e.target===e.currentTarget)onClose();}}>
      <div className="modal-sheet au" style={{textAlign:"center",padding:"32px 22px"}}>
        <div style={{fontSize:48,marginBottom:12}}>✅</div>
        <h2 style={{fontSize:18,fontWeight:800,color:"var(--tx)",marginBottom:8}}>Tack — frågan är skickad!</h2>
        <p style={{fontSize:13,color:"var(--tx2)",lineHeight:1.65,marginBottom:18}}>
          Vi har skickat din fråga till {partner.name}. Den landar i Spökkartans adminpanel och vidarebefordras. Förvänta svar inom 1–2 dagar via {email}.
        </p>
        <Btn ch="Stäng" v="p" full onClick={onClose}/>
      </div>
    </div>
  );

  return (
    <div className="modal-overlay" onClick={e=>{if(e.target===e.currentTarget)onClose();}}>
      <div className="modal-sheet au" style={{maxHeight:"92vh",overflowY:"auto"}}>
        <div className="modal-handle"/>
        <button onClick={onClose} style={{position:"absolute",top:14,right:14,background:"none",border:"none",color:"var(--tx3)",cursor:"pointer",fontSize:22,padding:4}}>✕</button>
        <h2 style={{fontSize:18,fontWeight:800,color:"var(--tx)",marginBottom:6}}>💬 Fråga {partner.name}</h2>
        <p style={{fontSize:12,color:"var(--tx3)",marginBottom:14,lineHeight:1.55}}>
          Frågan landar i Spökkartans adminpanel och vidarebefordras till partnern. Vi sparar din e-post för svaret — inget annat.
        </p>
        {pkg && <div style={{background:"rgba(124,58,237,0.08)",border:"1px solid rgba(124,58,237,0.3)",borderRadius:9,padding:"8px 11px",marginBottom:12,fontSize:12}}>📦 Gäller paket: <strong style={{color:"#a78bfa"}}>{pkg.name}</strong> · {pkg.price.toLocaleString("sv-SE")} kr</div>}

        <label style={lbl}>Ditt namn *</label>
        <input style={inp} value={name} onChange={e=>setName(e.target.value)} placeholder="Anna Andersson"/>
        <div style={{display:"grid",gridTemplateColumns:"1fr 1fr",gap:9}}>
          <div><label style={lbl}>E-post *</label><input style={inp} type="email" value={email} onChange={e=>setEmail(e.target.value)} placeholder="anna@example.com"/></div>
          <div><label style={lbl}>Telefon (valfri)</label><input style={inp} value={phone} onChange={e=>setPhone(e.target.value)} placeholder="070-..."/></div>
        </div>
        <label style={lbl}>Ämne</label>
        <input style={inp} value={subject} onChange={e=>setSubject(e.target.value)} placeholder="t.ex. Tillgänglig 14 juni?"/>
        <label style={lbl}>Meddelande *</label>
        <textarea style={{...inp,minHeight:110,resize:"vertical"}} value={message} onChange={e=>setMessage(e.target.value)} placeholder={`Hej ${partner.name.split(" ")[0]}!\n\nJag undrar...`}/>

        {err && <div style={{background:"rgba(239,68,68,0.1)",border:"1px solid rgba(239,68,68,0.3)",borderRadius:8,padding:"8px 12px",fontSize:12,color:"#ef4444",marginBottom:10}}>{err}</div>}

        <Btn ch={loading?"Skickar…":"📨 Skicka frågan"} v="p" full onClick={send} disabled={loading}/>
      </div>
    </div>
  );
}

// ── BLI PARTNER (modal) ──────────────────────────────────────
function BecomePartnerModal({ onClose, onSuccess, user }) {
  const [type, setType] = useState("medium");
  const [name, setName] = useState(user?.name || "");
  const [tagline, setTagline] = useState("");
  const [bio, setBio] = useState("");
  const [whatGets, setWhatGets] = useState("");
  const [regions, setRegions] = useState("");
  const [website, setWebsite] = useState("");
  const [instagram, setInstagram] = useState("");
  const [youtube, setYoutube] = useState("");
  const [facebook, setFacebook] = useState("");
  const [contactEmail, setContactEmail] = useState(user?.email || "");
  const [contactPhone, setContactPhone] = useState("");
  const [bookingUrl, setBookingUrl] = useState("");
  const [priceFrom, setPriceFrom] = useState("");
  const [tier, setTier] = useState("basic");
  const [loading, setLoading] = useState(false);
  const [err, setErr] = useState("");
  const [step, setStep] = useState(1); // 1: typ+grund, 2: paket+priser, 3: klart

  async function submit() {
    if (!name.trim()) { setErr("Namn krävs"); return; }
    if (!type) { setErr("Välj typ"); return; }
    setLoading(true); setErr("");
    try {
      await createPartner({
        type, name: name.trim(),
        tagline: tagline.trim(), bio: bio.trim(),
        what_customer_gets: whatGets.trim(),
        regions_covered: regions.split(",").map(s=>s.trim()).filter(Boolean),
        website: website.trim(), instagram: instagram.trim(),
        youtube: youtube.trim(), facebook: facebook.trim(),
        contact_email: contactEmail.trim(), contact_phone: contactPhone.trim(),
        booking_url: bookingUrl.trim(),
        price_from: priceFrom ? parseInt(priceFrom,10) : null,
        tier, status: "pending",
      });
      setStep(3);
    } catch(e) {
      setErr("Kunde inte spara: " + e.message);
    } finally { setLoading(false); }
  }

  const inp = {width:"100%",background:"var(--bg3)",border:"1px solid var(--b)",borderRadius:9,padding:"10px 12px",fontSize:13,color:"var(--tx)",marginBottom:10};
  const lbl = {fontSize:11,fontWeight:600,color:"var(--tx3)",marginBottom:4,marginTop:4,display:"block"};

  if (step === 3) return (
    <div className="modal-overlay" onClick={e=>{if(e.target===e.currentTarget)onClose();}}>
      <div className="modal-sheet au" style={{textAlign:"center",padding:"34px 24px"}}>
        <div style={{fontSize:54,marginBottom:14}}>🎉</div>
        <h2 style={{fontSize:20,fontWeight:800,color:"var(--tx)",marginBottom:10}}>Tack — ansökan är inskickad!</h2>
        <p style={{fontSize:13,color:"var(--tx2)",lineHeight:1.65,marginBottom:8}}>
          Fredrik granskar din profil inom 24 timmar. Du får mejl till <strong>{contactEmail}</strong> när den går live.
        </p>
        <p style={{fontSize:12,color:"var(--tx3)",lineHeight:1.65,marginBottom:18}}>
          Betalningslänk för <strong style={{color:TIER_CONFIG[tier].color}}>{TIER_CONFIG[tier].label}</strong>-paketet ({TIER_CONFIG[tier].price} kr/mån) skickas i samma mejl.
        </p>
        <p style={{fontSize:11,color:"var(--tx4)",marginBottom:18}}>Tips: efter godkännande kan du logga in och lägga till paket, priser och bilder.</p>
        <Btn ch="Stäng" v="p" full onClick={()=>{onSuccess();onClose();}}/>
      </div>
    </div>
  );

  return (
    <div className="modal-overlay" onClick={e=>{if(e.target===e.currentTarget)onClose();}}>
      <div className="modal-sheet au" style={{maxHeight:"94vh",overflowY:"auto"}}>
        <div className="modal-handle"/>
        <button onClick={onClose} style={{position:"absolute",top:14,right:14,background:"none",border:"none",color:"var(--tx3)",cursor:"pointer",fontSize:22,padding:4}}>✕</button>
        <h2 style={{fontSize:20,fontWeight:800,color:"var(--tx)",marginBottom:6}}>Bli partner ✨</h2>
        <p style={{fontSize:12,color:"var(--tx3)",marginBottom:14,lineHeight:1.55}}>
          Lista din verksamhet på Spökkartan från 29 kr/mån. Steg {step}/2 — du kan alltid uppgradera senare.
        </p>

        {/* STEP-INDIKATOR */}
        <div style={{display:"flex",gap:6,marginBottom:16}}>
          {[1,2].map(s=>(
            <div key={s} style={{flex:1,height:4,borderRadius:2,background:s<=step?"#7c3aed":"var(--b)"}}/>
          ))}
        </div>

        {step === 1 && (
          <>
            <label style={lbl}>Typ av verksamhet *</label>
            <div style={{display:"grid",gridTemplateColumns:"repeat(2,1fr)",gap:6,marginBottom:14}}>
              {PARTNER_TYPES.filter(t=>t.code!=="all").map(pt => (
                <button key={pt.code} onClick={()=>setType(pt.code)} style={{background:type===pt.code?"rgba(124,58,237,0.18)":"var(--bg3)",border:`1px solid ${type===pt.code?"#7c3aed":"var(--b)"}`,borderRadius:9,padding:"10px",fontSize:12,fontWeight:600,color:type===pt.code?"#a78bfa":"var(--tx2)",cursor:"pointer",textAlign:"left"}}>
                  <div style={{fontSize:18,marginBottom:3}}>{pt.icon}</div>
                  <div>{pt.label}</div>
                  <div style={{fontSize:9,color:"var(--tx4)",fontWeight:500,marginTop:2}}>{pt.short}</div>
                </button>
              ))}
            </div>

            <label style={lbl}>Namn / Företagsnamn *</label>
            <input style={inp} value={name} onChange={e=>setName(e.target.value)} placeholder="t.ex. Stockholm Ghost Walks"/>

            <label style={lbl}>Slogan / Kort beskrivning (visas i kortet)</label>
            <input style={inp} value={tagline} onChange={e=>setTagline(e.target.value)} placeholder="t.ex. Sveriges mest spännande nattvandringar"/>

            <label style={lbl}>Beskriv din verksamhet närmare</label>
            <textarea style={{...inp,minHeight:80,resize:"vertical"}} value={bio} onChange={e=>setBio(e.target.value)} placeholder="Vem är du? Vad gör ni? Vad är er erfarenhet, ert område, er specialitet?"/>

            <label style={lbl}>Vad får kunden ut? (visas tydligt i din profil)</label>
            <textarea style={{...inp,minHeight:70,resize:"vertical"}} value={whatGets} onChange={e=>setWhatGets(e.target.value)} placeholder="Beskriv konkret upplevelsen — t.ex. '90 min guidning + EMF-utrustning + minnesbild + 1 glas glögg'"/>

            <label style={lbl}>Regioner / städer (kommaseparerat)</label>
            <input style={inp} value={regions} onChange={e=>setRegions(e.target.value)} placeholder="Stockholm, Uppsala, Östergötland"/>

            <label style={lbl}>Lägsta pris (frivilligt — visas som "fr. X kr")</label>
            <input style={inp} type="number" value={priceFrom} onChange={e=>setPriceFrom(e.target.value)} placeholder="t.ex. 299"/>

            <div style={{fontSize:10,fontWeight:700,color:"var(--tx3)",letterSpacing:1.5,textTransform:"uppercase",marginTop:6,marginBottom:6}}>Kontakt & länkar</div>
            <div style={{display:"grid",gridTemplateColumns:"1fr 1fr",gap:9}}>
              <div><label style={lbl}>Webb</label><input style={inp} value={website} onChange={e=>setWebsite(e.target.value)} placeholder="https://..."/></div>
              <div><label style={lbl}>Instagram</label><input style={inp} value={instagram} onChange={e=>setInstagram(e.target.value)} placeholder="@handle"/></div>
              <div><label style={lbl}>YouTube</label><input style={inp} value={youtube} onChange={e=>setYoutube(e.target.value)} placeholder="https://..."/></div>
              <div><label style={lbl}>Facebook</label><input style={inp} value={facebook} onChange={e=>setFacebook(e.target.value)} placeholder="https://..."/></div>
              <div><label style={lbl}>E-post *</label><input style={inp} type="email" value={contactEmail} onChange={e=>setContactEmail(e.target.value)} placeholder="info@..."/></div>
              <div><label style={lbl}>Telefon</label><input style={inp} value={contactPhone} onChange={e=>setContactPhone(e.target.value)} placeholder="070-..."/></div>
            </div>
            <label style={lbl}>Bokningslänk (om du har)</label>
            <input style={inp} value={bookingUrl} onChange={e=>setBookingUrl(e.target.value)} placeholder="https://bokning.../"/>

            <Btn ch="Nästa: välj paket →" v="p" full onClick={()=>{
              if(!name.trim()){setErr("Namn krävs");return;}
              if(!contactEmail.trim()){setErr("E-post krävs");return;}
              setErr(""); setStep(2);
            }}/>
            {err && <div style={{background:"rgba(239,68,68,0.1)",border:"1px solid rgba(239,68,68,0.3)",borderRadius:8,padding:"8px 12px",fontSize:12,color:"#ef4444",marginTop:10}}>{err}</div>}
          </>
        )}

        {step === 2 && (
          <>
            <div style={{fontSize:13,fontWeight:700,color:"var(--tx)",marginBottom:8}}>Välj paket</div>
            <p style={{fontSize:11,color:"var(--tx3)",lineHeight:1.55,marginBottom:14}}>
              Du kan börja gratis. Uppgradering öppnar fler paket-platser, foton, statistik och bättre placering.
            </p>
            <div style={{display:"grid",gap:10,marginBottom:16}}>
              {Object.entries(TIER_CONFIG).map(([code,t]) => {
                const sel = tier === code;
                return (
                  <button key={code} onClick={()=>setTier(code)} style={{background:sel?`${t.color}1a`:"var(--bg3)",border:`2px solid ${sel?t.color:"var(--b)"}`,borderRadius:12,padding:"14px 14px",cursor:"pointer",textAlign:"left",position:"relative"}}>
                    <div style={{display:"flex",justifyContent:"space-between",alignItems:"flex-start",marginBottom:5,gap:8}}>
                      <div>
                        <div style={{fontSize:14,fontWeight:800,color:sel?t.color:"var(--tx)"}}>{t.label}</div>
                        <div style={{fontSize:11,color:"var(--tx3)",marginTop:1}}>{t.pitch}</div>
                      </div>
                      <div style={{textAlign:"right",flexShrink:0}}>
                        <div style={{fontSize:18,fontWeight:800,color:sel?t.color:"var(--tx)"}}>{t.price} kr</div>
                        <div style={{fontSize:9,color:"var(--tx4)"}}>/månad</div>
                      </div>
                    </div>
                    <ul style={{listStyle:"none",padding:0,margin:"4px 0 0",display:"grid",gap:3}}>
                      {t.perks.map((perk,i)=>(
                        <li key={i} style={{fontSize:11,color:"var(--tx2)",display:"flex",gap:6}}><span style={{color:t.color}}>✓</span> {perk}</li>
                      ))}
                    </ul>
                    {sel && <span style={{position:"absolute",top:12,right:12,color:t.color,fontSize:18,fontWeight:800}}>✓</span>}
                  </button>
                );
              })}
            </div>

            <div style={{fontSize:11,color:"var(--tx3)",marginBottom:10,padding:"9px 11px",background:"rgba(96,165,250,0.07)",border:"1px solid rgba(96,165,250,0.2)",borderRadius:9,lineHeight:1.55}}>
              ℹ️ Profilen skapas som <strong>väntar på godkännande</strong>. När Fredrik godkänt får du betalningslänk via mejl. Ingen betalning innan profilen är live.
            </div>

            {err && <div style={{background:"rgba(239,68,68,0.1)",border:"1px solid rgba(239,68,68,0.3)",borderRadius:8,padding:"8px 12px",fontSize:12,color:"#ef4444",marginBottom:10}}>{err}</div>}

            <div style={{display:"flex",gap:8}}>
              <Btn ch="← Tillbaka" v="ghost" onClick={()=>setStep(1)}/>
              <div style={{flex:1}}><Btn ch={loading?"Skickar…":"Skicka in ansökan →"} v="p" full onClick={submit} disabled={loading}/></div>
            </div>
          </>
        )}
      </div>
    </div>
  );
}


// ── LANGUAGE PICKER ──────────────────────────────────────────
function LanguagePicker({ lang, setLang, langs, t }) {
  const [open, setOpen] = useState(false);
  const current = langs.find(l => l.code === lang) || langs[0];
  return (
    <div style={{position:"relative"}}>
      <button onClick={()=>setOpen(o=>!o)} style={{background:"var(--bg3)",border:"1px solid var(--b)",borderRadius:8,padding:"6px 10px",fontSize:13,cursor:"pointer",color:"var(--tx2)",display:"flex",alignItems:"center",gap:6}}>
        <span style={{fontSize:15}}>{current.flag}</span>
        <span style={{fontSize:11,fontWeight:600,textTransform:"uppercase"}}>{current.code}</span>
        <span style={{fontSize:8,opacity:0.5}}>▼</span>
      </button>
      {open && (
        <>
          <div onClick={()=>setOpen(false)} style={{position:"fixed",inset:0,zIndex:990}}/>
          <div style={{position:"absolute",top:"calc(100% + 4px)",right:0,background:"var(--bg2)",border:"1px solid var(--b)",borderRadius:10,padding:6,zIndex:991,minWidth:160,boxShadow:"0 8px 24px rgba(0,0,0,0.4)"}}>
            <div style={{fontSize:9,fontWeight:700,color:"var(--tx4)",letterSpacing:1,textTransform:"uppercase",padding:"6px 10px 4px"}}>{t("select_language")}</div>
            {langs.map(l => (
              <button
                key={l.code}
                onClick={()=>{setLang(l.code); setOpen(false);}}
                style={{display:"flex",alignItems:"center",gap:10,width:"100%",background:l.code===lang?"rgba(124,58,237,0.15)":"none",border:"none",borderRadius:6,padding:"8px 10px",fontSize:13,cursor:"pointer",color:"var(--tx)",textAlign:"left"}}
              >
                <span style={{fontSize:18}}>{l.flag}</span>
                <span>{l.name}</span>
                {l.code===lang && <span style={{marginLeft:"auto",color:"#a78bfa"}}>✓</span>}
              </button>
            ))}
          </div>
        </>
      )}
    </div>
  );
}

// ── STORIES-VY (med tema-filter + bokningsbart-toggle) ───────
function StoriesView({ places, isPro, onRead }) {
  const [typeFilter, setTypeFilter] = useState("all");
  const [bookableOnly, setBookableOnly] = useState(false);
  const [search, setSearch] = useState("");

  // Räkna platser per typ för pills
  const typeCounts = useMemo(() => {
    const counts = {};
    places.forEach(p => { if (p.type) counts[p.type] = (counts[p.type] || 0) + 1; });
    return counts;
  }, [places]);

  const allTypes = useMemo(() => Object.keys(typeCounts).sort((a,b)=>typeCounts[b]-typeCounts[a]), [typeCounts]);

  const filtered = useMemo(() => {
    return places.filter(p => {
      if (typeFilter !== "all" && p.type !== typeFilter) return false;
      if (bookableOnly && !(p.bookable && p.booking_url)) return false;
      if (search) {
        const q = search.toLowerCase();
        if (!p.name?.toLowerCase().includes(q) &&
            !p.country?.toLowerCase().includes(q) &&
            !p.region?.toLowerCase().includes(q) &&
            !p.teaser?.toLowerCase().includes(q)) return false;
      }
      return true;
    });
  }, [places, typeFilter, bookableOnly, search]);

  const bookableCount = places.filter(p => p.bookable && p.booking_url).length;

  return (
    <div style={{flex:1,overflowY:"auto",display:"flex",flexDirection:"column"}}>
      {/* FILTER-HUVUD */}
      <div style={{padding:"12px 14px 8px",borderBottom:"1px solid var(--b)",background:"var(--bg2)",position:"sticky",top:0,zIndex:5}}>
        {/* Sök + Bokningsbart-toggle */}
        <div style={{display:"flex",gap:8,marginBottom:9,alignItems:"center"}}>
          <div style={{flex:1,position:"relative"}}>
            <input className="inp inp-sm" placeholder="Sök plats, land, region…" value={search} onChange={e=>setSearch(e.target.value)} style={{paddingLeft:28}}/>
            <span style={{position:"absolute",left:9,top:"50%",transform:"translateY(-50%)",fontSize:11,color:"var(--tx4)",pointerEvents:"none"}}>🔍</span>
          </div>
          <button onClick={()=>setBookableOnly(v=>!v)} title="Visa bara platser där du kan boka boende via oss" style={{flexShrink:0,background:bookableOnly?"linear-gradient(135deg,#34d399,#059669)":"var(--bg3)",border:`1px solid ${bookableOnly?"#34d399":"var(--b)"}`,borderRadius:9,padding:"7px 11px",fontSize:11,fontWeight:700,color:bookableOnly?"#fff":"var(--tx2)",cursor:"pointer",display:"flex",gap:5,alignItems:"center",whiteSpace:"nowrap"}}>
            🏨 {bookableOnly?"Bokningsbart ✓":`Bokningsbart (${bookableCount})`}
          </button>
        </div>

        {/* Tema-pills (typ-filter) */}
        <div style={{display:"flex",gap:6,overflowX:"auto",WebkitOverflowScrolling:"touch",paddingBottom:4}}>
          <button onClick={()=>setTypeFilter("all")} className={"pill"+(typeFilter==="all"?" on":"")} style={{flexShrink:0}}>🌐 Alla ({places.length})</button>
          {allTypes.map(t => (
            <button key={t} onClick={()=>setTypeFilter(typeFilter===t?"all":t)} className={"pill"+(typeFilter===t?" on":"")} style={{flexShrink:0}}>
              {TYPE_ICON[t]||"📍"} {t} ({typeCounts[t]})
            </button>
          ))}
        </div>
      </div>

      {/* RESULTAT-COUNT */}
      <div style={{padding:"10px 16px 0",fontSize:10,color:"var(--tx3)",display:"flex",justifyContent:"space-between",alignItems:"center"}}>
        <span>{filtered.length} {filtered.length===1?"plats":"platser"}{(typeFilter!=="all"||bookableOnly||search)?" · filter aktivt":""}</span>
        {(typeFilter!=="all"||bookableOnly||search) && (
          <button onClick={()=>{setTypeFilter("all");setBookableOnly(false);setSearch("");}} style={{background:"none",border:"none",color:"#a78bfa",fontSize:10,fontWeight:600,cursor:"pointer"}}>✕ Rensa filter</button>
        )}
      </div>

      {/* GRID */}
      {filtered.length === 0 ? (
        <div style={{textAlign:"center",padding:"60px 20px",color:"var(--tx4)"}}>
          <div style={{fontSize:48,marginBottom:10}}>👻</div>
          <div style={{fontSize:13,fontWeight:600,color:"var(--tx2)",marginBottom:6}}>Inga platser matchade filtret</div>
          <div style={{fontSize:11}}>Prova att ta bort filter eller ändra sökord</div>
        </div>
      ) : (
        <div className="stories-grid" style={{paddingBottom:80}}>
          {filtered.map(p => <PlaceCard key={p.id} p={p} isPro={isPro} onClick={()=>onRead(p)}/>)}
        </div>
      )}
    </div>
  );
}

// ── PLATSKORT (delad mellan stories-vy m.fl.) ────────────────
function PlaceCard({ p, isPro, onClick }) {
  const locked = !p.free && !isPro;
  const themeIcon = TYPE_ICON[p.type] || "📍";
  return (
    <div className="place-card" onClick={onClick}>
      <div className="place-img">
        {p.img && <img src={p.img} alt={p.name} onError={e=>e.target.style.display="none"}/>}
        {!p.img && <span style={{fontSize:32,opacity:0.18}}>{themeIcon}</span>}
        <div className="place-img-fade"/>

        {/* Tema-pill (typ) — top-left */}
        <div style={{position:"absolute",top:7,left:7,background:"rgba(7,6,15,0.85)",backdropFilter:"blur(6px)",WebkitBackdropFilter:"blur(6px)",border:"1px solid rgba(167,139,250,0.4)",borderRadius:7,padding:"3px 8px",fontSize:9,fontWeight:700,color:"#f0ecff",display:"flex",gap:4,alignItems:"center",letterSpacing:0.2}}>
          <span style={{fontSize:11}}>{themeIcon}</span>{p.type || "Plats"}
        </div>

        {/* Bokningsbart-badge — top-right */}
        {p.bookable && p.booking_url && (
          <div style={{position:"absolute",top:7,right:7,background:"linear-gradient(135deg,#34d399,#059669)",borderRadius:7,padding:"3px 7px",fontSize:9,fontWeight:800,color:"#fff",letterSpacing:0.3,boxShadow:"0 2px 6px rgba(52,211,153,0.4)"}} title="Du kan boka boende här">🏨 BO</div>
        )}

        {/* PRO-badge — bottom-right (diskret) */}
        {!p.free && (
          <div style={{position:"absolute",bottom:7,right:7,background:"rgba(212,175,55,0.18)",backdropFilter:"blur(6px)",WebkitBackdropFilter:"blur(6px)",border:"1px solid rgba(212,175,55,0.45)",borderRadius:6,padding:"2px 6px",fontSize:8,fontWeight:800,color:"#d4af37",letterSpacing:0.5}}>PRO</div>
        )}

        {/* Scary-dots — bottom-left */}
        <div style={{position:"absolute",bottom:7,left:7}}><Scary n={p.scary||3} sz={4}/></div>
      </div>

      <div style={{padding:"10px 11px 12px"}}>
        <div style={{fontSize:9,color:"var(--tx4)",marginBottom:3,display:"flex",gap:4,alignItems:"center"}}>
          <span>{FLAG[p.country]||"🌍"}</span>
          <span>{p.country}{p.region?` · ${p.region}`:""}</span>
        </div>
        <div style={{fontSize:12,fontWeight:700,color:"var(--tx)",lineHeight:1.3,marginBottom:4}}>{p.name}</div>
        {p.teaser && <div style={{fontSize:10,color:"var(--tx3)",lineHeight:1.55,overflow:"hidden",display:"-webkit-box",WebkitLineClamp:2,WebkitBoxOrient:"vertical"}}>{p.teaser}</div>}
      </div>
    </div>
  );
}

// ── OM OSS ────────────────────────────────────────────────────
function AboutPage({ setView }) {
  const [reportOpen, setReportOpen] = useState(false);
  return (
    <div style={{flex:1,overflowY:"auto",paddingBottom:90}}>
      {/* HERO */}
      <div style={{background:"linear-gradient(160deg,#1a0a36,#08070e)",padding:"28px 18px 22px",borderBottom:"1px solid var(--b)",position:"relative",overflow:"hidden"}}>
        <div style={{position:"absolute",top:-40,right:-40,fontSize:180,opacity:0.05}}>👻</div>
        <div style={{fontSize:10,fontWeight:700,color:"#a78bfa",letterSpacing:3,textTransform:"uppercase",marginBottom:6}}>💜 Om Spökkartan</div>
        <h1 style={{fontSize:"clamp(22px,6vw,32px)",fontWeight:800,color:"var(--tx)",lineHeight:1.15,marginBottom:10,position:"relative"}}>
          Vi är nördiga <span className="gt">storytellers</span> som älskar spökhistorier
        </h1>
        <p style={{fontSize:14,color:"var(--tx2)",lineHeight:1.7,position:"relative"}}>
          Spökkartan finns för att berättelser från förr — och nu — inte ska glömmas bort.
          Vi vill föra traditionen vidare och göra det enkelt att upptäcka spännande platser på nära håll.
        </p>
      </div>

      {/* MISSION */}
      <div style={{padding:"22px 16px 0"}}>
        <div style={{fontSize:11,fontWeight:700,color:"#a78bfa",letterSpacing:2,textTransform:"uppercase",marginBottom:10}}>Vår mission</div>
        <div style={{display:"grid",gap:11}}>
          <div style={{background:"var(--card)",border:"1px solid var(--b)",borderRadius:13,padding:"15px 16px",borderLeft:"3px solid #a78bfa"}}>
            <div style={{fontSize:22,marginBottom:6}}>📖</div>
            <div style={{fontSize:14,fontWeight:700,color:"var(--tx)",marginBottom:5}}>Bevara berättelserna</div>
            <div style={{fontSize:13,color:"var(--tx2)",lineHeight:1.65}}>
              Spökhistorier och historiska platser är en del av vårt kulturarv. Vi samlar in, dokumenterar och delar berättelser från förr och nu — så att traditionen lever vidare.
            </div>
          </div>
          <div style={{background:"var(--card)",border:"1px solid var(--b)",borderRadius:13,padding:"15px 16px",borderLeft:"3px solid #34d399"}}>
            <div style={{fontSize:22,marginBottom:6}}>🗺️</div>
            <div style={{fontSize:14,fontWeight:700,color:"var(--tx)",marginBottom:5}}>Enkelt att upptäcka</div>
            <div style={{fontSize:13,color:"var(--tx2)",lineHeight:1.65}}>
              Vi vill att det ska vara enkelt att läsa och utforska spännande platser — också nära dig. Karta, sökning och stories på ett ställe.
            </div>
          </div>
          <div style={{background:"var(--card)",border:"1px solid var(--b)",borderRadius:13,padding:"15px 16px",borderLeft:"3px solid #fbbf24"}}>
            <div style={{fontSize:22,marginBottom:6}}>✨</div>
            <div style={{fontSize:14,fontWeight:700,color:"var(--tx)",marginBottom:5}}>Föra traditionen vidare</div>
            <div style={{fontSize:13,color:"var(--tx2)",lineHeight:1.65}}>
              Genom partners, spökjägare, e-böcker och evenemang vill vi bygga en levande gemenskap för alla som älskar det mystiska och historiska.
            </div>
          </div>
        </div>
      </div>

      {/* TRO & SANNING */}
      <div style={{padding:"22px 16px 0"}}>
        <div style={{fontSize:11,fontWeight:700,color:"#a78bfa",letterSpacing:2,textTransform:"uppercase",marginBottom:10}}>Tro & sanning</div>
        <div style={{background:"linear-gradient(135deg,rgba(124,58,237,0.1),rgba(13,11,27,0.6))",border:"1px solid rgba(124,58,237,0.25)",borderRadius:14,padding:"16px 18px"}}>
          <div style={{fontSize:30,marginBottom:8}}>🕯️</div>
          <p style={{fontSize:14,color:"var(--tx)",lineHeight:1.75,marginBottom:10}}>
            Eftersom <strong>tro är individuell</strong>, lägger vi ingen vikt vid vad du tror på.
          </p>
          <p style={{fontSize:13,color:"var(--tx2)",lineHeight:1.7}}>
            Vad som är helt sant, eller inte, om en plats eller historia är ofta svårt att veta. Vi för bara berättelserna vidare från de källor vi kan hitta eller komma i kontakt med — du får själv avgöra vad du tar med dig.
          </p>
        </div>
      </div>

      {/* PARTNERS & ANSVAR */}
      <div style={{padding:"22px 16px 0"}}>
        <div style={{fontSize:11,fontWeight:700,color:"#a78bfa",letterSpacing:2,textTransform:"uppercase",marginBottom:10}}>Partners & spökjägare</div>
        <div style={{background:"var(--card)",border:"1px solid var(--b)",borderRadius:14,padding:"16px 18px"}}>
          <p style={{fontSize:13,color:"var(--tx2)",lineHeight:1.75,marginBottom:12}}>
            Vi tar inget ansvar för våra partners eller spökjägare utöver det rimliga — men vi har en enkel regel: <strong style={{color:"var(--tx)"}}>man ska vara schysst och leverera det man lovar</strong>.
          </p>
          <p style={{fontSize:13,color:"var(--tx2)",lineHeight:1.75,marginBottom:14}}>
            Sköter någon sig dåligt vill vi veta det. Hör av dig så tar vi tag i det.
          </p>
          <div style={{display:"flex",gap:8,flexWrap:"wrap"}}>
            <Btn ch="🚩 Anmäl en partner / spökjägare" v="p" sz="sm" onClick={()=>setReportOpen(true)}/>
            <Btn ch="✉️ Mejla oss" v="ghost" sz="sm" onClick={()=>{window.location.href="mailto:fredrick.lundberg@gmail.com?subject=Spökkartan%20-%20återkoppling";}}/>
          </div>
        </div>
      </div>

      {/* HUR VI JOBBAR */}
      <div style={{padding:"22px 16px 0"}}>
        <div style={{fontSize:11,fontWeight:700,color:"#a78bfa",letterSpacing:2,textTransform:"uppercase",marginBottom:10}}>Så jobbar vi</div>
        <div style={{display:"grid",gap:9}}>
          {[
            ["🔍","Vi letar","Vi gräver i arkiv, böcker, lokala källor och pratar med människor som vågat dokumentera."],
            ["📝","Vi sammanfattar","Berättelser sammanställs så att de blir lätta att läsa — utan att vi förvanskar källan."],
            ["🗺️","Vi kartlägger","Allt placeras på kartan så du enkelt hittar det som är nära dig — eller som du vill resa till."],
            ["💬","Vi lyssnar","Hittar du fel, har en egen historia, eller vill tipsa om en plats? Säg till. Det är så det blir bättre."],
          ].map(([icon,title,body])=>(
            <div key={title} style={{background:"var(--card2)",border:"1px solid var(--b)",borderRadius:11,padding:"12px 14px",display:"flex",gap:12,alignItems:"flex-start"}}>
              <div style={{fontSize:22,flexShrink:0}}>{icon}</div>
              <div>
                <div style={{fontSize:13,fontWeight:700,color:"var(--tx)",marginBottom:2}}>{title}</div>
                <div style={{fontSize:12,color:"var(--tx2)",lineHeight:1.6}}>{body}</div>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* SNABBLÄNKAR */}
      <div style={{padding:"22px 16px 0"}}>
        <div style={{fontSize:11,fontWeight:700,color:"#a78bfa",letterSpacing:2,textTransform:"uppercase",marginBottom:10}}>Utforska Spökkartan</div>
        <div style={{display:"grid",gridTemplateColumns:"1fr 1fr",gap:9}}>
          {[
            ["👻","Kartan","Hitta hemsökta platser","map"],
            ["📖","Stories","Läs berättelserna","stories"],
            ["🌟","Partners","Boka upplevelser","partners"],
            ["🔍","Spökjägare","Möt jägarna","hunters"],
          ].map(([icon,title,desc,target])=>(
            <button key={target} onClick={()=>setView(target)} style={{background:"var(--card)",border:"1px solid var(--b)",borderRadius:11,padding:"14px 13px",cursor:"pointer",textAlign:"left"}}>
              <div style={{fontSize:24,marginBottom:5}}>{icon}</div>
              <div style={{fontSize:13,fontWeight:700,color:"var(--tx)",marginBottom:2}}>{title}</div>
              <div style={{fontSize:10,color:"var(--tx3)",lineHeight:1.45}}>{desc}</div>
            </button>
          ))}
        </div>
      </div>

      {/* TIPSA OSS / CTA */}
      <div style={{padding:"22px 16px 0"}}>
        <div style={{background:"linear-gradient(135deg,#241245,#0d0b1a)",border:"1px solid var(--b2)",borderRadius:14,padding:"18px 18px",textAlign:"center"}}>
          <div style={{fontSize:32,marginBottom:8}}>💜</div>
          <div style={{fontSize:15,fontWeight:800,color:"var(--tx)",marginBottom:6}}>Tipsa oss om en plats eller historia</div>
          <p style={{fontSize:12,color:"var(--tx2)",lineHeight:1.65,marginBottom:14}}>
            Vet du en plats vi missat? Har du upplevt något själv? Hör av dig — det är så Spökkartan växer.
          </p>
          <Btn ch="✉️ Mejla oss en story →" v="p" onClick={()=>{window.location.href="mailto:fredrick.lundberg@gmail.com?subject=Spökkartan%20-%20platstips";}}/>
        </div>
      </div>

      {/* OM SKAPAREN */}
      <div style={{padding:"22px 16px 0"}}>
        <div style={{fontSize:11,fontWeight:700,color:"#a78bfa",letterSpacing:2,textTransform:"uppercase",marginBottom:10}}>Bakom Spökkartan</div>
        <div style={{background:"var(--card)",border:"1px solid var(--b)",borderRadius:13,padding:"15px 16px"}}>
          <div style={{fontSize:13,color:"var(--tx2)",lineHeight:1.7}}>
            Spökkartan är ett soloprojekt drivet med kärlek till spökhistorier, historia och berättartradition.
            Bygger på spökkartan.se och en växande databas av platser. Hör av dig om du vill samarbeta, tipsa eller bara prata spöken.
          </div>
        </div>
      </div>

      {/* FOOTER mini */}
      <div style={{padding:"24px 16px 4px",textAlign:"center"}}>
        <div style={{fontSize:11,color:"var(--tx4)",lineHeight:1.65}}>
          Spökkartan © {new Date().getFullYear()} — Berättelserna lever vidare. 👻
        </div>
      </div>

      {reportOpen && <ReportModal onClose={()=>setReportOpen(false)}/>}
    </div>
  );
}

// ── ANMÄL EN PARTNER / SPÖKJÄGARE (modal) ─────────────────────
function ReportModal({ onClose }) {
  const [name, setName] = useState("");
  const [target, setTarget] = useState("");
  const [reason, setReason] = useState("");
  const [contact, setContact] = useState("");
  const [done, setDone] = useState(false);

  function send() {
    if (!target.trim() || !reason.trim()) return;
    const subject = encodeURIComponent(`Anmälan: ${target}`);
    const body = encodeURIComponent(`Anmäld partner/spökjägare: ${target}\n\nFrån: ${name||"anonym"} (${contact||"ingen kontakt"})\n\nVad har hänt:\n${reason}`);
    window.location.href = `mailto:fredrick.lundberg@gmail.com?subject=${subject}&body=${body}`;
    setDone(true);
  }

  const inp = {width:"100%",background:"var(--bg3)",border:"1px solid var(--b)",borderRadius:9,padding:"10px 12px",fontSize:13,color:"var(--tx)",marginBottom:10};
  const lbl = {fontSize:11,fontWeight:600,color:"var(--tx3)",marginBottom:4,marginTop:4,display:"block"};

  if (done) return (
    <div className="modal-overlay" onClick={e=>{if(e.target===e.currentTarget)onClose();}}>
      <div className="modal-sheet au" style={{textAlign:"center",padding:"30px 22px"}}>
        <div style={{fontSize:42,marginBottom:12}}>✅</div>
        <h2 style={{fontSize:17,fontWeight:800,color:"var(--tx)",marginBottom:8}}>Tack — vi tar tag i det</h2>
        <p style={{fontSize:13,color:"var(--tx2)",lineHeight:1.65,marginBottom:14}}>
          Din anmälan har öppnat ditt mejlprogram. När du skickat hör vi av oss om vi behöver mer info.
        </p>
        <Btn ch="Stäng" v="p" full onClick={onClose}/>
      </div>
    </div>
  );

  return (
    <div className="modal-overlay" onClick={e=>{if(e.target===e.currentTarget)onClose();}}>
      <div className="modal-sheet au" style={{maxHeight:"92vh",overflowY:"auto"}}>
        <div className="modal-handle"/>
        <button onClick={onClose} style={{position:"absolute",top:14,right:14,background:"none",border:"none",color:"var(--tx3)",cursor:"pointer",fontSize:22,padding:4}}>✕</button>
        <h2 style={{fontSize:18,fontWeight:800,color:"var(--tx)",marginBottom:6}}>🚩 Anmäl en partner eller spökjägare</h2>
        <p style={{fontSize:12,color:"var(--tx3)",marginBottom:14,lineHeight:1.55}}>
          Misskötsel, falsk marknadsföring, eller helt enkelt något som känns fel? Skriv kort vad som hänt så undersöker vi.
        </p>

        <label style={lbl}>Vem anmäler du? (namn på partner/spökjägare) *</label>
        <input style={inp} value={target} onChange={e=>setTarget(e.target.value)} placeholder="t.ex. Stockholm Ghost Walks"/>

        <label style={lbl}>Vad har hänt? *</label>
        <textarea style={{...inp,minHeight:100,resize:"vertical"}} value={reason} onChange={e=>setReason(e.target.value)} placeholder="Beskriv så konkret du kan…"/>

        <label style={lbl}>Ditt namn (valfri)</label>
        <input style={inp} value={name} onChange={e=>setName(e.target.value)} placeholder="Anonym går också bra"/>

        <label style={lbl}>Din e-post / telefon (om du vill bli kontaktad)</label>
        <input style={inp} value={contact} onChange={e=>setContact(e.target.value)} placeholder="dindin@example.com"/>

        <Btn ch="📨 Skicka anmälan" v="p" full onClick={send} disabled={!target.trim()||!reason.trim()}/>
        <div style={{fontSize:10,color:"var(--tx4)",textAlign:"center",marginTop:8,lineHeight:1.5}}>
          Anmälan öppnar ditt mejlprogram för att skickas till Fredrik. Vi behandlar varje fall personligt.
        </div>
      </div>
    </div>
  );
}

// ── ROOT ──────────────────────────────────────────────────────
export default function App() {
  const { lang, setLang, t, langs } = useLang();
  const [view,setView]=useState("home");
  const [allPlacesMut,setAllPlaces]=useState([{"id":"wp-170","name":"Akamella Ödekyrkogård","slug":"akamella-odekyrkogard","url":"https://www.spokkartan.se/norrbottens-lan/akamella-odekyrkogard/","lat":66.7231,"lng":21.01,"country":"Sverige","region":"Norrbottens Län","type":"Kyrka","scary":3,"free":true,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Akamella+Ödekyrkogård","teaser":"En gåtfylld historia vid Muonioälven I norra Sverige, på en avlägsen plats nära Muodoslompolo, ligger Akamella Ödekyrkogård, en mystisk och övergiven begravningsplats med en lång historia. K","description":"En gåtfylld historia vid Muonioälven I norra Sverige, på en avlägsen plats nära Muodoslompolo, ligger Akamella Ödekyrkogård, en mystisk och övergiven begravningsplats med en lång historia. Kyrkogården invigdes 1663 för att ge lokala invånare en närmare plats att begrava sina döda, istället för att behöva resa de långa sträckorna till Pajala eller Enontekis, som låg upp till 10 mil bort. Trots att den övergavs 1817, bär platsen fortfarande på historier och minnen från de människor som en gång vilade där. En fristad för de döda Kyrkogården anlades utan en kyrka eller ett kapell, och den var en nödvändighet för de isolerade bosättningarna längs Muonioälven. Begravningar genomfördes här i över 1","img":"https://www.spokkartan.se/wp-content/uploads/2024/10/Akamellan_hautausmaa.jpg","date":"Fri, 18 Oct","points":60,"categories":["hemsökt","hemsöktkyrkogård","hemsöktnorrland","Kyrkogårdar"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-192","name":"Säters Mentalsjukhus","slug":"saters-mentalsjukhus","url":"https://www.spokkartan.se/mentalsjukhus/saters-mentalsjukhus/","lat":60.24,"lng":14.9657,"country":"Sverige","region":"Dalarnas Län","type":"Sanatorium","scary":5,"free":true,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Säters+Mentalsjukhus","teaser":"Res tillbaka i tiden - Välkommen in i det övergivna Spökhuset för de Kriminellt Sjuka Välkommen in i det övergivna Spökhuset för de Kriminellt Sjuka – Säters Fasta Paviljong Stig in i histor","description":"Res tillbaka i tiden - Välkommen in i det övergivna Spökhuset för de Kriminellt Sjuka Välkommen in i det övergivna Spökhuset för de Kriminellt Sjuka – Säters Fasta Paviljong Stig in i historien om Säters Fasta Paviljong, en plats med ett mörkt förflutet där några av Sveriges farligaste rättspsykiatriska patienter hölls inlåsta. Bakom de fem meter höga murarna satt personer som hade begått några av de mest allvarliga brotten i landet. Trots att paviljongen stängdes 1989 och byggnaden revs så sent som 2023, lever mystiken och obehaget kvar. Många har vittnat om känslan av att vara iakttagen och om oförklarliga ljud som ekar genom de tomma korridorerna. Vem vet vad som döljer sig bland ruinerna","img":"https://www.spokkartan.se/wp-content/uploads/2024/10/Namnlos-design-28.jpg","date":"Sun, 20 Oct","points":100,"categories":["Dalarnas Län","hemsökt","Mentalsjukhus","övergivet"],"featured":true,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-215","name":"Alborgen","slug":"alborgen","url":"https://www.spokkartan.se/mentalsjukhus/alborgen/","lat":61.6784,"lng":16.9241,"country":"Sverige","region":"Gävleborgs Län","type":"Sanatorium","scary":5,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Alborgen","teaser":"En plats där äventyr möter det övernaturliga Alborgen, beläget i Valbo nära Gävle, är en plats som har fascinerat både spökentusiaster och äventyrslystna besökare i flera år. Med sin histori","description":"En plats där äventyr möter det övernaturliga Alborgen, beläget i Valbo nära Gävle, är en plats som har fascinerat både spökentusiaster och äventyrslystna besökare i flera år. Med sin historia som ett psykiatriskt sjukhus och äldreboende är Alborgen inte bara en plats för äventyrsaktiviteter, utan även en av traktens mest kända spökplatser. I detta blogginlägg dyker vi djupt in i Alborgen och dess kusliga förflutna, och varför det är ett måste för alla som är intresserade av det övernaturliga. Alborgen – En plats fylld av historia Alborgen började sitt liv som en ”fattigvårdsanstalt”, som byggdes 1912 på en plats med ett långt förflutet. Under bygget upptäcktes skelett i källaren, vilket reda","img":"https://www.spokkartan.se/wp-content/uploads/2024/10/Skarmavbild-2024-10-20-kl.-13.58.08.png","date":"Sun, 20 Oct","points":100,"categories":["alborgen","Gävle","Gävleborgs Län","hemsökt"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-233","name":"Bona Uppfostringsanstalt och Mentalsjukhus","slug":"bona","url":"https://www.spokkartan.se/overgivna-platser/bona/","lat":59.0375,"lng":14.6287,"country":"Sverige","region":"Östergötlands Län","type":"Sanatorium","scary":5,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Bona+Uppfostringsanstalt+och+Mentalsjukhus","teaser":"En resa tillbaka i tiden Mitt i Östergötlands landsbygd ligger Bona, en plats där tiden har stannat, men vars historia fortfarande viskar genom de övergivna byggnaderna. Här på en undangömd","description":"En resa tillbaka i tiden Mitt i Östergötlands landsbygd ligger Bona, en plats där tiden har stannat, men vars historia fortfarande viskar genom de övergivna byggnaderna. Här på en undangömd plats i skogen, låg en gång både en uppfostringsanstalt och senare ett mentalsjukhus. Idag står anläggningen öde, men dess rykte för spökerier och oförklarliga händelser lever vidare. Uppfostringsanstallt Uppfostringsanstallt År 1902 förvandlades Bona från en lugn gård till en uppfostringsanstalt för vanartiga pojkar. De unga pojkarna som skickades hit från hela landet möttes av en tuff vardag, präglad av hård disciplin och strängt arbete. Deras dagar fylldes av fysiska uppgifter inom lantbruk och industr","img":"https://www.spokkartan.se/wp-content/uploads/2024/10/11-1.jpg","date":"Sun, 20 Oct","points":100,"categories":["abandoned","Bona","mentalsjukhus","Mentalsjukhus"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-284","name":"Intervju med Matti - Spökjägare och Poddare","slug":"intervju-med-matti-spokjagare-och-poddare","url":"https://www.spokkartan.se/overgivna-platser/intervju-med-matti-spokjagare-och-poddare/","lat":60.0051,"lng":17.5115,"country":"Sverige","region":"Sverige","type":"Övergiven","scary":4,"free":true,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Intervju+med+Matti+-+Spökjägare+och+Poddare","teaser":"Vad får en spökjägare att vilja sluta? Vi pratade med Matti Hietasaari från Spökjägargruppen Okänt och poddarna “Det värsta jag hört” och “Spökhistorier” för att höra om hans mest skrämmande","description":"Vad får en spökjägare att vilja sluta? Vi pratade med Matti Hietasaari från Spökjägargruppen Okänt och poddarna “Det värsta jag hört” och “Spökhistorier” för att höra om hans mest skrämmande upplevelser, varför han tror på spöken, och vilka viktiga lärdomar han tagit med sig efter år av spökjakter. Läs vidare för att dyka in i en värld fylld av mysterium, kusliga skuggor och oförklarliga händelser. \"Jag ville sluta med spökjakter efter att ha sett en man stå fem meter framför mig. Det var den värsta upplevelsen.\" Fråga : Vilka är dina bästa upplevelser som spökjägare? Matti : Förutom alla fantastiska platser och människor man fått träffa så är det beröringen, att höra och se saker. Det är sä","img":"https://www.spokkartan.se/wp-content/uploads/2024/10/c4ff1399-f783-4dbb-b366-768d058a77d5.jpeg","date":"Mon, 21 Oct","points":80,"categories":["detvärstajaghört","intervju","Intervjuer","Okänt"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-304","name":"Löfstad Slott","slug":"lofstad-slott","url":"https://www.spokkartan.se/spokjakt/lofstad-slott/","lat":57.9598,"lng":15.6329,"country":"Sverige","region":"Östergötlands Län","type":"Slott","scary":4,"free":true,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Löfstad+Slott","teaser":"Där historien ekar i varje sal Beläget i det vackra landskapet Östergötland, strax utanför Norrköping, står Löfstad slott som ett levande monument över svensk historia och aristokratins svun","description":"Där historien ekar i varje sal Beläget i det vackra landskapet Östergötland, strax utanför Norrköping, står Löfstad slott som ett levande monument över svensk historia och aristokratins svunna dagar. Slottet, byggt mellan 1630 och 1660, har genom åren haft prominenta ägare, som fältmarskalken greve Axel Lillie och hans hustru Christina Mörner, men också Sophie von Fersen, syster till den tragiskt mördade Axel von Fersen d.y. Med sina mäktiga salonger och omsorgsfullt bevarade interiörer, känns det som att tiden står stilla när man kliver in på Löfstad. Spöken som aldrig lämnat slottet Men Löfstad slott är inte bara ett historiskt landmärke – det är också ett hem för flera osaliga andar, om m","img":"https://www.spokkartan.se/wp-content/uploads/2024/10/1.jpg","date":"Mon, 21 Oct","points":80,"categories":["Hemsökta Slott","hemsöktaslott","hemsöktslott","löfstad"],"featured":true,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-331","name":"Torpa Stenhus","slug":"torpa-stenhus","url":"https://www.spokkartan.se/hemsokta-slott/torpa-stenhus/","lat":56.9625,"lng":12.2172,"country":"Sverige","region":"Västra Götalands Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Torpa+Stenhus","teaser":"Torpa Stenhus, beläget i Västergötland, är ett av Sveriges mest välbevarade medeltida slott och rymmer en rik historia som sträcker sig ända tillbaka till 1400-talet. Här har intriger, makts","description":"Torpa Stenhus, beläget i Västergötland, är ett av Sveriges mest välbevarade medeltida slott och rymmer en rik historia som sträcker sig ända tillbaka till 1400-talet. Här har intriger, maktspel och kärlekssagor utspelat sig, men också tragedier och mörka öden som satt djupa spår i slottets atmosfär. I dag är Torpa inte bara ett historiskt landmärke, utan även känt för sina spökhistorier och mystiska upplevelser. Ett besök här innebär en resa genom århundraden av både mänskliga och övernaturliga berättelser. Från medeltida borg till renässansslott Torpa Stenhus uppfördes omkring år 1470 av riksrådet Arvid Knutsson, mitt i en tid av osäkerhet och hot från både danska krig och bondeuppror. Slot","img":"https://www.spokkartan.se/wp-content/uploads/2024/10/f80cf2c9-b1cd-4bfd-974b-bfaf471862d0.webp","date":"Mon, 21 Oct","points":80,"categories":["gengångare","hemsökt","Hemsökta Slott","övernaturligt"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-366","name":"Drottningholms Slott","slug":"drottningholms-slott","url":"https://www.spokkartan.se/hemsokta-slott/drottningholms-slott/","lat":59.5698,"lng":18.1779,"country":"Sverige","region":"Stockholms Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Drottningholms+Slott","teaser":"Drottningholms slott, beläget på Lovön utanför Stockholm, är inte bara en av Sveriges mest ståtliga och historiska byggnader – det är också en plats där övernaturliga händelser sägs pågå, äv","description":"Drottningholms slott, beläget på Lovön utanför Stockholm, är inte bara en av Sveriges mest ståtliga och historiska byggnader – det är också en plats där övernaturliga händelser sägs pågå, även om man bor där som kunglighet. Trots att kungaparet har sitt officiella hem här, rapporteras det att andar från förr fortfarande gör sin närvaro känd i de imponerande salarna och trapphallarna. Drottningens Ovissa Gäster I en uppmärksammad dokumentär från 2017 överraskade drottning Silvia många när hon avslöjade att slottet är hemsökt. \"Det finns… spöken, det finns många... Kom och känn själv,\" sade hon och hänvisade till den övernaturliga närvaron som hon upplevt. Drottningen utvecklade inte vilka des","img":"https://www.spokkartan.se/wp-content/uploads/2024/10/Torpa-Stenhus.jpg","date":"Wed, 23 Oct","points":80,"categories":["drottningholmsslott","drottningsholm","hemsökt","Hemsökta Slott"],"featured":true,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-378","name":"Spökjaktsguide!","slug":"spokjaktsguide","url":"https://www.spokkartan.se/spokjakt/spokjaktsguide/","lat":59.6827,"lng":18.8542,"country":"Sverige","region":"Sverige","type":"Spökhus","scary":5,"free":true,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Spökjaktsguide!","teaser":"Spökjakt är inte bara för dem som älskar att bli skrämda – det är en fascinerande resa in i det okända. Att ge sig ut på jakt efter det övernaturliga väcker både nyfikenhet och en känsla av","description":"Spökjakt är inte bara för dem som älskar att bli skrämda – det är en fascinerande resa in i det okända. Att ge sig ut på jakt efter det övernaturliga väcker både nyfikenhet och en känsla av äventyr. Finns det verkligen något där ute som inte kan förklaras? Genom att utforska Sveriges mest hemsökta platser får du chansen att själv känna pirret i magen och kanske till och med bevittna något mystiskt. Men innan du ger dig ut på din egen spökjakt finns det en del att tänka på. Det handlar inte bara om att ha modet att stanna kvar i mörka och övergivna byggnader – du behöver också rätt verktyg, kunskap och respekt för de platser du besöker. Här kommer vår guide till spökjakt in i bilden! Vi har s","img":"https://www.spokkartan.se/wp-content/uploads/2024/10/4-1.jpg","date":"Thu, 24 Oct","points":100,"categories":["Äventyr","Guide","hemsöktahus","Spökhus"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-389","name":"Hässelby Slott","slug":"hasselby-slott","url":"https://www.spokkartan.se/hemsokta-slott/hasselby-slott/","lat":59.8251,"lng":16.8856,"country":"Sverige","region":"Stockholms Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Hässelby+Slott","teaser":"Där historien lever och spökena vandrar Hässelby Slott må vara omgivet av en vacker barockträdgård och ha en historia som sträcker sig tillbaka till 1600-talet, men för dem som är intressera","description":"Där historien lever och spökena vandrar Hässelby Slott må vara omgivet av en vacker barockträdgård och ha en historia som sträcker sig tillbaka till 1600-talet, men för dem som är intresserade av det övernaturliga är det själva byggnaden och dess mystiska atmosfär som lockar mest. Slottet är inte bara en plats för kultur och historia, utan också för de som söker en upplevelse utöver det vanliga – där närvaron av det oförklarliga nästan går att ta på. Vita Damen och andra spökerier Slottets mest kända ande, Vita Damen , har fångat fantasin hos många besökare. Hon sägs fortfarande leta efter sin älskare, vandrande genom korridorerna i tyst förtvivlan. Hennes närvaro har upplevts både som en kä","img":"https://www.spokkartan.se/wp-content/uploads/2024/10/Namnlos-design-32.jpg","date":"Thu, 24 Oct","points":80,"categories":["hemsökt","Hemsökta Slott","hemsöktslott","spöken"],"featured":true,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-468","name":"Tynnelsö Slott","slug":"tynnelso-slott","url":"https://www.spokkartan.se/overgivna-platser/tynnelso-slott/","lat":59.6893,"lng":16.9855,"country":"Sverige","region":"Södermanlands Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Tynnelsö+Slott","teaser":"En historisk plats för biskopar och kungar Mitt i Mälarens lugna vatten utanför Strängnäs ligger Tynnelsö slott, ett av Sveriges mest avlägsna och mystiska slott. Slottet, som numera står to","description":"En historisk plats för biskopar och kungar Mitt i Mälarens lugna vatten utanför Strängnäs ligger Tynnelsö slott, ett av Sveriges mest avlägsna och mystiska slott. Slottet, som numera står tomt och otillgängligt för allmänheten, har en historia fylld av kungligheter, religiösa figurer och dramatiska händelser. Men trots sin långa övergivenhet är framtiden kanske ljusare än på länge – Statens fastighetsverk hoppas att slottet en dag ska kunna öppnas igen. Tynnelsö slott byggdes ursprungligen under 1300-talet, men delar av byggnaden sträcker sig så långt tillbaka som till slutet av 1200-talet. På den tiden fungerade slottet som en befäst biskopsresidens, strategiskt placerat så att man lätt kun","img":"https://www.spokkartan.se/wp-content/uploads/2024/10/Tynnelso-Slott-wiki.jpg","date":"Thu, 31 Oct","points":80,"categories":["Hemsökta Slott","övergivet","Övergivna Platser","slott"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-509","name":"Krusenberg Herrgård","slug":"krusenberg","url":"https://www.spokkartan.se/hemsokta-herrgardar/krusenberg/","lat":59.6044,"lng":16.8132,"country":"Sverige","region":"Uppsala Län","type":"Herrgård","scary":4,"free":true,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Krusenberg+Herrgård","teaser":"Längs den gamla allén som leder mot Krusenbergs Herrgård sträcker sig skuggor över de slitna kullerstenarna och vidare mot Mälarens strandkant. Det är en plats som bär på mer än bara histori","description":"Längs den gamla allén som leder mot Krusenbergs Herrgård sträcker sig skuggor över de slitna kullerstenarna och vidare mot Mälarens strandkant. Det är en plats som bär på mer än bara historiska minnen – det sägs att det också finns ett osynligt sällskap, en svag viskning av dem som aldrig riktigt lämnat gården. Krusenberg är inte bara ett vackert konferenshotell; här kan den som är tillräckligt uppmärksam få en glimt av en annan verklighet, en där Vita frun håller middagsvakt och svarta skuggor rör sig i parke n. Hitta fler hemsökta Herrgårdar, klicka här En herrgård fylld av historia Krusenbergs nuvarande herrgårdsbyggnad restes 1802 i ståltålig empirestil. Men dess historia är äldre och fu","img":"https://www.spokkartan.se/wp-content/uploads/2024/10/8-4.jpg","date":"Thu, 31 Oct","points":80,"categories":["hemsökt","Hemsökta Herrgårdar","herrgård","Krusenberg"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-522","name":"Så skapar du en Spökvandring","slug":"spokvandring","url":"https://www.spokkartan.se/spokjakt/spokvandring/","lat":60.8615,"lng":18.2478,"country":"Sverige","region":"Sverige","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Så+skapar+du+en+Spökvandring","teaser":"Få fler gäster och dela med dig av historien Spökvandringar har blivit alltmer populära, och är en utmärkt möjlighet att skapa en upplevelse som besökare talar om långt efter sitt besök. Gen","description":"Få fler gäster och dela med dig av historien Spökvandringar har blivit alltmer populära, och är en utmärkt möjlighet att skapa en upplevelse som besökare talar om långt efter sitt besök. Genom att kombinera historia, mystik och storytelling, kan du lyfta fram platsens identitet på ett nytt och engagerande sätt. Och i gengäld få fler nöjda besökare. Oavsett om din egendom redan har en stark historisk närvaro eller om du vill lyfta fram de mörkare aspekterna av platsens förflutna, kan en spökvandring ge ett extra lager av fascination och nyfikenhet. Genom att samarbeta med Spökkartan får du en partner som har erfarenhet av eventplanering, marknadsföring och branding – och som vet hur man skapa","img":"https://www.spokkartan.se/wp-content/uploads/2024/11/Gas-bottles-1.jpg","date":"Mon, 04 Nov","points":80,"categories":["Halloween","hemsökt","herrgård","slott"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-535","name":"Alvastra Klosterruin","slug":"alvastra-klosterruin","url":"https://www.spokkartan.se/overgivna-platser/alvastra-klosterruin/","lat":57.7584,"lng":14.6521,"country":"Sverige","region":"Östergötlands Län","type":"Ruin","scary":3,"free":true,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Alvastra+Klosterruin","teaser":"En vacker ruin, en hemsökt plats Alvastra klosterruin är idag en av Sveriges mest fascinerande historiska platser. Beläget vid Ombergs fot i Ödeshögs kommun, reser sig ruinen som en påminnel","description":"En vacker ruin, en hemsökt plats Alvastra klosterruin är idag en av Sveriges mest fascinerande historiska platser. Beläget vid Ombergs fot i Ödeshögs kommun, reser sig ruinen som en påminnelse om medeltidens storhet. Grundat 1143 av cisterciensmunkar från det franska klostret Clairvaux, var Alvastra kloster ett centrum för religiös aktivitet och innovation. I nästan 400 år spelade klostret en viktig roll i Sveriges framväxt. Men bakom den vackra ruinen lurar också mörka hemligheter. Alvastra är inte bara en plats för historisk reflektion – det sägs också vara hemsökt av munkarna som en gång bodde där. https://open.spotify.com/show/5P3kRjCOb5a8IRx1tLY2Mi?si=415dd19f59a64120 Det hemsökta Alvas","img":"https://www.spokkartan.se/wp-content/uploads/2024/11/IMG_3250.jpeg","date":"Thu, 12 Jun","points":60,"categories":["Alvastra","heligabirgitta","hemsökt","Ödeshög"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-539","name":"Gamla Löwenströmska Lasarettet","slug":"lowenstromska","url":"https://www.spokkartan.se/overgivna-platser/lowenstromska/","lat":59.886,"lng":18.3189,"country":"Sverige","region":"Stockholms Län","type":"Övergiven","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Gamla+Löwenströmska+Lasarettet","teaser":"Övergivet sjukhus med en mörk historia Gamla Löwenströmska lasarettet i Upplands Väsby är mer än en bortglömd byggnad. Bakom dess slitna fasader och krossade rutor döljer sig en historia som","description":"Övergivet sjukhus med en mörk historia Gamla Löwenströmska lasarettet i Upplands Väsby är mer än en bortglömd byggnad. Bakom dess slitna fasader och krossade rutor döljer sig en historia som skakade om Sverige - mordet på Gustav III. Lasarettet grundades 1811 av ryttmästare Gustaf Adolf Löwenström. Genom en stor donation av mark vid sjön Fysingen, ville han sona ett mörkt familjearv: det var hans bror, Jacob Johan Anckarström, som sköt Gustav III på Operan i Stockholm 1792. Gustaf Adolf Löwenström bytte namn och donerade pengar till ett sjukhus för att försöka återupprätta familjens rykte. Ett sjukhus med en så dramatisk bakgrund bär med sig en historia av skuld, död och botgöring – något so","img":"https://www.spokkartan.se/wp-content/uploads/2024/11/5.jpg","date":"Mon, 04 Nov","points":80,"categories":["hemsökt","Löwenströmska","övergivet","Övergivetsjukhus"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-545","name":"Gamla apoteket","slug":"gamla-apoteket","url":"https://www.spokkartan.se/stockholms-lan/gamla-apoteket/","lat":59.8214,"lng":18.6214,"country":"Sverige","region":"Stockholms Län","type":"Spökhus","scary":5,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Gamla+apoteket","teaser":"Ouppklarat mord och ouppklarade frågor I december 1913 hände något som fortfarande hemsöker Gamla apoteket i Upplands Väsby. Apotekaren Johan Hallbergson hörde plötsligt rop på hjälp från si","description":"Ouppklarat mord och ouppklarade frågor I december 1913 hände något som fortfarande hemsöker Gamla apoteket i Upplands Väsby. Apotekaren Johan Hallbergson hörde plötsligt rop på hjälp från sitt apotek, men innan han hann agera överfölls han och dog av ett djupt knivhugg. Det som är mest skrämmande? Mordet förblir ouppklarat. Besökare som passerar Gamla apoteket har vittnat om en känsla av oro, som om platsen själv försöker berätta sin mörka historia. Är det den mördade apotekarens själ som fortfarande irrar omkring och söker svar på vad som hände den där kalla decembernatten?","img":"https://www.spokkartan.se/wp-content/uploads/2024/11/Spok-memes-9-1.jpg","date":"Tue, 12 Nov","points":100,"categories":["gamla apoteket","hemsökt","Spökhus","Stockholms Län"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-552","name":"Apertins Herrgård","slug":"apertins-herrgard","url":"https://www.spokkartan.se/hemsokta-herrgardar/apertins-herrgard/","lat":59.438,"lng":14.6355,"country":"Sverige","region":"Värmlands Län","type":"Herrgård","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Apertins+Herrgård","teaser":"En plats där legender och mörka historier möts Djupt i de värmländska skogarna, omgiven av bäckraviner och gammal skog, ligger Apertins Herrgård – en herrgård som både fascinerar och skrämme","description":"En plats där legender och mörka historier möts Djupt i de värmländska skogarna, omgiven av bäckraviner och gammal skog, ligger Apertins Herrgård – en herrgård som både fascinerar och skrämmer med sina mörka legender och rykten om hemsökelse. Herrgården, belägen i Stora Kils socken i Kils kommun, har en lång och mystisk historia som sträcker sig ända tillbaka till 1000-talet. Det är dock furstinnan Sara Löwenhielm och hennes mörka öde som har satt djupast avtryck på platsen och gjort Apertin till en av Sveriges mest omtalade hemsökta platser. Furstinnan Sara Löwenhielm och dansen med djävulen Enligt legenden var det furstinnan Sara Löwenhielm som för alltid kom att försegla Apertins öde som e","img":"https://www.spokkartan.se/wp-content/uploads/2024/11/1.jpg","date":"Wed, 06 Nov","points":80,"categories":["Aprtins","hemsökt","Hemsökta Herrgårdar","Hemsöktherrgård"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-669","name":"Berga Herrgård","slug":"berga-herrgard","url":"https://www.spokkartan.se/kalmar-lan/berga-herrgard/","lat":56.4657,"lng":16.4849,"country":"Sverige","region":"Kalmar Län","type":"Herrgård","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Berga+Herrgård","teaser":"En av Smålands mest hemsökta platser Berga Herrgård i Högsby, Småland, är en plats fylld av både historia och mörka legender. Den pampiga herrgården, som går tillbaka till 1200-talet, har va","description":"En av Smålands mest hemsökta platser Berga Herrgård i Högsby, Småland, är en plats fylld av både historia och mörka legender. Den pampiga herrgården, som går tillbaka till 1200-talet, har varit hem för både adelsmän och soldater. Men det är berättelserna om spöken och övernaturliga fenomen som lockar besökare idag. Här sägs nämligen andar från förr fortfarande hemsöka rummen och markerna. Vem var Bengt Bagge? Den mest kända spökhistorien på Berga Herrgård handlar om Bengt Bagge, en fruktad militär och godsägare som köpte herrgården på 1600-talet. Han beskrivs som en hård och skrämmande personlighet som satte skräck i hela bygden. Enligt sägnerna ska Bengt Bagges vålnad än idag hemsöka gården","img":"https://www.spokkartan.se/wp-content/uploads/2024/11/Berga-Herrgard.jpg","date":"Wed, 06 Nov","points":80,"categories":["Berga Herrgård","hemsökt","Hemsökta Herrgårdar","hemsöktaplatser"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-696","name":"Övergivna platser","slug":"overgivna-platser","url":"https://www.spokkartan.se/overgivna-platser/overgivna-platser/","lat":60.657,"lng":18.9244,"country":"Sverige","region":"Sverige","type":"Övergiven","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Övergivna+platser","teaser":"Urban Exploring Att utforska övergivna platser, eller ”urban exploration” (urbex), är en populär aktivitet för den äventyrliga – men det är viktigt att veta vad som gäller i Sverige för att","description":"Urban Exploring Att utforska övergivna platser, eller ”urban exploration” (urbex), är en populär aktivitet för den äventyrliga – men det är viktigt att veta vad som gäller i Sverige för att hålla sig inom lagens gränser. Vad säger lagen om övergivna byggnader? Enligt svensk lag är det inte tillåtet att gå in på privat eller avspärrad mark utan tillstånd. Även om en byggnad är övergiven, har den i de flesta fall fortfarande en ägare, och att ta sig in på området räknas som olaga intrång. Ägaren kan alltså polisanmäla och urbexare kan få böter om de ertappas. Om det dessutom skulle uppstå skador på byggnaden, kan urbexaren åtalas för skadegörelse. Även om byggnaden är statligt ägd eller tillhö","img":"https://www.spokkartan.se/wp-content/uploads/2024/11/4-2.jpg","date":"Fri, 08 Nov","points":80,"categories":["övergivet","Övergivna platser","Övergivna Platser","övergivnaplatsersverige"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-715","name":"Ekenäs Slott","slug":"ekenas-slott","url":"https://www.spokkartan.se/hemsokta-slott/ekenas-slott/","lat":58.9887,"lng":15.8056,"country":"Sverige","region":"Östergötlands Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Ekenäs+Slott","teaser":"Välkomna in till ett av Sveriges mest hemsökta slott Ekenäs slott, beläget i Örtomta socken i Linköpings kommun, bär på en mörk och mystisk historia som gör det till en plats fylld av sägner","description":"Välkomna in till ett av Sveriges mest hemsökta slott Ekenäs slott, beläget i Örtomta socken i Linköpings kommun, bär på en mörk och mystisk historia som gör det till en plats fylld av sägner och skräckinjagande berättelser. Med en lång historia av förbannelser, dödsfall och oförklarliga händelser har slottet blivit känt som ett av Sveriges mest hemsökta. Här utforskar vi några av de mest kända spökhistorierna om Ekenäs slott, inklusive den ökända berättelsen om \"Nisses håla\". Bilder av Matti Hietasaari Nisses håla – den inmurade drängens förbannelse En av de mest kända sägnerna om Ekenäs slott handlar om en ung dräng vid namn Nisse, som enligt legenden blev inmurad i ett källarrum för flera ","img":"https://www.spokkartan.se/wp-content/uploads/2024/11/10.jpg","date":"Sun, 10 Nov","points":80,"categories":["Ekenäs","hemsökt","Hemsökta Slott","Norrköping"],"featured":true,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-739","name":"Bjurholms Prästgård","slug":"bjurholms-prastgard","url":"https://www.spokkartan.se/hemsokt-prastgard/bjurholms-prastgard/","lat":64.4273,"lng":19.17,"country":"Sverige","region":"Västerbottens Län","type":"Prästgård","scary":4,"free":true,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Bjurholms+Prästgård","teaser":"En hemsökt pärla i Västerbotten Bjurholms prästgård i Västerbottens län är en plats som bär på över hundrafemtio års historia – och kanske några av dess tidigare invånare! Sedan prästgården","description":"En hemsökt pärla i Västerbotten Bjurholms prästgård i Västerbottens län är en plats som bär på över hundrafemtio års historia – och kanske några av dess tidigare invånare! Sedan prästgården invigdes 1853 har många passerat genom dess dörrar, men det sägs att vissa själar dröjer sig kvar. Med historier om spöken, mystiska steg och viskande röster har prästgården blivit en av Västerbottens mest omtalade hemsökta platser. Röster från det förflutna Hyresgäster och besökare på Bjurholms prästgård har vid upprepade tillfällen hört dämpade samtal från övervåningen, där två röster – som av män – verkar föra en livlig diskussion. När någon går upp för att titta efter, möts de dock bara av en kuslig t","img":"https://www.spokkartan.se/wp-content/uploads/2024/11/Ekenas-1.jpg","date":"Sun, 10 Nov","points":80,"categories":["bjurholms","bjurholms prästgård","Hemsökt Prästgård","prästgård"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-744","name":"Blomsholm Herrgård","slug":"blomsholm-herrgard","url":"https://www.spokkartan.se/hemsokta-herrgardar/blomsholm-herrgard/","lat":57.2846,"lng":12.4345,"country":"Sverige","region":"Västra Götalands Län","type":"Herrgård","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Blomsholm+Herrgård","teaser":"En av Västsveriges mest hemsökta herrgårdar Blomsholm herrgård, belägen i Strömstad i Västra Götalands län, är en plats som fascinerar både historiker och besökare med intresse för det övern","description":"En av Västsveriges mest hemsökta herrgårdar Blomsholm herrgård, belägen i Strömstad i Västra Götalands län, är en plats som fascinerar både historiker och besökare med intresse för det övernaturliga. Med anor från 1600-talet och en rik historia av krig, fältsjukhus och spöklika sägner har Blomsholm blivit känd som en av Västsveriges mest hemsökta platser. Den säregna herrgården är både en kulturhistorisk pärla och en plats för spännande historier om spöken och mystiska händelser. Spöken på Blomsholm herrgård – ryttaren Conrad von Ranck Enligt legenden är Blomsholm hemsökt av ett speciellt spöke – ryttaren Conrad von Ranck, som ses rida på sin bruna häst kring herrgården. Den mystiska ryttare","img":"https://www.spokkartan.se/wp-content/uploads/2024/11/Blomsholms_sateri.jpg","date":"Sun, 10 Nov","points":80,"categories":["hemsökt","hemsökt herrgård","Hemsökta Herrgårdar","spöken"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-812","name":"Bogesund Slott","slug":"bogesund-slott","url":"https://www.spokkartan.se/stockholms-lan/bogesund-slott/","lat":58.6577,"lng":17.4287,"country":"Sverige","region":"Stockholms Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Bogesund+Slott","teaser":"Där förbannelser och spöken lever kvar I Vaxholm, mitt bland Stockholms skärgårds natursköna landskap, ligger Bogesunds slott – en plats som sägs bära på förbannelser och en kuslig historia.","description":"Där förbannelser och spöken lever kvar I Vaxholm, mitt bland Stockholms skärgårds natursköna landskap, ligger Bogesunds slott – en plats som sägs bära på förbannelser och en kuslig historia. Här har dörrar slagit igen av sig själva, skrämmande skrik ekat i natten, och siluetter av bortgångna adelsdamer skymtats i festsalarna. Byggt på 1640-talet av greve Per Brahe den yngre, omges slottet av mörka sägner som fortsätter att fascinera och skrämma besökare än idag. Många som besökt platsen har vittnat om mystiska händelser som pekar på att slottet fortfarande är bebott – men inte av de levande. Förbannelsen som formade Bogesunds öde När Bogesunds slott stod färdigt på 1640-talet varnade dess sk","img":"https://www.spokkartan.se/wp-content/uploads/2024/11/6-2.jpg","date":"Fri, 15 Nov","points":80,"categories":["Bogesund Slott","Hängd","hemsökta platser","Hemsökta Slott"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-845","name":"Borgvattnets prästgård","slug":"borgvattnets-prastgard","url":"https://www.spokkartan.se/hemsokt-prastgard/borgvattnets-prastgard/","lat":62.5316,"lng":14.1271,"country":"Sverige","region":"Jämtlands Län","type":"Prästgård","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Borgvattnets+prästgård","teaser":"Sveriges mest ökända spökhus Djupt inne i Jämtlands trolska skogar ligger en plats som fått en nästan mytisk status – Borgvattnets prästgård. Den lilla byn Borgvattnet, med sin rofyllda omgi","description":"Sveriges mest ökända spökhus Djupt inne i Jämtlands trolska skogar ligger en plats som fått en nästan mytisk status – Borgvattnets prästgård. Den lilla byn Borgvattnet, med sin rofyllda omgivning och vackra natur, är hem för det som ofta kallas Sveriges mest hemsökta hus. Prästgården, som byggdes 1876, ser vid första anblick ut som ett stillsamt gammalt hus – men dess väggar bär på berättelser som får blodet att frysa till is. Här har generationer av präster och besökare vittnat om skrämmande fenomen: möbler som flyttar sig, fotsteg som ekar genom tomma korridorer och mystiska skepnader som dyker upp när man minst anar det. Är du redo att möta det okända? Bild: Johanna Persson Spökerierna i ","img":"https://www.spokkartan.se/wp-content/uploads/2024/11/Bogesund-Slott-2.jpg","date":"Sat, 16 Nov","points":80,"categories":["borgvattnet","borgvattnets prästgård","hemsökt","Hemsökt Prästgård"],"featured":true,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-849","name":"Broby Sanatorium","slug":"broby-sanatorium","url":"https://www.spokkartan.se/overgivna-platser/broby-sanatorium/","lat":56.0571,"lng":13.1656,"country":"Sverige","region":"Skåne Län","type":"Sanatorium","scary":5,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Broby+Sanatorium","teaser":"Broby Sanatorium – Från vårdplats till hemsökt spökhus och bostadsområde i kris Broby Sanatorium, beläget i Skåne, har länge varit en plats som bär på både tragiska berättelser och kusliga r","description":"Broby Sanatorium – Från vårdplats till hemsökt spökhus och bostadsområde i kris Broby Sanatorium, beläget i Skåne, har länge varit en plats som bär på både tragiska berättelser och kusliga rykten. Byggt 1912 som ett sanatorium för tuberkulossjuka, var det en gång en plats där patienter kämpade för sina liv. Efter att ha stått tomt i decennier fick det rykte som ett av Sveriges mest hemsökta spökhus, med rapporter om fotsteg i tomma korridorer, mystiska viskningar och skuggor som rör sig i ögonvrån. Men platsens historia har tagit en ny, tragisk vändning. Fram till 2022 bodde omkring 300 personer i byggnaden under osäkra och farliga förhållanden, något som ledde till att Östra Göinge kommun k","img":"https://www.spokkartan.se/wp-content/uploads/2024/11/5-4.jpg","date":"Sun, 17 Nov","points":100,"categories":["Broby Sanatorium","hemsökt i skåne","hemsökt sanatorium","hemsökt sjukhus"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-860","name":"Brokinds gård","slug":"brokinds-gard","url":"https://www.spokkartan.se/hemsokta-slott/brokinds-gard/","lat":58.2023,"lng":14.9228,"country":"Sverige","region":"Östergötlands Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Brokinds+gård","teaser":"Ett spökslott med Barbro Påles skrämmande närvaro Bland Östergötlands natursköna landskap ligger Brokinds gård, en plats med ett historiskt arv som sträcker sig över århundraden. Men det är","description":"Ett spökslott med Barbro Påles skrämmande närvaro Bland Östergötlands natursköna landskap ligger Brokinds gård, en plats med ett historiskt arv som sträcker sig över århundraden. Men det är inte bara gårdens arkitektur och historia som lockar besökare. Här sägs den fruktade vålnaden Barbro Påle fortfarande spöka. Fast besluten att aldrig låta gården glömma hennes hårdföra och grymma liv. Legenden om Barbro Påle – en adelsdam som vägrar vila Barbro Påle, eller Barbro Gustafsdotter Lillie, var en adelsdam på Brokinds gård under 1600-talet. Hon är mest känd för sin hänsynslösa behandling av gårdens tjänare, vilket gav henne ett rykte som både grym och obarmhärtig. Enligt legenden var hon så fru","img":"https://www.spokkartan.se/wp-content/uploads/2024/11/2-4.jpg","date":"Sun, 17 Nov","points":80,"categories":["Barbro Påle","brokinds gård","Brokinds slott","hemsökta platser i östergötland"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-864","name":"Bromma Kyrka","slug":"bromma-kyrka","url":"https://www.spokkartan.se/hemsokt-kyrka/bromma-kyrka/","lat":58.9572,"lng":19.118,"country":"Sverige","region":"Stockholms Län","type":"Kyrka","scary":3,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Bromma+Kyrka","teaser":"I Bromma, bara några kilometer från Stockholms centrum, ligger en kyrka vars historia är lika fascinerande som kuslig. Bromma kyrka, en av Sveriges äldsta rundkyrkor, har i århundraden varit","description":"I Bromma, bara några kilometer från Stockholms centrum, ligger en kyrka vars historia är lika fascinerande som kuslig. Bromma kyrka, en av Sveriges äldsta rundkyrkor, har i århundraden varit föremål för berättelser om oförklarliga fenomen och spöken. Steg som ekar i de tomma gångarna, ljus som tänds av sig själva och skuggor som rör sig mellan bänkarna är bara några av de händelser som besökare och personal vittnat om. För den som vågar möta det övernaturliga erbjuder denna kyrka en unik inblick i både historia och mystik. Den osaliga prästen – en själ som inte finner ro En av de mest kända legenderna om Bromma kyrka handlar om en präst från 1600-talet som aldrig lämnade platsen. Hans själ s","img":"https://www.spokkartan.se/wp-content/uploads/2024/11/Bromma-Kyrka.jpg","date":"Sun, 17 Nov","points":60,"categories":["Bromma kyrka","hemsökt bromma","Hemsökt Kyrka","hemsökt kyrka"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-867","name":"Gunnebo Slott","slug":"gunnebo-slott","url":"https://www.spokkartan.se/vastra-gotalands-lan/gunnebo-slott/","lat":57.9569,"lng":13.2019,"country":"Sverige","region":"Västra Götalands Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Gunnebo+Slott","teaser":"Ett slott med spöken och mystik Gunnebo Slott i Mölndal är inte bara en historisk pärla – det är också en plats där det sägs att det övernaturliga har ett starkt fäste. Spöken, märkliga doft","description":"Ett slott med spöken och mystik Gunnebo Slott i Mölndal är inte bara en historisk pärla – det är också en plats där det sägs att det övernaturliga har ett starkt fäste. Spöken, märkliga dofter och skepnader som dyker upp när du minst anar det har gjort slottet till en plats som fascinerar både besökare och lokalbor. Här kan du läsa om några av de mest omskakande berättelserna från det hemsökta slottet. Den rastlösa anden i Kinarummet I ett av slottets mest anmärkningsvärda rum, Kinarummet, har både personal och gäster upplevt något mycket märkligt. Vid vissa tillfällen fylls rummet av en intensiv stank – som av något bränt eller ruttet. Lukten försvinner lika snabbt som den kom, och ingen ha","img":"https://www.spokkartan.se/wp-content/uploads/2024/11/2-5.jpg","date":"Mon, 18 Nov","points":80,"categories":["Gunnebo Slott","Hemsökt Slott","Hemsökta platser Göteborg","Hemsökta Slott"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-907","name":"Frammegården i Skillingmark","slug":"frammegarden","url":"https://www.spokkartan.se/spokjakt/frammegarden/","lat":58.8538,"lng":14.0499,"country":"Sverige","region":"Värmlands Län","type":"Prästgård","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Frammegården+i+Skillingmark","teaser":"Ett av Sveriges mest hemsökta spökhus? Djupt inne i de värmländska skogarna, nära gränsen till Norge, ligger Frammegården – en plats som bär på rykten om spöken, häxor och tragiska öden. Det","description":"Ett av Sveriges mest hemsökta spökhus? Djupt inne i de värmländska skogarna, nära gränsen till Norge, ligger Frammegården – en plats som bär på rykten om spöken, häxor och tragiska öden. Det gamla huset i Skillingmark har inte bara en mörk historia utan lockar idag mängder av besökare som hoppas få uppleva det övernaturliga. Med rapporter om spökbarn, märkliga ljud och oförklarliga händelser är Frammegården vida känt som ett av Sveriges mest hemsökta hus. Vågar du besöka denna hemsökta gård? En historia av tragedi och död Frammegården byggdes på 1700-talet och har använts som både hem och plats för vård av döende. Ett av de mest kända rummen är \"likrummet\", där svårt sjuka fick vänta på döde","img":"https://www.spokkartan.se/wp-content/uploads/2024/11/6-4.jpg","date":"Thu, 21 Nov","points":80,"categories":["avrättningar","frammegården","häxor","hemsökt"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-924","name":"Kumla Herrgård","slug":"kumla-herrgard","url":"https://www.spokkartan.se/hemsokta-herrgardar/kumla-herrgard/","lat":58.7914,"lng":17.7807,"country":"Sverige","region":"Stockholms Län","type":"Herrgård","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Kumla+Herrgård","teaser":"Historia och spöken Mitt bland moderna villor och lummiga träd i Tyresö, Stockholms län, döljer sig Kumla Herrgård. Denna ståtliga byggnad, med anor från 1600-talet, är lika berömd för sin r","description":"Historia och spöken Mitt bland moderna villor och lummiga träd i Tyresö, Stockholms län, döljer sig Kumla Herrgård. Denna ståtliga byggnad, med anor från 1600-talet, är lika berömd för sin rika historia som för sina spökhistorier. Här har adelsmän bott, tragedier utspelats och paranormala aktiviteter rapporterats. Kumla Herrgård har blivit en plats för både historieintresserade och modiga själar som vågar söka det övernaturliga. En herrgård med djupa historiska rötter Namnet Kumla tros härstamma från \"kummel,\" som syftar på ett förhistoriskt sjömärke eller gränsmarkering. Herrgården omnämns första gången 1460, men platsens historia sträcker sig långt tillbaka till järnåldern. Gravfältet vid ","img":"https://www.spokkartan.se/wp-content/uploads/2024/11/2-7.jpg","date":"Thu, 21 Nov","points":80,"categories":["hemsökt","hemsökt herrgård","Hemsökta Herrgårdar","herrgård"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-930","name":"Salsta Slott","slug":"salsta-slott","url":"https://www.spokkartan.se/hemsokta-slott/salsta-slott/","lat":60.6432,"lng":17.976,"country":"Sverige","region":"Uppsala Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Salsta+Slott","teaser":"Spöken och mysterier i det uppländska landskapet Vid första anblick kan Salsta slott framstå som vilket historiskt barockslott som helst. Men bakom de tjocka stenmurarna och i de utsmyckade","description":"Spöken och mysterier i det uppländska landskapet Vid första anblick kan Salsta slott framstå som vilket historiskt barockslott som helst. Men bakom de tjocka stenmurarna och i de utsmyckade rummen döljer sig berättelser som är allt annat än vanliga. Många som besökt Salsta har vittnat om oförklarliga fenomen. Ljudet av möbler som flyttas trots att ingen är där, skepnader som plötsligt dyker upp och försvinner. Och den märkliga blodfläcken på tredje våningen som ingen lyckats tvätta bort. Salsta slott är en plats där det förflutna verkar leva kvar på sätt som får håret att resa sig. En av de mest kända berättelserna handlar om \"Isabellas rum\" på tredje våningen. Det är inte bara känt för sin ","img":"https://www.spokkartan.se/wp-content/uploads/2024/11/Skarmavbild-2024-11-22-kl.-14.00.12.png","date":"Tue, 28 Jan","points":80,"categories":["förädarna","hemsökt i uppsala","Hemsökta Slott","hemsöktslott"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-935","name":"Intervju med John Lietz, grundare av Spökjakt Sverige","slug":"intervju-john-lietz","url":"https://www.spokkartan.se/spokjakt/intervju-john-lietz/","lat":60.2211,"lng":19.0831,"country":"Sverige","region":"Sverige","type":"Spökhus","scary":5,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Intervju+med+John+Lietz,+grundare+av+Spökjakt+Sverige","teaser":"Att möta det övernaturliga är inget för de lättskrämda, men för John Lietz, tvåbarnsfar och grundare av Spökjägargruppen Spökjakt Sverige, blev det en oväntad passion. Jag har känt John läng","description":"Att möta det övernaturliga är inget för de lättskrämda, men för John Lietz, tvåbarnsfar och grundare av Spökjägargruppen Spökjakt Sverige, blev det en oväntad passion. Jag har känt John länge och äntligen fick jag chansen att intervjua honom. Och höra om hur han gick från att vara mörkrädd till att bli en av Sveriges mest engagerade spökjägare . Hur började ditt intresse för spökjakt, John? – Det var egentligen en slump, om jag ska vara ärlig. Vi hade hållit på med skräckfilmer och sketcher på YouTube sedan 2012, men det var inget seriöst. Det riktiga intresset väcktes när jag började höra historier om konstiga saker som hänt i vår skärgårdsstuga. \"Det var efter första natten jag visste att ","img":"https://www.spokkartan.se/wp-content/uploads/2024/11/6-5.jpg","date":"Sat, 23 Nov","points":100,"categories":["hemsökta platser","intervju","Övergivna platser","Spökhus"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-966","name":"Snarums kyrka","slug":"snarums-kyrka","url":"https://www.spokkartan.se/hemsokt-kyrka/snarums-kyrka/","lat":61.0186,"lng":9.1324,"country":"Norge","region":"Norge","type":"Kyrka","scary":3,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Snarums+kyrka","teaser":"Snarums kyrka, belägen i den idylliska Modums kommun i Norge, har en historia som sträcker sig tillbaka till medeltiden. Men förutom sin vackra arkitektur och långa traditioner har kyrkan oc","description":"Snarums kyrka, belägen i den idylliska Modums kommun i Norge, har en historia som sträcker sig tillbaka till medeltiden. Men förutom sin vackra arkitektur och långa traditioner har kyrkan också blivit känd för något annat – berättelserna om det övernaturliga. Det är en plats där historia och mystik går hand i hand, och där flera vittnesmål tyder på att kyrkan är en av Norges mest hemsökta kyrka. Märkliga ljud och osynliga steg Trots kyrkans lugna exteriör är det många som vittnat om oförklarliga händelser innanför dess murar. En av de mest omskrivna personerna som delat med sig av sina upplevelser är Kallskapellan Steinar Sund. Han har aldrig sett något övernaturligt i kyrkan, men desto fler","img":"https://www.spokkartan.se/wp-content/uploads/2024/12/Snarums-Kirke-1.jpg","date":"Wed, 11 Dec","points":60,"categories":["hemsökt kyrka","Hemsökt Kyrka","Modums Kommun","Snarums Kyrka"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-972","name":"Dolm kirke","slug":"dolm-kirke","url":"https://www.spokkartan.se/spokplatser-i-norge/dolm-kirke/","lat":60.0365,"lng":7.347,"country":"Norge","region":"Norge","type":"Kyrka","scary":3,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Dolm+kirke","teaser":"En plats för tro, tragedier och mysterier Dolm kirke, belägen på Dolmøya i Hitra kommun, är en av de äldsta byggnaderna längs Trøndelagskusten och bär på en historia full av dramatik, tro oc","description":"En plats för tro, tragedier och mysterier Dolm kirke, belägen på Dolmøya i Hitra kommun, är en av de äldsta byggnaderna längs Trøndelagskusten och bär på en historia full av dramatik, tro och övernaturliga berättelser. Kyrkan har stått som en symbol för både uthållighet och mystik sedan medeltiden. Men det är inte bara kyrkans ålder och stormiga historia som fascinerar – platsen har också blivit ökänd för en osalig själ som sägs vandra i dess korridorer: Den svarta damen. En kyrka präglad av eld och återuppbyggnad Dolm kirke uppfördes ursprungligen någon gång mellan 1400- och 1500-talet, i en tid där kyrkor byggdes med massiva stenväggar och rundbågar i romansk stil. Den fungerade länge som ","img":"https://www.spokkartan.se/wp-content/uploads/2025/01/Dolm-Kirke-1.jpg","date":"Wed, 27 Nov","points":60,"categories":["Dolm Kirke","Hemsökt Kyrka","hemsökt kyrka","Norska Spökplatser"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-978","name":"Gamla Värket","slug":"gamla-varket","url":"https://www.spokkartan.se/spokplatser-i-norge/gamla-varket/","lat":60.1747,"lng":7.9126,"country":"Norge","region":"Norge","type":"Hotell","scary":4,"free":true,"bookable":true,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Gamla+Värket","teaser":"En historisk pärla i Sandnes med en kuslig sida Mi tt i hjärtat av Sandnes, bara en minut från tågstationen och längs den charmiga gågatan Langgata, ligger GamlaVærket Gjæstgiveri &amp; Trac","description":"En historisk pärla i Sandnes med en kuslig sida Mi tt i hjärtat av Sandnes, bara en minut från tågstationen och längs den charmiga gågatan Langgata, ligger GamlaVærket Gjæstgiveri &amp; Tracteringssted. Ett hotell och en restaurang som bär på en historia lika rik som den är fascinerande. Det är inte bara en plats för vila och god mat, utan också en levande del av Norges industriella arv. Men GamlaVærket har också en annan, mer mystisk dimension. Bland de gamla väggarna sägs två gestalter från det förflutna vandra än idag. Ett historiskt hotell med anor från 1783 GamlaVærket, som grundades 1783 av Lauritz Smith Pedersen, är en av de äldsta bevarade industribyggnaderna i Sandnes och Rogaland f","img":"https://www.spokkartan.se/wp-content/uploads/2024/11/John-Spokjakt-Sverige-1.jpg","date":"Wed, 27 Nov","points":80,"categories":["Gamla Värket","Hemsökt Hotell","Hemsökta Hotell","Norge"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-982","name":"Nidarosdomen","slug":"nidarosdomen","url":"https://www.spokkartan.se/spokplatser-i-norge/nidarosdomen/","lat":60.0076,"lng":9.533,"country":"Norge","region":"Norge","type":"Kyrka","scary":3,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Nidarosdomen","teaser":"Den spökande munken i Domen Nidarosdomen i Trondheim är inte bara en historisk byggnad. Där är också en plats där det övernaturliga sägs ha lämnat sina spår. Med sin imponerande gotiska arki","description":"Den spökande munken i Domen Nidarosdomen i Trondheim är inte bara en historisk byggnad. Där är också en plats där det övernaturliga sägs ha lämnat sina spår. Med sin imponerande gotiska arkitektur, byggd över kung Olav den heliges grav, har denna katedral varit ett centrum för både kristendom och mystik sedan 1000-talet. Men det är inte bara historiska händelser som fångat människors uppmärksamhet. Katedralen sägs även vara hem för en särskild vålnad: Munken i Nidarosdomen. En blodig skepnad i Kapittelhuset En av de mest kända berättelserna om munken kommer från januari 1924. Under en gudstjänst hävdade biskopinnan Marie Gleditsch att hon såg en mystisk figur i Kapittelhuset, även känt som S","img":"https://www.spokkartan.se/wp-content/uploads/2024/11/Nidarosdomen-1.jpg","date":"Wed, 27 Nov","points":60,"categories":["Hemsökt Kyrka","hemsökt kyrka","Munken i nidarås","Nidarås"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-986","name":"Vang Prestegård","slug":"vang-prestegard","url":"https://www.spokkartan.se/spokplatser-i-norge/vang-prestegard/","lat":61.0722,"lng":8.0252,"country":"Norge","region":"Norge","type":"Prästgård","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Vang+Prestegård","teaser":"Vang Prestegård Ridarbu – Ett historiskt hem med övernaturliga spår Denna gamla prästgård är inte bara en plats med kulturellt och historiskt värde, utan har också blivit föremål för rykten","description":"Vang Prestegård Ridarbu – Ett historiskt hem med övernaturliga spår Denna gamla prästgård är inte bara en plats med kulturellt och historiskt värde, utan har också blivit föremål för rykten om övernaturliga händelser som lockar både skeptiker och de som söker det mystiska. Historisk bakgrund Vang prestegård byggdes 1780 på grunder som tros härstamma från 1200-talet. Dessa murar kan ha tillhört en äldre kyrka, och det spekuleras i att de användes som fängelse under inkvisitionen, där människor mötte tragiska öden genom svält. En av de mest framstående invånarna var soknepräst Abraham Pihl, som residerade på gården mellan 1789 och 1821. Pihl var en man med många talanger – urmakare, astronom o","img":"https://www.spokkartan.se/wp-content/uploads/2024/11/2-10.jpg","date":"Tue, 26 Nov","points":80,"categories":["Hemsökt prästgård","Hemsökt Prästgård","Ridabu","Spökelser"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-997","name":"Övralid","slug":"ovralid","url":"https://www.spokkartan.se/ostergotlands-lan/ovralid/","lat":58.6587,"lng":15.3695,"country":"Sverige","region":"Östergötlands Län","type":"Herrgård","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Övralid","teaser":"Finns Heidenstams ande kvar i herrgården? I Västra Ny socken, på en höjd med utsikt över Vättern, står Övralid. Byggd mellan 1923 och 1925 av den svenske nobelpristagaren Verner von Heidenst","description":"Finns Heidenstams ande kvar i herrgården? I Västra Ny socken, på en höjd med utsikt över Vättern, står Övralid. Byggd mellan 1923 och 1925 av den svenske nobelpristagaren Verner von Heidenstam, var Övralid hans hem fram till hans död 1940. Platsen är inte bara vacker, den sägs även vara hemsökt. Kanske är det Heidenstam själv som spökar i sin gamla boning. Barnskrik från vinden En av de mest ihållande och kusliga berättelserna från Övralid handlar om ljuden från vinden. Besökare och personal har vid flera tillfällen hört tydliga ljud av barnskrik som verkar komma från den högsta våningen. Vinden, som i sig är ett kallt och ensligt utrymme, är annars tyst och tom, men vissa menar att skriket ","img":"https://www.spokkartan.se/wp-content/uploads/2024/11/4-11.jpg","date":"Mon, 25 Nov","points":80,"categories":["farfars stugan","Heidenstam","hemsökt herrgård","Hemsökta Herrgårdar"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1034","name":"Gula Faran i Skebäcken, Örebro – ett hyreshus med ouppklarade hemligheter","slug":"gula-faran","url":"https://www.spokkartan.se/orebro-lan/gula-faran/","lat":59.9333,"lng":15.1112,"country":"Sverige","region":"Örebro Län","type":"Spökhus","scary":5,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Gula+Faran+i+Skebäcken,+Örebro+–+ett+hyreshus+med+ouppklarade+hemligheter","teaser":"I stadsdelen Skebäcken i Örebro står ett hyreshus som lokalbefolkningen kallar Gula Faran. Namnet kanske låter oskyldigt, men berättelserna kring huset målar upp en helt annan bild. Här har","description":"I stadsdelen Skebäcken i Örebro står ett hyreshus som lokalbefolkningen kallar Gula Faran. Namnet kanske låter oskyldigt, men berättelserna kring huset målar upp en helt annan bild. Här har flera rapporterat om mystiska händelser som skrämt bort såväl fastighetsägare som renoveringsplaner – och duschrum som aldrig blev färdiga. Vindsvåningen Från 1920-talet – Orörd men Orolig En av de mest fascinerande detaljerna med Gula Faran är att vindsvåningen står orörd sedan 1920-talet. Möbler, kök och tapeter är märkligt välbevarade, som om tiden stannat. Men det är inte bara den historiska charmen som drar uppmärksamhet – det är också platsen för de mest skrämmande berättelserna. Spana in de senaste","img":"https://www.spokkartan.se/wp-content/uploads/2024/11/Spok-memes-13.jpg","date":"Fri, 29 Nov","points":100,"categories":["Gula Faran","hemsökt hyreshus","Örebro","Örebro Län"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1043","name":"Schillers Krog i Alingsås","slug":"schillers-krog","url":"https://www.spokkartan.se/spokhus/schillers-krog/","lat":57.3438,"lng":12.3319,"country":"Sverige","region":"Västra Götalands Län","type":"Spökhus","scary":5,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Schillers+Krog+i+Alingsås","teaser":"Hemsökelser i Alingsås På en till synes vanlig restaurang i hjärtat av Alingsås, Schillers Krog, har det genom åren rapporterats om flera märkliga och oförklarliga händelser. Personal och be","description":"Hemsökelser i Alingsås På en till synes vanlig restaurang i hjärtat av Alingsås, Schillers Krog, har det genom åren rapporterats om flera märkliga och oförklarliga händelser. Personal och besökare vittnar om skepnader i ögonvrån, glas som flyttar sig och en tryckande känsla som ibland sveper genom lokalerna. Det är tillräckligt för att få många att undra – vad är det egentligen som pågår här? Obehagliga Upplevelser i Kassan En av de mest omskakande berättelserna kommer från restaurangens ägare, Marcus Schiller. Han har själv upplevt oförklarliga fenomen som lämnat honom förbryllad. \"Jag stod vid kassan och såg plötsligt någon gå förbi i mörka kläder,\" berättar han. Först trodde han att det v","img":"https://www.spokkartan.se/wp-content/uploads/2024/11/Krusberga-2.jpg","date":"Fri, 29 Nov","points":100,"categories":["Alingsås","Schillers Krog","spöken","Spökhus"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1057","name":"Katthamra Gård – Häxans Hus i Katthammarsvik","slug":"katthamra-gard","url":"https://www.spokkartan.se/gotlands-lan/katthamra-gard/","lat":57.7382,"lng":17.7206,"country":"Sverige","region":"Gotlands Län","type":"Herrgård","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Katthamra+Gård+–+Häxans+Hus+i+Katthammarsvik","teaser":"På Gotlands östra kust, i Katthammarsvik, ligger Katthamra gård, en historisk herrgård med anor från 1600-talet. Men förutom sin historiska betydelse bär gården på en mörk berättelse som sat","description":"På Gotlands östra kust, i Katthammarsvik, ligger Katthamra gård, en historisk herrgård med anor från 1600-talet. Men förutom sin historiska betydelse bär gården på en mörk berättelse som satt sitt prägel på platsen. Det sägs nämligen att gården hemsöks av en kvinna som avrättades för häxeri i slutet av 1600-talet. Häxan Drake och Avrättningen 1697 Enligt lokal tradition bodde en kvinna vid namn Drake vid Katthamra gård i slutet av 1600-talet. Hon anklagades för häxeri, en allvarlig anklagelse under den tid då häxprocesserna ännu spred skräck i Sverige. Bland de påstådda brott hon anklagades för nämns svartkonst, att ha ätit barn och haft en förbjuden pakt med Djävulen. År 1697 dömdes Drake t","img":"https://www.spokkartan.se/wp-content/uploads/2024/11/Krusberga-3.jpg","date":"Sat, 30 Nov","points":80,"categories":["Gotlands Län","häxeri","Hemsökta Herrgårdar","Katthamarsvik"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1062","name":"Sollerö Gravfält","slug":"sollero-gravfalt-vikingatida-gravplats-och-kusliga-berattelser","url":"https://www.spokkartan.se/dalarnas-lan/sollero-gravfalt-vikingatida-gravplats-och-kusliga-berattelser/","lat":60.7353,"lng":16.5848,"country":"Sverige","region":"Dalarnas Län","type":"Kyrka","scary":3,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Sollerö+Gravfält","teaser":"Vikingatida gravplats och kusliga berättelser På Sollerön i Dalarna ligger ett av regionens mest betydelsefulla historiska områden – Sollerö gravfält. Det är Dalarnas största gravfält från v","description":"Vikingatida gravplats och kusliga berättelser På Sollerön i Dalarna ligger ett av regionens mest betydelsefulla historiska områden – Sollerö gravfält. Det är Dalarnas största gravfält från vikingatiden, med uppskattningsvis 120–150 gravar som sträcker sig tillbaka till perioden 950–1050 e.Kr. Förutom sin historiska betydelse har gravfältet även blivit känt för de sägner och spökhistorier som omger platsen. Vikingagravar och Arkeologiska Fynd Gravfältet består av utspridda rösen, stensättningar och högar som tydligt speglar vikingatidens begravningsseder. Gravarna är så kallade brandgravar , där de döda först kremerades innan deras kvarlevor lades till vila tillsammans med personliga ägodelar","img":"https://www.spokkartan.se/wp-content/uploads/2024/11/Haxa-1.jpg","date":"Sat, 30 Nov","points":60,"categories":["Dalarnas Län","gravfält","hemsökt","Kyrkogårdar"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1069","name":"Hällnäs Sanatorium, historia och spöken mitt ute i skogen","slug":"hallnas-sanatorium","url":"https://www.spokkartan.se/vasterbottens-lan/hallnas-sanatorium/","lat":63.939,"lng":19.5864,"country":"Sverige","region":"Västerbottens Län","type":"Sanatorium","scary":5,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Hällnäs+Sanatorium,+historia+och+spöken+mitt+ute+i+skogen","teaser":"Vilsna själar och mystiska händelser Det sägs att de döda aldrig riktigt lämnat Hällnäs sanatorium. Byggt för att behandla tuberkulospatienter på 1920-talet, blev platsen för många en slutst","description":"Vilsna själar och mystiska händelser Det sägs att de döda aldrig riktigt lämnat Hällnäs sanatorium. Byggt för att behandla tuberkulospatienter på 1920-talet, blev platsen för många en slutstation. Idag är det inte bara sanatoriets storslagna arkitektur och tragiska historia som lockar besökare – utan även de märkliga fenomen som rapporterats genom åren. Gravkapellet Intill sanatoriet ligger ett litet gravkapell, en plats där avsked och begravningar hölls under sanatoriets aktiva år. Många vittnar om en särskilt kuslig stämning här. Besökare har hört dämpade röster och sett skuggor röra sig längs väggarna, trots att kapellet stått tomt. En del beskriver en känsla av att vara iakttagen, som om","img":"https://www.spokkartan.se/wp-content/uploads/2024/12/Blue-Modern-Professional-LinkedIn-Banner.jpg","date":"Sun, 01 Dec","points":100,"categories":["Hällnäs Sanatorium","hemsökt sanatorium","Sanatorium","Sanatorium"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1076","name":"Garpenbergs Slott och slottsfrun som vägrar lämna","slug":"garpenbergs-slott","url":"https://www.spokkartan.se/dalarnas-lan/garpenbergs-slott/","lat":61.3961,"lng":15.6529,"country":"Sverige","region":"Dalarnas Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Garpenbergs+Slott+och+slottsfrun+som+vägrar+lämna","teaser":"När man kliver in på Garpenbergs Slott i hjärtat av Dalarna är det svårt att inte känna historiens vingslag. Slottet, med anor från 1500-talet, är omgivet av mystik, minnen och – om man våga","description":"När man kliver in på Garpenbergs Slott i hjärtat av Dalarna är det svårt att inte känna historiens vingslag. Slottet, med anor från 1500-talet, är omgivet av mystik, minnen och – om man vågar tro berättelserna – ett och annat spöke. Här samsas storslagna salar och imponerande botaniska trädgårdar. Och en spöklik atmosfär som lockar både historieälskare och äventyrslystna. Teaser från när våra vänner från Spökjakt Sverige och OKÄNT spökjakt på Garpenbergs Slott https://youtu.be/vlg7ZSqJgyk?si=zyHmqaHYV4l7wUgU Spökerier på slottet Det sägs att Garpenbergs Slott är fyllt av andar – från både människor och djur. Mest känd är den gamla slottsfrun Christina, som enligt legenden inte riktigt har sl","img":"https://www.spokkartan.se/wp-content/uploads/2024/12/Garpenbergs-Slott.jpg","date":"Tue, 03 Dec","points":80,"categories":["Dalarnas Län","Garpenbergs slott","hemsökt","Hemsökt Slott"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1096","name":"Järvsö Prästgård","slug":"jarvso-prastgard","url":"https://www.spokkartan.se/gavleborgs-lan/jarvso-prastgard/","lat":60.6455,"lng":15.4131,"country":"Sverige","region":"Gävleborgs Län","type":"Prästgård","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Järvsö+Prästgård","teaser":"En hemsökt prästgård där skuggorna lever kvar I hjärtat av Hälsingland ligger Järvsö Prästgård, en plats fylld av historia – och kanske något mer. Här, i den gamla prästgården som stått orör","description":"En hemsökt prästgård där skuggorna lever kvar I hjärtat av Hälsingland ligger Järvsö Prästgård, en plats fylld av historia – och kanske något mer. Här, i den gamla prästgården som stått orörd sedan 1870-talet, har många generationer passerat. Men inte alla verkar ha lämnat helt. Bland kakelugnar från 1700-talet, vackra trädetaljer och runstenar från vikingatiden sägs prostinnan Elsa Margaret Agrell fortfarande vandra. Spöklika steg uppför trappan Prostinnan Elsa Margaret Agrell, som gick bort 1845, sägs visa sig i prästgården än idag. Besökare och personal har hört ljudet av mjuka steg som rör sig uppför den gamla trappan. Målet? Rummet där hennes tio barn en gång bodde. Tänk dig att stå i d","img":"https://www.spokkartan.se/wp-content/uploads/2024/12/Garpenbergs-Slott-3.jpg","date":"Wed, 04 Dec","points":80,"categories":["Gävleborgs Län","Hemsökt Prästgård","Hemsökt prästgård","Järvsö"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1103","name":"Baggböle Herrgård","slug":"baggbole-herrgard","url":"https://www.spokkartan.se/vasterbottens-lan/baggbole-herrgard/","lat":63.4754,"lng":20.5659,"country":"Sverige","region":"Västerbottens Län","type":"Herrgård","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Baggböle+Herrgård","teaser":"Baggböle Herrgård står som en vit juvel på älvskanten, med sina röda fönsterkarmar och pampiga empirestil. Men bakom den historiska fasaden och de storslagna salarna viskas det om något anna","description":"Baggböle Herrgård står som en vit juvel på älvskanten, med sina röda fönsterkarmar och pampiga empirestil. Men bakom den historiska fasaden och de storslagna salarna viskas det om något annat – något som får besökare att rysa. Det sägs nämligen att det spökar här. Här hittar du fler hemsökta herrgårdar! Överalid Industrins hjärta under 1800-talet Herrgården, byggd 1844, var en gång centrum för den västerbottniska träindustrin. Under 1800-talet blomstrade sågverksverksamheten i Baggböle under James Dickson &amp; Co:s ledning. Med sin storskaliga avverkning och flottning förändrade de inte bara Umeåtrakten utan hela norra Sverige. Även idag står herrgården kvar som en påminnelse om denna indus","img":"https://www.spokkartan.se/wp-content/uploads/2024/12/Garpenbergs-Slott-5.jpg","date":"Tue, 10 Dec","points":80,"categories":["Baggböle","hemsökt","Hemsökta Herrgårdar","Umeå"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1105","name":"Kastlösa Prästgård – Ett Ökänt Spökhus på Öland","slug":"kastlosa-prastgard","url":"https://www.spokkartan.se/kalmar-lan/kastlosa-prastgard/","lat":57.1273,"lng":16.1732,"country":"Sverige","region":"Kalmar Län","type":"Prästgård","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Kastlösa+Prästgård+–+Ett+Ökänt+Spökhus+på+Öland","teaser":"Djupt på södra Öland ligger Kastlösa prästgård, en till synes fridfull plats, men med en mörk historia som lockar besökare från hela Sverige. Här är det inte ovanligt att man hör berättelser","description":"Djupt på södra Öland ligger Kastlösa prästgård, en till synes fridfull plats, men med en mörk historia som lockar besökare från hela Sverige. Här är det inte ovanligt att man hör berättelser om knackningar, fotsteg och dörrar som öppnas och stängs av sig själva. För de modiga är detta en plats där spökerierna känns nästan lika verkliga som vinden som sveper över Ölands öppna landskap. Vad händer i Kastlösa Prästgård? Det sägs att oförklarliga fenomen är vanliga här, särskilt under tisdagar och fredagar. Mystiska bultningar och rytmiska dunkningar i dörrar, väggar och fönster får besökare att rygga tillbaka. En återkommande händelse är att snöbollar kastas mot prästgårdens fönster – trots att","img":"https://www.spokkartan.se/wp-content/uploads/2024/12/Skarmavbild-2024-12-10-kl.-08.51.15.png","date":"Tue, 10 Dec","points":80,"categories":["Hemsökt Öland","Hemsökt Prästgård","Kalmar Län","Kastlösa Prästgård"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1108","name":"Österbybruks Herrgård","slug":"osterbybruks-herrgard","url":"https://www.spokkartan.se/hemsokta-herrgardar/osterbybruks-herrgard/","lat":59.1616,"lng":17.3559,"country":"Sverige","region":"Uppsala Län","type":"Herrgård","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Österbybruks+Herrgård","teaser":"Vita damen och spökena på Österbybruks Herrgård Det sägs att vissa platser aldrig riktigt släpper taget om sina invånare. Österbybruks Herrgård är en sådan plats. Med sin rika historia och s","description":"Vita damen och spökena på Österbybruks Herrgård Det sägs att vissa platser aldrig riktigt släpper taget om sina invånare. Österbybruks Herrgård är en sådan plats. Med sin rika historia och sina hemsökande berättelser är det en självklar destination för den som vill uppleva en plats utöver det vanliga. Tänk att helt plötsligt höra toner från Jenny Lind, helt från tomma intet. Eller möta den Vita Damen vid Korsdammen? Besökare har upplevt skepnader som sveper genom de gamla rummen. Här vibrerar väggarna av energi från det förflutna, och varje skrymsle har sin egen berättelse att dela. Gammel Tammen, En ande i ständig rörelse Pehr Adolf Tamm, eller \"Gammel Tammen\" som han kallades, är en centra","img":"https://www.spokkartan.se/wp-content/uploads/2024/12/3-1.jpg","date":"Mon, 09 Dec","points":80,"categories":["Gammelnådan","Gammeltammen","Hemsökta Herrgårdar","Jenny lInd"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1150","name":"Vadstena Slott","slug":"vadstena-slott","url":"https://www.spokkartan.se/hemsokta-slott/vadstena-slott/","lat":59.2038,"lng":15.6899,"country":"Sverige","region":"Östergötlands Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Vadstena+Slott","teaser":"Historia och mystik vid Vätterns strand Vid kanten av Vättern i den lilla staden Vadstena reser sig Vadstena slott – en byggnad som rymmer över 500 år av svensk historia. Slottet, ursprungli","description":"Historia och mystik vid Vätterns strand Vid kanten av Vättern i den lilla staden Vadstena reser sig Vadstena slott – en byggnad som rymmer över 500 år av svensk historia. Slottet, ursprungligen byggt som en del av Gustav Vasas försvarsstrategi på 1500-talet, är idag en välbevarad renässansborg som lockar besökare med sin historiska betydelse och berättelser om det övernaturliga. Från försvarsverk till furstebostad Vadstena slott började byggas 1545, mitt under en tid präglad av oroligheter och maktspel. Gustav Vasa ville stärka rikets försvar och skydda Stockholm mot attacker från danska och småländska styrkor. Platsen valdes noga – sandiga marker omgivna av vatten skapade naturliga hinder f","img":"https://www.spokkartan.se/wp-content/uploads/2024/12/Vadstena-Slott.jpg","date":"Fri, 13 Dec","points":80,"categories":["Hemsökta Slott","Östergötlands Län","Prins Magnus","Vadstena"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1153","name":"Örebro slott","slug":"orebro-slott","url":"https://www.spokkartan.se/orebro-lan/orebro-slott/","lat":60.0237,"lng":16.0759,"country":"Sverige","region":"Örebro Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Örebro+slott","teaser":"Mitt i Örebro, på en liten holme omgiven av Svartåns vatten, står Örebro slott. Den mäktiga byggnaden har anor från 1300-talet och är ett levande museum över svensk historia. Men det är inte","description":"Mitt i Örebro, på en liten holme omgiven av Svartåns vatten, står Örebro slott. Den mäktiga byggnaden har anor från 1300-talet och är ett levande museum över svensk historia. Men det är inte bara riksdagar, kungliga besök och viktiga ombyggnader som satt sina spår här. Slottet är också känt som en plats där det övernaturliga sägs ha en särskild närvaro. Genom seklerna har Örebro slott varit både försvarsverk och bostad, fängelse och residens. Dess många skepnader har lämnat efter sig ett rikt kulturarv – och en rad spökhistorier som lockar både skeptiker och troende. Här följer en djupdykning i slottets historia, dess mest intressanta händelser och de berättelser om spökerier som fascinerar ","img":"https://www.spokkartan.se/wp-content/uploads/2024/12/Orebro-Slott.jpg","date":"Fri, 13 Dec","points":80,"categories":["Engelbrekt","Grå kvinnan","Harald Pletting","Hemsökta Slott"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1162","name":"Falks grav - en av Sveriges mest mytomspunna avrättningsplats","slug":"falks-grav","url":"https://www.spokkartan.se/vastra-gotalands-lan/falks-grav/","lat":56.9384,"lng":13.4697,"country":"Sverige","region":"Västra Götalands Län","type":"Kyrka","scary":3,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Falks+grav+-+en+av+Sveriges+mest+mytomspunna+avrättningsplats","teaser":"I den ödsliga tallskogen på Hökensås, i Habo kommun i Västergötland, ligger en plats som har fängslat och skrämt generationer av besökare. På Svedmon markerar ett enkelt järnkors med inskrip","description":"I den ödsliga tallskogen på Hökensås, i Habo kommun i Västergötland, ligger en plats som har fängslat och skrämt generationer av besökare. På Svedmon markerar ett enkelt järnkors med inskriptionen \"FALK – 1855\" platsen där postrånaren Jonas Falk sägs ha blivit begravd efter att ha avrättats för rånmord. Men är detta hans verkliga grav, eller bara avrättningsplatsen? Historien är fylld av motsägelser, rykten och spökhistorier som fortsätter att fascinera. Hur allt började Jonas Falk föddes 1828 i ett fattigt soldattorp i Habo socken. Efter ett liv fyllt av småbrott och misslyckade försök att skapa sig en bättre tillvaro, lade han tillsammans med sin styvfar Anders Frid upp en plan för att rån","img":"https://www.spokkartan.se/wp-content/uploads/2024/12/Namnlos-design-37.jpg","date":"Sun, 15 Dec","points":60,"categories":["avrättning","Avrättningsplats","falkens grav","Falks Grav"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1170","name":"Svarta och Vita frun på Charlottenborgs slott","slug":"charlottenborgs-slott","url":"https://www.spokkartan.se/hemsokta-slott/charlottenborgs-slott/","lat":58.7007,"lng":15.7087,"country":"Sverige","region":"Östergötlands Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Svarta+och+Vita+frun+på+Charlottenborgs+slott","teaser":"Vid strandkanten av Motala ström reser sig Charlottenborgs slott, en byggnad vars stenfasader bär spår av århundraden av liv, död och outtalade hemligheter. Uppfört 1662 av greven Ludvig Wie","description":"Vid strandkanten av Motala ström reser sig Charlottenborgs slott, en byggnad vars stenfasader bär spår av århundraden av liv, död och outtalade hemligheter. Uppfört 1662 av greven Ludvig Wierich Lewenhaupt och uppkallat efter hans hustru Charlotte Susanne Marie von Hohenlohe, är slottet i dag mer än en arkitektonisk skatt. Det är en plats där det övernaturliga och det historiska möts, där berättelser om spöken, mystiska händelser och dolda skatter förvandlar varje besök till en resa in i det okända. Vita frun – Grevinnan som vägrar att lämna sitt hem Charlottenborgs mest kända invånare är inte av denna värld. Vita frun sägs vara andan av Charlotte Susanne Marie själv, vars död 1666 lämnade h","img":"https://www.spokkartan.se/wp-content/uploads/2024/12/Namnlos-design-38.jpg","date":"Tue, 17 Dec","points":80,"categories":["Charlottenborgs slott","Hemsökt Slott","Hemsökta Slott","Motala"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1172","name":"Börringekloster Slott","slug":"borringekloster-slott","url":"https://www.spokkartan.se/hemsokta-slott/borringekloster-slott/","lat":55.4669,"lng":13.8283,"country":"Sverige","region":"Skåne Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Börringekloster+Slott","teaser":"Börringekloster i Skåne är en plats som bär på århundraden av historia, från sin tid som benediktinerkloster på 1200-talet till sitt nuvarande skick som slott från 1700-talet. Men r Börringe","description":"Börringekloster i Skåne är en plats som bär på århundraden av historia, från sin tid som benediktinerkloster på 1200-talet till sitt nuvarande skick som slott från 1700-talet. Men r Börringekloster också känt som en plats där det övernaturliga verkar göra sig påmint. Det sägs att ingen mindre än Carl Hårleman, en av Sveriges mest berömda arkitekter och den som ansvarade för den nuvarande slottsbyggnadens utformning, fortfarande vandrar genom slottets korridorer. Men Hårleman är inte bara en passiv närvaro – han låter besökarna veta att han är där. Hitta fler hemsökta slott på vår \"Hemsökta slott - sida\" Klicka här! Gunnebo Slott Varnande kedjor och kalla pustar Berättelserna om Hårlemans spö","img":"https://www.spokkartan.se/wp-content/uploads/2024/12/Borringekloster-Slott-1.jpg","date":"Wed, 18 Dec","points":80,"categories":["Börringekloster","hemsökt i skåne","hemsökta platser","Hemsökta slot"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1175","name":"Spöken på det nedlagda äldreboendet i Hammarstrand","slug":"aldreboendet-i-hammarstrand","url":"https://www.spokkartan.se/jamtlands-lan/aldreboendet-i-hammarstrand/","lat":62.5485,"lng":14.5034,"country":"Sverige","region":"Jämtlands Län","type":"Spökhus","scary":5,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Spöken+på+det+nedlagda+äldreboendet+i+Hammarstrand","teaser":"I den lilla orten Hammarstrand finns ett nedlagt äldreboende som länge varit föremål för rykten och historier om övernaturliga händelser. Det är en plats som för många invånare förknippas me","description":"I den lilla orten Hammarstrand finns ett nedlagt äldreboende som länge varit föremål för rykten och historier om övernaturliga händelser. Det är en plats som för många invånare förknippas med kalla kårar och oförklarliga upplevelser. En av de mest omtalade historierna handlar om en mystisk gumma som sägs visa sig för både personal och boende. En gumma vid fönstret – vittnesmål från personal och boende En före detta anställd på boendet, en kvinna i 70-årsåldern, berättar att stämningen på platsen kunde vara obehaglig, särskilt nattetid. Även om hon själv aldrig såg något märkligt, upplevde hennes släkting – som också arbetade där – en kväll något oförklarligt. \"Det fanns ett särskilt rum, ett","img":"https://www.spokkartan.se/wp-content/uploads/2025/09/Hammarstrand-aldreboende.png","date":"Thu, 11 Sep","points":100,"categories":["Hammarstrand","Jämtlands Län","Spökhus"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1177","name":"Ovikens kyrkas spöken och en mörk händelse från 1800-talet","slug":"ovikens-kyrka","url":"https://www.spokkartan.se/jamtlands-lan/ovikens-kyrka/","lat":63.096,"lng":15.7492,"country":"Sverige","region":"Jämtlands Län","type":"Kyrka","scary":3,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Ovikens+kyrkas+spöken+och+en+mörk+händelse+från+1800-talet","teaser":"Ovikens gamla kyrka är en historisk plats med djupa rötter i Jämtlands andliga och kulturella historia. Men bland de gamla murarna och gravarna lever inte bara kyrkans dokumenterade historia","description":"Ovikens gamla kyrka är en historisk plats med djupa rötter i Jämtlands andliga och kulturella historia. Men bland de gamla murarna och gravarna lever inte bara kyrkans dokumenterade historia – även berättelser om det övernaturliga gör platsen till något mer än en sevärdhet. En särskild historia från 1890-talet sticker ut, med en man som sägs ha burit ett barnlik till kyrkans bårhus. Den mystiska mannen med barnet En kvinna, då 75 år gammal, berättade 1955 om en händelse hon upplevt som läsbarn på 1890-talet. Hon och andra barn såg en gammal man med långt vitt skägg, svart hatt och lång överrock komma gående mot kyrkan. Under armen bar han något som vid närmare anblick visade sig vara ett ins","img":"https://www.spokkartan.se/wp-content/uploads/2024/12/Ovikens-Gamla-Kyrka.jpg","date":"Wed, 18 Dec","points":60,"categories":["Hemsökt Kyrka","hemsökt kyrka","Jämtlands Län","Oviken"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1190","name":"Pintorpafrun på Ericsbergs Slott","slug":"ericsbergs-slott","url":"https://www.spokkartan.se/hemsokta-slott/ericsbergs-slott/","lat":59.8014,"lng":15.9421,"country":"Sverige","region":"Södermanlands Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Pintorpafrun+på+Ericsbergs+Slott","teaser":"I hjärtat av Södermanland, nära Katrineholm, ligger det historiska Ericsbergs slott. Byggnaden har stått här sedan 1600-talet och är känd för sin imponerande arkitektur, men framför allt för","description":"I hjärtat av Södermanland, nära Katrineholm, ligger det historiska Ericsbergs slott. Byggnaden har stått här sedan 1600-talet och är känd för sin imponerande arkitektur, men framför allt för en skrämmande legend – berättelsen om Pintorpafrun. Hon sägs fortfarande hemsöka platsen och har blivit en av Sveriges mest välkända spökhistorier. ericsbergs slott Historien bakom Pintorpafrun Legenden om Pintorpafrun kretsar kring Beata von Yxkull, en slottsfru som enligt sägnen styrde godset med järnhand. Hennes rykte som en hård och orättvis arbetsgivare har levt vidare genom århundraden. Hon ska ha drivit både tjänstefolk och torpare till bristningsgränsen, och berättelser om hennes grymhet har förs","img":"https://www.spokkartan.se/wp-content/uploads/2024/12/1-1.jpg","date":"Mon, 30 Dec","points":80,"categories":["ericsbergs slott","hemsökta platser","hemsökta slott","Hemsökta Slott"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1196","name":"Hudiksvalls kyrka","slug":"hudiksvalls-kyrka","url":"https://www.spokkartan.se/gavleborgs-lan/hudiksvalls-kyrka/","lat":61.3009,"lng":15.7288,"country":"Sverige","region":"Gävleborgs Län","type":"Kyrka","scary":3,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Hudiksvalls+kyrka","teaser":"Hudiksvalls kyrka, även känd som Jakobs kyrka, är inte bara Hudiksvalls äldsta byggnad utan också en av stadens mest fascinerande platser. Dess historia sträcker sig tillbaka till 1643, och","description":"Hudiksvalls kyrka, även känd som Jakobs kyrka, är inte bara Hudiksvalls äldsta byggnad utan också en av stadens mest fascinerande platser. Dess historia sträcker sig tillbaka till 1643, och kyrkan invigdes 1672 efter nära tre decenniers byggnation. Men det är inte bara historiska händelser, som kanonkulan från 1721 års ryska härjningar, som gör kyrkan intressant – det är också de mystiska och oförklarliga berättelserna som omger den. Spöklika orgeltoner i natten En av de mest kända sägnerna kring Hudiksvalls kyrka handlar om orgelmusik som sägs höras från kyrkan när natten är som mörkast. Vittnen har berättat om toner som ekar genom den tomma och låsta byggnaden, trots att ingen befinner sig","img":"https://www.spokkartan.se/wp-content/uploads/2025/01/Hudiksvalls-Kyrka.jpg","date":"Sat, 04 Jan","points":60,"categories":["Gävleborgs Län","hemsökt","Hemsökt Kyrka","hemsökt kyrka"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1209","name":"Gripsholms slott","slug":"gripsholms-slott","url":"https://www.spokkartan.se/sodermanlands-lan/gripsholms-slott/","lat":59.8602,"lng":17.3992,"country":"Sverige","region":"Södermanlands Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Gripsholms+slott","teaser":"På Gripsholms slott sägs det att dörrhandtag rör sig av sig själva, och vissa har påstått sig möta vålnaden av drottning Kristina av Holstein-Gottorp i de gamla salarna. I slottsteatern kan","description":"På Gripsholms slott sägs det att dörrhandtag rör sig av sig själva, och vissa har påstått sig möta vålnaden av drottning Kristina av Holstein-Gottorp i de gamla salarna. I slottsteatern kan man höra klockor ringa. Trots att några sådana inte längre finns där. Är det bara historier, eller finns det något mer bakom slottets tjocka murar? Gripsholm, beläget vid Mälarens vatten i Mariefred, är en plats där historia och mystik flätas samman. Byggt av Gustav Vasa på 1500-talet står det som en symbol för både makt och kulturarv, men det är de spöklika berättelserna som ofta lämnar de starkaste intrycken. Historisk prakt med kungliga inslag Gripsholms slott har en lång och dramatisk historia. Bygget","img":"https://www.spokkartan.se/wp-content/uploads/2025/01/Gripsholms-Slott.jpg","date":"Sat, 04 Jan","points":80,"categories":["Erik XIV","Gripsholm","Gustav IV","Gustav Vasa"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1211","name":"George Seatons jaktslott och dess hemsökta ruiner","slug":"seatons-jaktslott","url":"https://www.spokkartan.se/vastra-gotalands-lan/seatons-jaktslott/","lat":57.3975,"lng":13.2735,"country":"Sverige","region":"Västra Götalands Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=George+Seatons+jaktslott+och+dess+hemsökta+ruiner","teaser":"På Hyltenäs kulle i Marks kommun står ruinerna av George Seatons jaktslott. En gång ett av Sveriges mest extravaganta privatbyggen, nu en plats för både historisk fascination och övernaturli","description":"På Hyltenäs kulle i Marks kommun står ruinerna av George Seatons jaktslott. En gång ett av Sveriges mest extravaganta privatbyggen, nu en plats för både historisk fascination och övernaturliga berättelser. Besökare som vandrar bland resterna av detta storslagna byggnadsverk vittnar ofta om en märklig närvaro, som om George Seaton och hans familj aldrig riktigt lämnat platsen. Är det bara inbillning, eller döljer ruinerna mer än vad som möter ögat? Drömmen om ett jaktslott George Seaton, en förmögen grosshandlare från Göteborg, förälskade sig i det dramatiska landskapet kring Hyltenäs kulle. Här, högt ovanför Öresjöns klara vatten, såg han sin vision förverkligas: ett jaktslott som skulle öve","img":"https://www.spokkartan.se/wp-content/uploads/2025/01/George-Seatons-Jaktslott.jpg","date":"Sat, 04 Jan","points":80,"categories":["george seaton","Hemsökt Göteborg","Hemsökt Slott","Hemsökta platser i Göteborg"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1213","name":"Länscellfängelset i Gävle","slug":"lanscellfangelset-i-gavle","url":"https://www.spokkartan.se/gavleborgs-lan/lanscellfangelset-i-gavle/","lat":61.4744,"lng":15.6668,"country":"Sverige","region":"Gävleborgs Län","type":"Fängelse","scary":5,"free":true,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Länscellfängelset+i+Gävle","teaser":"Gamla fängelset i Gävle, en gång en av Sveriges mest moderna anstalter, bär på en mörk och dramatisk historia . Och kanske något mer. Besökare och personal vid det som nu är Sveriges Fängels","description":"Gamla fängelset i Gävle, en gång en av Sveriges mest moderna anstalter, bär på en mörk och dramatisk historia . Och kanske något mer. Besökare och personal vid det som nu är Sveriges Fängelsemuseum har rapporterat om märkliga fenomen: skuggor som sveper förbi, tavlor som faller utan anledning, och känslan av att inte vara ensam. Vissa vittnar till och med om att ha blivit knuffade av osynliga krafter. Är det andarna från de många fångar som satt här, eller något annat som hemsöker platsen? Ett fängelse byggt för isolering Länscellfängelset i Gävle öppnade 1847 som en del av en nationell reform för att modernisera fängelseväsendet. Byggnaden, ritad av arkitekten Carl Fredrik Hjelm, var bland ","img":"https://www.spokkartan.se/wp-content/uploads/2025/01/Lanscellsfangelset-i-Gavle.jpg","date":"Sat, 04 Jan","points":100,"categories":["gamla fängelset gävle","Gävle","Gävleborgs Län","Hemsökt Fängelse"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1220","name":"Villa Överås","slug":"villa-overas","url":"https://www.spokkartan.se/hemsokta-herrgardar/villa-overas/","lat":58.14,"lng":13.0345,"country":"Sverige","region":"Västra Götalands Län","type":"Herrgård","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Villa+Överås","teaser":"Villa Överås, belägen vid Danska vägen i Göteborgs stadsdel Bö, är en ståtlig byggnad med en lång och dramatisk historia. Uppförd 1861 av James Dickson d.y., en framstående affärsman och en","description":"Villa Överås, belägen vid Danska vägen i Göteborgs stadsdel Bö, är en ståtlig byggnad med en lång och dramatisk historia. Uppförd 1861 av James Dickson d.y., en framstående affärsman och en av Göteborgs mest inflytelserika familjer. Villan var en symbol för makt och rikedom. Men under åren har dess skönhet fått konkurrens av mörkare berättelser. Mest omtalad är \"Svarta Damen\", en kvinnlig gestalt i lång svart klänning som har setts vandra genom villan. Enligt många är huset hemsökt, och de som vistats här vittnar om märkliga upplevelser som lämnar ett bestående intryck. Klicka här för mer hemsökta platser i Västra Götaland Överklassvilla med kuslig historia James Dickson d.y. lät bygga Villa","img":"https://www.spokkartan.se/wp-content/uploads/2025/01/Villa-Overas.jpg","date":"Mon, 06 Jan","points":80,"categories":["Göteborg","hemsökt","Hemsökta Herrgårdar","Hemsökta platser i Göteborg"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1226","name":"Furunäset - Från mentalsjukhus till hemsökt hotell","slug":"furunaset","url":"https://www.spokkartan.se/hemsokta-hotell/furunaset/","lat":66.9458,"lng":22.2228,"country":"Sverige","region":"Norrbottens Län","type":"Hotell","scary":4,"free":false,"bookable":true,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Furunäset+-+Från+mentalsjukhus+till+hemsökt+hotell","teaser":"Beläget vid Piteälvens strand i norra Sverige reser sig Furunäset, en byggnad som bär på en mörk och komplex historia. Ursprungligen byggt som mentalsjukhus har denna plats blivit en av Sver","description":"Beläget vid Piteälvens strand i norra Sverige reser sig Furunäset, en byggnad som bär på en mörk och komplex historia. Ursprungligen byggt som mentalsjukhus har denna plats blivit en av Sveriges mest omtalade när det gäller övernaturliga fenomen. Idag fungerar Furunäset som hotell och företagscenter, men berättelserna om det förflutna gör att få lämnar platsen oberörda. Ett sjukhus för de \"obotliga\" Furunäsets historia börjar 1886, när staten beslutade att bygga ett mentalsjukhus med kapacitet att ta emot patienter från hela Norrland. Arkitekten Axel Kumlien, som tidigare ritat bland annat Grand Hôtel i Stockholm, fick uppdraget att skapa en modern anläggning. Med ljus arkitektur och välvda ","img":"https://www.spokkartan.se/wp-content/uploads/2025/01/Furunaset.png","date":"Mon, 06 Jan","points":80,"categories":["Furunäset","Hemsökt Hotell","Hemsökta Hotell","Hemsökta platser i Norrland"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1231","name":"Landskrona Citadell och Änglamakerskan","slug":"landskrona-citadell","url":"https://www.spokkartan.se/hemsokt-fangelse/landskrona-citadell/","lat":55.0409,"lng":13.068,"country":"Sverige","region":"Skåne Län","type":"Fängelse","scary":5,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Landskrona+Citadell+och+Änglamakerskan","teaser":"Landskrona Citadell, som ligger vid Öresund i Skåne, är en av Nordens bäst bevarade fästningar från 1500-talet. Byggnaden har varit både en försvarsborg och ett fängelse, och dess historia ä","description":"Landskrona Citadell, som ligger vid Öresund i Skåne, är en av Nordens bäst bevarade fästningar från 1500-talet. Byggnaden har varit både en försvarsborg och ett fängelse, och dess historia är fylld av både dramatik och tragik. Här möts besökare av en plats som bär på mörka hemligheter och ögonblick som fortfarande känns i väggarna. Från fästning till fängelse Citadellet byggdes 1549 av den danske kungen Christian III och var från början en försvarsanläggning med tjocka murar och djupa vallgravar. När Skåne blev svenskt efter Roskildefreden 1658 byggdes fästningen ut och blev ännu starkare. Men redan på 1700-talet började fästningen användas som fängelse. Hit fördes människor som ansågs farli","img":"https://www.spokkartan.se/wp-content/uploads/2025/01/Villa-Overas-1.jpg","date":"Tue, 07 Jan","points":100,"categories":["Änglamakerskan","Fängelsespöken","Hemsökt Fängelse","Hilda Nilsson"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1242","name":"9 av Sveriges mest hemsökta platser","slug":"9-av-sveriges-mest-hemsokta-platser","url":"https://www.spokkartan.se/hemsokt-fangelse/9-av-sveriges-mest-hemsokta-platser/","lat":59.3612,"lng":19.6698,"country":"Sverige","region":"Sverige","type":"Slott","scary":4,"free":false,"bookable":true,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=9+av+Sveriges+mest+hemsökta+platser","teaser":"Upplev Sveriges kusligaste historier! Från prästgårdar med gråtande kvinnor till mentalsjukhus där tiden tycks ha stannat – Sverige är fyllt av platser med både mörka hemligheter och rastlös","description":"Upplev Sveriges kusligaste historier! Från prästgårdar med gråtande kvinnor till mentalsjukhus där tiden tycks ha stannat – Sverige är fyllt av platser med både mörka hemligheter och rastlösa andar. Vågar du besöka Borgvattnets prästgård, Furunäsets spökhotell eller Landskrona citadell där änglamakerskan sägs hemsöka sin gamla cell? Här tar vi dig med på en resa till nio av Sveriges mest omskrivna hemsökta platser – och berättar historierna som gör dem så oförglömliga. Borgvattnets Prästgård, Jämtland Bild: Johanna Persson Borgvattnets prästgård är en av Sveriges mest kända hemsökta platser. Byggd 1876, blev den ökänd efter att prästen Erik Lindgren på 1940-talet började rapportera om oförkl","img":"https://www.spokkartan.se/wp-content/uploads/2025/01/Landskrona-Citadell-5.jpg","date":"Tue, 07 Jan","points":80,"categories":["Hemsökt Fängelse","hemsökt i sverige","Hemsökt Prästgård","Hemsökta Herrgårdar"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1257","name":"7 av Norges mest hemsökta platser","slug":"7-av-norges-mest-hemsokta-platser","url":"https://www.spokkartan.se/spokplatser-i-norge/7-av-norges-mest-hemsokta-platser/","lat":61.076,"lng":9.266,"country":"Norge","region":"Norge","type":"Slott","scary":4,"free":false,"bookable":true,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=7+av+Norges+mest+hemsökta+platser","teaser":"Norge är inte bara ett land med storslagna fjordar och majestätiska berg, utan också hem till några av de mest fascinerande hemsökta platserna i Skandinavien. Här är sju platser där det förf","description":"Norge är inte bara ett land med storslagna fjordar och majestätiska berg, utan också hem till några av de mest fascinerande hemsökta platserna i Skandinavien. Här är sju platser där det förflutna aldrig riktigt lämnat, och där spöken och mystiska berättelser fascinerar både besökare och lokalbefolkning. Blaker Skansen – Soldater och en orolig kommandant Blaker Skansen i Sørum är en fästning byggd 1682 för att försvara Norge mot svenska attacker. Under åren har platsen blivit känd för sina paranormala fenomen. Soldater sägs vandra genom väggarna, och en särskild ande – Kommandant Oberst Andreas August Prætorius – har ofta setts gå igen. Många besökare har känt en hand på axeln eller hört röst","img":"https://www.spokkartan.se/wp-content/uploads/2025/01/Nidarosdomen-3.jpg","date":"Sat, 11 Jan","points":80,"categories":["Blaker Skansen","Gjeterøya och Siktesøya","hemsökt","Hemsökt Kyrka"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1273","name":"Kronovalls slott","slug":"kronovalls-slott","url":"https://www.spokkartan.se/hemsokta-slott/kronovalls-slott/","lat":55.532,"lng":12.429,"country":"Sverige","region":"Skåne Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Kronovalls+slott","teaser":"Kronovalls slott, beläget vid Fågeltofta på Österlen, är en historisk plats med en historia präglad av adel, tragedier och berättelser om övernaturliga händelser. Slottet, som byggdes på 150","description":"Kronovalls slott, beläget vid Fågeltofta på Österlen, är en historisk plats med en historia präglad av adel, tragedier och berättelser om övernaturliga händelser. Slottet, som byggdes på 1500-talet, är känt för sin koppling till paranormal aktivitet och har under årens lopp lockat både spökjägare och skeptiker. Isabelle – Slottets mest kända spöke En av de mest återberättade historierna handlar om Isabelle Hamilton, en ung kvinna som sägs hemsöka slottet. På 1800-talet förälskade hon sig i en skogvaktars son. När hon en vinternatt försökte möta honom gick hon över vallgravens is, som brast, vilket ledde till att hon drunknade. Flera gäster har vittnat om märkliga händelser kopplade till Isab","img":"https://www.spokkartan.se/wp-content/uploads/2025/01/Kronovalls-Slott-1.jpg","date":"Mon, 20 Jan","points":80,"categories":["Hemsökta Slott","Kronovalls Slott","laxton","Skåne Län"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1275","name":"Gjøvik Gård","slug":"gjovik-gard","url":"https://www.spokkartan.se/spokhus/gjovik-gard/","lat":61.0748,"lng":9.5427,"country":"Norge","region":"Norge","type":"Spökhus","scary":5,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Gjøvik+Gård","teaser":"På en gård strax utanför Gjøvik utspelar sig berättelser som skulle kunna komma direkt från en skräckfilm. Denna gård, som varit föremål för många paranormala undersökningar, är känd för sin","description":"På en gård strax utanför Gjøvik utspelar sig berättelser som skulle kunna komma direkt från en skräckfilm. Denna gård, som varit föremål för många paranormala undersökningar, är känd för sina återkommande oförklarliga händelser och rykten om gästvänliga. Men också rastlösa andar. Mystiska rörelser och försvunna föremål En kvinna i andra våningen sägs visa sig ibland genom fönstret, trots att ingen borde vara där. Gäster och ägare har hört tydliga steg ovanför sina huvuden när ingen annan varit på plats. V id köksingången slår ljuset av och på utan någon mänsklig inblandning, och dörren öppnas oväntat. Dessutom verkar föremål i huset ibland ha ett eget liv – ett exempel är en kvast som ovänta","img":"https://www.spokkartan.se/wp-content/uploads/2025/01/Gjovik-Gard.jpg","date":"Tue, 28 Jan","points":100,"categories":["Gjøvik","Gkövik Gård","Norge","spöken"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1279","name":"Sauda Fjord Hotel och Oberstens spöklika närvaro på rum 315","slug":"sauda-fjord-hotel","url":"https://www.spokkartan.se/hemsokta-hotell/sauda-fjord-hotel/","lat":59.807,"lng":8.4364,"country":"Norge","region":"Norge","type":"Hotell","scary":4,"free":false,"bookable":true,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Sauda+Fjord+Hotel+och+Oberstens+spöklika+närvaro+på+rum+315","teaser":"I den lugna byn Sauda i Rogaland ligger Sauda Fjord Hotel, en historisk byggnad som har lockat både gäster och spökjägare. Trots sin charm och sitt fantastiska läge är hotellet mest känt för","description":"I den lugna byn Sauda i Rogaland ligger Sauda Fjord Hotel, en historisk byggnad som har lockat både gäster och spökjägare. Trots sin charm och sitt fantastiska läge är hotellet mest känt för sin permanent incheckade gäst – en tysk oberst som aldrig riktigt lämnade. En tragisk kärlekshistoria Obersten, en 28-årig officer, sägs ha checkat in på hotellet för att gifta sig med sitt livs kärlek. Men hans flirtiga beteende gjorde att förhållandet slutade i tragedi när hans tilltänkta brud avbröt förlovningen. Förkrossad tog han sitt liv genom att hänga sig på rum 315. Hans sorg och närvaro tycks ha stannat kvar i hotellets väggar. Paranormala aktiviteter på rum 315 Rummet är känt för sina mystiska","img":"https://www.spokkartan.se/wp-content/uploads/2025/01/Sauda-Fjordhotell-1.jpg","date":"Tue, 28 Jan","points":80,"categories":["Hemsökt Hotell","Hemsökta Hotell","Spökelser i Rogaland","Spökplatser i Norge"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1282","name":"Hotel Union Øye – Den vita damen och det blå rummet","slug":"hotel-union-oye","url":"https://www.spokkartan.se/hemsokta-hotell/hotel-union-oye/","lat":59.7807,"lng":9.0954,"country":"Norge","region":"Norge","type":"Hotell","scary":4,"free":false,"bookable":true,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Hotel+Union+Øye+–+Den+vita+damen+och+det+blå+rummet","teaser":"Beläget vid Norangsfjorden, omgiven av mäktiga fjäll och lugna vatten, står Hotel Union Øye som en tidskapsel från 1891. Hotellet har välkomnat både kungligheter och resenärer, men det är de","description":"Beläget vid Norangsfjorden, omgiven av mäktiga fjäll och lugna vatten, står Hotel Union Øye som en tidskapsel från 1891. Hotellet har välkomnat både kungligheter och resenärer, men det är dess mest kända gäst. Den vita damen. En hjärtskärande kärlekshistoria Linda, en ung tjänsteflicka, blev förälskad i den tyska officeren Philip von Moltke. Men deras kärlek var dömd – Philip var fast i ett olyckligt äktenskap och fick inte skilja sig. Efter hans självmord i Tyskland tog Linda sitt eget liv, klädd i sin brudklänning, genom att kasta sig i fjorden. Mystiska fenomen i Det Blå Rummet Det sägs att Linda fortfarande söker sin älskade på hotellet. Det Blå Rummet, där hon bodde, är känt för att ha ","img":"https://www.spokkartan.se/wp-content/uploads/2025/01/Hotel-union-oye.jpg","date":"Tue, 28 Jan","points":80,"categories":["Hemsökt Hotell","Hemsökta Hotell","Hotel Union Öye","Spökplatser i Norge"],"featured":true,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1287","name":"Elingård Herregård och General Birte","slug":"elingard-herregard","url":"https://www.spokkartan.se/hemsokta-herrgardar/elingard-herregard/","lat":60.8953,"lng":7.5781,"country":"Norge","region":"Norge","type":"Herrgård","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Elingård+Herregård+och+General+Birte","teaser":"I hjärtat av Fredrikstad ligger Elingård Herregård, en plats fylld med historia och övernaturliga fenomen. Den mest kända invånaren är General Birte, eller Birgitte Kristine Kaas, som var he","description":"I hjärtat av Fredrikstad ligger Elingård Herregård, en plats fylld med historia och övernaturliga fenomen. Den mest kända invånaren är General Birte, eller Birgitte Kristine Kaas, som var herregårdens mäktiga ägare på 1700-talet. Birgitte Kaas och hennes eviga närvaro General Birte är känd för sin bestämda personlighet, något som fortfarande märks på gården. Hon har setts vandra runt i sina gamla rum, och ofta avslöjar hon sin närvaro genom den starka parfym hon brukade använda. Den intensiva doften dyker upp utan förvarning, särskilt under kvällar och nätter. Andra mystiska fenomen Birtes närvaro är inte den enda som präglar gården. Svarta katter med lysande ögon har setts smyga genom rumme","img":"https://www.spokkartan.se/wp-content/uploads/2025/01/Elingard-Herregard-1.jpg","date":"Sun, 26 Jan","points":80,"categories":["Elingård Herrgård","General Birte","Hemsökta Herrgårdar","Spökplatser i Norge"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1289","name":"Dalen Hotel och Rum 17","slug":"dalen-hotel","url":"https://www.spokkartan.se/hemsokta-hotell/dalen-hotel/","lat":60.4305,"lng":8.5895,"country":"Norge","region":"Norge","type":"Hotell","scary":4,"free":false,"bookable":true,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Dalen+Hotel+och+Rum+17","teaser":"I Telemark ligger det legendariska Dalen Hotel, ofta kallat \"Sagornas hotell.\" Men bakom den vackra fasaden döljer sig en tragisk historia som hemsöker rum 17. Miss Greenfields sorgliga öde","description":"I Telemark ligger det legendariska Dalen Hotel, ofta kallat \"Sagornas hotell.\" Men bakom den vackra fasaden döljer sig en tragisk historia som hemsöker rum 17. Miss Greenfields sorgliga öde Historien berättar om Miss Greenfield, en kvinna som checkade in på hotellet under sent 1800-tal. Hon födde i hemlighet ett barn på rum 17, men barnet hittades dött av personalen när säsongen avslutades. Miss Greenfield arresterades senare i England men tog sitt liv innan rättegången kunde börja. Nu kan du köpa vår e-bok om hemsökta hotell i Sverige! Läs om de såväl kusliga som vackra hotellen i Sverige där du kan checka in och kanske uppleva något utöver det vanliga! Hemsökta hotell i sverige är en ebok ","img":"https://www.spokkartan.se/wp-content/uploads/2025/01/Hotel-Dalen-1.jpg","date":"Sun, 26 Jan","points":80,"categories":["Dalen Hotell","Hemsökt Hotell","Hemsökta Hotell","Rum 17"],"featured":true,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1311","name":"Hemsökta hotell i Sverige","slug":"hemsokta-hotell-i-sverige","url":"https://www.spokkartan.se/hemsokta-hotell/hemsokta-hotell-i-sverige/","lat":59.7541,"lng":19.5338,"country":"Sverige","region":"Sverige","type":"Hotell","scary":4,"free":false,"bookable":true,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Hemsökta+hotell+i+Sverige","teaser":"Sverige är fullt av hemsökta platser, och på flera av dem har du möjlighet att checka in. Kanske får du möjlighet att uppleva något av de många händelser som skapat kalla kårar hos hotellgäs","description":"Sverige är fullt av hemsökta platser, och på flera av dem har du möjlighet att checka in. Kanske får du möjlighet att uppleva något av de många händelser som skapat kalla kårar hos hotellgäster över hela vårat land. För att göra det enkelt har vi sammanställt de mest hemsökta hotellen i Sverige i en ebok. Stötta vårat arbete, och på samma gång hitta nya hemsökta pärlor att upptäcka! Ladda ner boken HÄR! Hemsökta hotell i sverige är en ebok för dig som gillar spänning.","img":"https://www.spokkartan.se/wp-content/uploads/2024/10/Namnlos-A4-liggande.jpg","date":"Mon, 27 Jan","points":80,"categories":["hemsökt","Hemsökt Hotell","Hemsökta Hotell","hemsökta platser"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1322","name":"Spöken i Hedvig Eleonora kyrka","slug":"hedvig-eleonora-kyrka","url":"https://www.spokkartan.se/hemsokt-kyrka/hedvig-eleonora-kyrka/","lat":59.207,"lng":17.3783,"country":"Sverige","region":"Stockholms Län","type":"Kyrka","scary":3,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Spöken+i+Hedvig+Eleonora+kyrka","teaser":"Hedvig Eleonora kyrka på Östermalm i Stockholm är en plats fylld av historia – och enligt vissa även av spöken. När natten faller lär osynliga gestalter röra sig genom kyrksalen, som om de a","description":"Hedvig Eleonora kyrka på Östermalm i Stockholm är en plats fylld av historia – och enligt vissa även av spöken. När natten faller lär osynliga gestalter röra sig genom kyrksalen, som om de aldrig riktigt lämnat denna värld. De döda läkarnas samling Enligt sägnen samlas församlingens avlidna läkare vid doctor Hallmanns grav inne i kyrkan. Tillsammans med patienter de en gång vårdat tycks de mötas i en sorts tyst konsultation. Vissa besökare har vittnat om en plötslig kyla vid gravhällen, skuggor i ögonvrån och en känsla av att inte vara ensam. Ladugårdslandets Vita Fru Bland kyrkans mest kusliga berättelser finns den om Ladugårdslandets Vita Fru. Hon har setts röra sig genom kyrkan, alltid kl","img":"https://www.spokkartan.se/wp-content/uploads/2025/01/Black-Modern-Handwritten-Motivation-Quote-Social-Media.jpg","date":"Thu, 30 Jan","points":60,"categories":["hedvig eleonora kyrka","Hemsökt Kyrka","hemsökt kyrka","hemsökta platser i stockholm"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1325","name":"Valla kyrka","slug":"valla-kyrka","url":"https://www.spokkartan.se/hemsokt-kyrka/valla-kyrka/","lat":57.7829,"lng":13.4918,"country":"Sverige","region":"Västra Götalands Län","type":"Kyrka","scary":3,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Valla+kyrka","teaser":"V alla kyrka på Tjörn är en stillsam plats med anor från medeltiden. Men trots sin lugna fasad bär kyrkan på historier som skaver. En av dem handlar om stormannen Lauritz Olsson Green. En do","description":"V alla kyrka på Tjörn är en stillsam plats med anor från medeltiden. Men trots sin lugna fasad bär kyrkan på historier som skaver. En av dem handlar om stormannen Lauritz Olsson Green. En domare med ett skamfilat rykte, både i livet och efter döden. Domaren som aldrig fick ro Lauritz Olsson Green levde på 1500-talet och ska enligt sägnen ha varit en skrupelfri man. Han anklagades för att ha tillskansat sig landområden på tveksamma grunder, och många menade att han satt mer tro till guld än till rättvisa. När han dog begravdes han inne i Valla kyrka, men hans ande verkar inte ha funnit frid. Nattetid sägs han rida genom bygden på en svart häst. Från sin grav under kyrkgolvet galopperar han ut","img":"https://www.spokkartan.se/wp-content/uploads/2025/01/Elingaard-Herregard-1.jpg","date":"Thu, 30 Jan","points":60,"categories":["Bohuslän","Hemsökt Kyrka","hemsökt kyrka","Tjörn"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1330","name":"Den svartklädda damen på Vännäsby kyrkogård","slug":"vannasby-kyrkogard","url":"https://www.spokkartan.se/vasterbottens-lan/vannasby-kyrkogard/","lat":63.6218,"lng":19.8081,"country":"Sverige","region":"Västerbottens Län","type":"Kyrka","scary":3,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Den+svartklädda+damen+på+Vännäsby+kyrkogård","teaser":"På Vännäsby kyrkogård, inte långt från Umeälven, vandrar en ensam skepnad i mörkret. Det är en äldre kvinna, klädd i svart, med ett huckle knutet under hakan. Hon går långsamt och framåtluta","description":"På Vännäsby kyrkogård, inte långt från Umeälven, vandrar en ensam skepnad i mörkret. Det är en äldre kvinna, klädd i svart, med ett huckle knutet under hakan. Hon går långsamt och framåtlutad, som tyngd av år och sorg. De som sett henne har ofta försökt närma sig, men mötet slutar alltid på samma sätt. Hon försvinner i tomma intet. En sorg som aldrig släpper taget Flera vittnen har berättat att de gått fram för att tala med kvinnan. Hon ska ha sagt att hon är på väg till sin mans grav. När förbipasserande erbjudit henne skjuts hemåt har hon vänligt avböjt. Om man släpper henne med blicken, ens för ett ögonblick, är hon borta när man ser tillbaka. Det märkliga är att ingen verkar veta vem hon","img":"https://www.spokkartan.se/wp-content/uploads/2025/01/Vannas-Kyrka.jpg","date":"Thu, 30 Jan","points":60,"categories":["Hemsökt Kyrka","hemsökt kyrka","hemsökta platser norrland","Spökplatser i norrland"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1333","name":"S:t Johannes kyrkogård - Stockholms mest hemsökta gravplats","slug":"st-johannes-kyrkogard","url":"https://www.spokkartan.se/kyrkogardar/st-johannes-kyrkogard/","lat":60.1222,"lng":18.4297,"country":"Sverige","region":"Stockholms Län","type":"Kyrka","scary":3,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=S:t+Johannes+kyrkogård+-+Stockholms+mest+hemsökta+gravplats","teaser":"Högst upp på Brunkebergsåsen i Stockholm reser sig S:t Johannes kyrka, en imponerande byggnad i rödtegel som blickar ut över Norrmalm. Men det är inte kyrkans praktfulla fasad som gett plats","description":"Högst upp på Brunkebergsåsen i Stockholm reser sig S:t Johannes kyrka, en imponerande byggnad i rödtegel som blickar ut över Norrmalm. Men det är inte kyrkans praktfulla fasad som gett platsen dess rykte. Det är vad som sker på kyrkogården när mörkret faller. Här, bland gravstenarna och de skuggiga gångarna, sägs de döda vara mer närvarande än de levande. Vittnen har rapporterat om viskningar ur jorden, svarta skepnader som rör sig med ryckiga rörelser och en oförklarlig, genomträngande lukt av förruttnelse. Viskningar från den namnlösa graven Vid en av kyrkogårdsmurens hörn ligger en anonym sten. Ingen vet exakt vem som vilar där, men enligt sägnen kan den som lägger örat mot jorden höra sv","img":"https://www.spokkartan.se/wp-content/uploads/2025/01/Vannas-Kyrka-1.jpg","date":"Thu, 30 Jan","points":60,"categories":["Hemsökt i Stockholm","Hemsökt Kyrka","hemsökt kyrka","hemsökta platser i stockholm"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1336","name":"Sveriges mest hemsökta kyrkor - Här vilar de döda aldrig i frid","slug":"sveriges-mest-hemsokta-kyrkor-har-vilar-de-doda-aldrig-i-frid","url":"https://www.spokkartan.se/hemsokt-kyrka/sveriges-mest-hemsokta-kyrkor-har-vilar-de-doda-aldrig-i-frid/","lat":60.031,"lng":18.6822,"country":"Sverige","region":"Sverige","type":"Kyrka","scary":3,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Sveriges+mest+hemsökta+kyrkor+-+Här+vilar+de+döda+aldrig+i+frid","teaser":"Kyrkor är tänkta som fridfulla platser för bön och eftertanke, men vissa av dem bär på något mer än bara historia. Genom åren har flera svenska kyrkor blivit kända för märkliga skepnader, of","description":"Kyrkor är tänkta som fridfulla platser för bön och eftertanke, men vissa av dem bär på något mer än bara historia. Genom åren har flera svenska kyrkor blivit kända för märkliga skepnader, oförklarliga ljud och berättelser om andar som vägrar lämna platsen. Vissa tros vara själar som fastnat mellan världarna, andra är förbannade präster eller olyckliga gestalter med oförlösta öden. Här är några av Sveriges mest hemsökta kyrkor. Vågar du besöka dem? Hedvig Eleonora kyrka – de döda läkarnas samling Hedvig Eleonora kyrka på Östermalm i Stockholm är en praktfull byggnad från 1700-talet. Men under de mörka timmarna på dygnet sägs kyrkorummet fyllas av andra besökare – sådana som sedan länge borde ","img":"https://www.spokkartan.se/wp-content/uploads/2025/01/Sveriges-Mest-Hemsokta-kyrkor.jpg","date":"Thu, 30 Jan","points":60,"categories":["Hemsökt Kyrka","Kyrkogårdar"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1348","name":"Stenkullens Värdshus – Sveriges mest hemsökta hotell?","slug":"stenkullens-vardshus","url":"https://www.spokkartan.se/hemsokta-hotell/stenkullens-vardshus/","lat":57.8036,"lng":14.9593,"country":"Sverige","region":"Östergötlands Län","type":"Hotell","scary":4,"free":false,"bookable":true,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Stenkullens+Värdshus+–+Sveriges+mest+hemsökta+hotell?","teaser":"Stenkullens Värdshus, beläget strax norr om Norrköping, är en plats som både fascinerar och skrämmer. Det anrika huset från 1858 är idag ett av Sveriges mest mytomspunna spökhotell, och de s","description":"Stenkullens Värdshus, beläget strax norr om Norrköping, är en plats som både fascinerar och skrämmer. Det anrika huset från 1858 är idag ett av Sveriges mest mytomspunna spökhotell, och de som har haft förmånen – eller oturen – att övernatta här vittnar om oförklarliga fenomen. Hotellet, som ursprungligen byggdes som en exklusiv sommarbostad åt snusfabrikören Erik Swartz, har genom åren genomgått flera förändringar. Under 1900-talet beboddes det av sonen Carl Swartz, som under en kort period 1917 var Sveriges statsminister. På 1950-talet omvandlades huset till hotell, och sedan dess har ryktet om platsens paranormala aktivitet bara vuxit sig starkare. Foto: Matti Hietasaari, Okänt Ett hotell","img":"https://www.spokkartan.se/wp-content/uploads/2025/02/Stenkullen-Vardshus.jpg","date":"Tue, 04 Feb","points":80,"categories":["E4","Hemsökta Hotell","Hotell Stenkullen","Östergötlands Län"],"featured":true,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1349","name":"Sveriges 9 mest hemsökta hotell – Vågar du checka in?","slug":"sveriges-mest-hemsokta-hotell-vagar-du-checka-in","url":"https://www.spokkartan.se/hemsokta-hotell/sveriges-mest-hemsokta-hotell-vagar-du-checka-in/","lat":59.8709,"lng":18.8519,"country":"Sverige","region":"Sverige","type":"Hotell","scary":4,"free":false,"bookable":true,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Sveriges+9+mest+hemsökta+hotell+–+Vågar+du+checka+in?","teaser":"Sverige är fyllt av historiska hotell där gäster checkat in – men vissa verkar aldrig riktigt ha lämnat. Från olyckliga brudar och mörka hemligheter till skuggfigurer och oförklarliga ljud,","description":"Sverige är fyllt av historiska hotell där gäster checkat in – men vissa verkar aldrig riktigt ha lämnat. Från olyckliga brudar och mörka hemligheter till skuggfigurer och oförklarliga ljud, dessa nio hotell bär på rykten om det övernaturliga. Vågar du besöka dem? Foto: Matti Hietasaari, Okänt 1. Hotell Stenkullen, Norrköping – Skuggor i natten Strax norr om Norrköping, precis intill E4:an ligger Stenkullens Värdshus, ett hotell där tiden tycks ha stannat. Den pampiga byggnaden från 1858, en gång en exklusiv sommarvilla åt snusfabrikören Erik Swartz, bär på en lång historia fylld av både lyx och mörka berättelser. Byggnadens italienskinspirerade arkitektur med vita fasader, valvbågar och en t","img":"https://www.spokkartan.se/wp-content/uploads/2025/02/Sveriges-mest-hemsokta-hotell-1.jpg","date":"Tue, 04 Feb","points":80,"categories":["Hemsökta Hotell"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1364","name":"Den huvudlösa kusken på Göholms gods","slug":"goholms-gods","url":"https://www.spokkartan.se/blekinge-lan/goholms-gods/","lat":55.7282,"lng":14.9185,"country":"Sverige","region":"Blekinge Län","type":"Kyrka","scary":3,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Den+huvudlösa+kusken+på+Göholms+gods","teaser":"Längs Blekingekusten, strax sydost om Ronneby, tornar Göholms gods upp sig på Göhalvön. Det är en plats med en lång och dramatisk historia – men också en av Blekinges mest omtalade hemsökta","description":"Längs Blekingekusten, strax sydost om Ronneby, tornar Göholms gods upp sig på Göhalvön. Det är en plats med en lång och dramatisk historia – men också en av Blekinges mest omtalade hemsökta platser. Här sägs självaste Johan af Puke, den legendariske amiralen och greven, fortfarande hemsöka sin forna egendom. Den mest skrämmande berättelsen? En svart vagn, dragen av fyra kolsvarta hästar, rullar genom natten. På kuskbocken sitter en förare – utan huvud. Och i vagnen? Där sitter ingen mindre än Johan af Puke själv, på en evig färd genom sin gamla ägor. \"Greve Puke tjuvåkte med mig\" Legenden om Göholm har levt kvar i generationer. En bonde som arrenderade marken från den senaste privata ägaren,","img":"https://www.spokkartan.se/wp-content/uploads/2025/02/Goholms_gods_1948-1.jpg","date":"Mon, 10 Feb","points":60,"categories":["Blekinge Län","General Puke","Göholms GOds","Hemsökta platser i Blekinge"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1368","name":"Gräfsnäs slottsruin – förbannelser, spöken och en gömd skatt","slug":"grafsnas-slottsruin","url":"https://www.spokkartan.se/vastra-gotalands-lan/grafsnas-slottsruin/","lat":57.0336,"lng":13.2546,"country":"Sverige","region":"Västra Götalands Län","type":"Ruin","scary":3,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Gräfsnäs+slottsruin+–+förbannelser,+spöken+och+en+gömd+skatt","teaser":"Längs sjön Antens norra spets, utanför Alingsås, reser sig ruinerna av Gräfsnäs slott – en plats som bär på både historia och mörka legender. Här sägs en förbannelse vila, en som uttalades a","description":"Längs sjön Antens norra spets, utanför Alingsås, reser sig ruinerna av Gräfsnäs slott – en plats som bär på både historia och mörka legender. Här sägs en förbannelse vila, en som uttalades av en kvinna i förtvivlan och vrede. En förbannelse som förutspådde att slottet skulle brinna tre gånger, med exakt hundra års mellanrum. Och det gjorde det. Slottet brann 1634. Det brann igen 1734. Och ännu en gång, 1834. Efter den tredje branden fick det aldrig återuppbyggas. Vissa säger att det var förbannelsens kraft som gjorde det omöjligt att återställa Gräfsnäs till sin forna glans. Andra menar att det bara var en olycklig slump. Ebba Lilliehöök – en tyrann som lämnade spår i tiden Den mest kända pe","img":"https://www.spokkartan.se/wp-content/uploads/2025/02/Grafsnas-Slottsruin.jpg","date":"Tue, 11 Feb","points":60,"categories":["Alingsås","Grafsnäs","Hemsökta ruiner","Ruiner"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1374","name":"Vem går igen i rum 104 på Söderhamns stadshotell?","slug":"soderhamns-stadshotell","url":"https://www.spokkartan.se/gavleborgs-lan/soderhamns-stadshotell/","lat":60.8663,"lng":17.473,"country":"Sverige","region":"Gävleborgs Län","type":"Hotell","scary":4,"free":false,"bookable":true,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Vem+går+igen+i+rum+104+på+Söderhamns+stadshotell?","teaser":"Det sägs att vissa hotellgäster vaknat mitt i natten av ljudet av tunga steg i korridoren. Men när de kikat ut har de inte sett en levande själ. Andra har hört dämpade knackningar från vägge","description":"Det sägs att vissa hotellgäster vaknat mitt i natten av ljudet av tunga steg i korridoren. Men när de kikat ut har de inte sett en levande själ. Andra har hört dämpade knackningar från väggen eller känt hur sängen sakta förflyttats under natten. Mest aktivitet verkar ske i rum 104, rakt under köket, där källarmästaren Carl Emil Fuhre sägs ha sin rastlösa närvaro kvar. Spökhistorierna kring Söderhamns stadshotell Söderhamns stadshotell har stått vid Rådhustorget sedan 1879 och varit en samlingspunkt i staden i över ett sekel. Men det är inte bara hotellgäster och restaurangbesökare som sägs vistas där. Sedan länge går det historier om att en gammal anställd aldrig riktigt lämnade byggnaden – ","img":"https://www.spokkartan.se/wp-content/uploads/2025/02/Soderhamns-.jpg","date":"Sun, 16 Feb","points":80,"categories":["Gävleborgs Län","hemsökta hotell","Söderhamn","Söderhamns stadshotell"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1377","name":"Spökhistorier från Södertuna slott – Den inlåsta älskarinnan och Svarta damen","slug":"sodertuna-slott","url":"https://www.spokkartan.se/sodermanlands-lan/sodertuna-slott/","lat":59.7754,"lng":15.4801,"country":"Sverige","region":"Södermanlands Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Spökhistorier+från+Södertuna+slott+–+Den+inlåsta+älskarinnan+och+Svarta+damen","teaser":"Södertuna slott i Sörmland är en plats med en lång och dramatisk historia. Här har adel bott, maktspel utspelats och tragiska öden beseglats. Men vissa själar verkar inte ha lämnat slottet –","description":"Södertuna slott i Sörmland är en plats med en lång och dramatisk historia. Här har adel bott, maktspel utspelats och tragiska öden beseglats. Men vissa själar verkar inte ha lämnat slottet – inte ens i döden. Den inlåsta älskarinnan En av de mest omtalade spökhistorierna på Södertuna handlar om en kvinna som sägs ha varit älskarinna till en av slottets tidigare ägare. Hennes existens var en hemlighet, och för att dölja skandalen låstes hon in i ett rum, utan möjlighet att någonsin lämna det. Vad som hände med henne är oklart, men enligt legenden dog hon där – bitter och fylld av hat. Och än idag sägs hennes ande hemsöka slottet, särskilt de manliga gästerna. Män som övernattat i hennes rum h","img":"https://www.spokkartan.se/wp-content/uploads/2025/02/Sodertuna-Slott-.jpg","date":"Mon, 17 Feb","points":80,"categories":["Gnesta","Hemsökta Slott","Södermanlands Län","Södertuna"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1382","name":"Spökhistorien på Toftaholm Herrgård","slug":"toftaholm-herrgard","url":"https://www.spokkartan.se/hemsokta-herrgardar/toftaholm-herrgard/","lat":56.4608,"lng":15.2155,"country":"Sverige","region":"Kronobergs Län","type":"Herrgård","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Spökhistorien+på+Toftaholm+Herrgård","teaser":"Vid den stilla sjön Vidöstern i Småland ligger Toftaholm Herrgård. En idyllisk plats med anor från 1400-talet. Men bakom de vackra fasaderna och den rogivande naturen döljer sig en mörk hist","description":"Vid den stilla sjön Vidöstern i Småland ligger Toftaholm Herrgård. En idyllisk plats med anor från 1400-talet. Men bakom de vackra fasaderna och den rogivande naturen döljer sig en mörk historia, en berättelse om förbjuden kärlek, förtvivlan och en ande som aldrig funnit ro. En kärlek som slutade i tragedi Enligt legenden var det här på herrgården som en ung bondpojke vid namn Matts förälskade sig i baronens dotter. De två drömde om ett liv tillsammans, men baronen såg deras kärlek som en skam. Han hade redan utsett en annan man åt sin dotter – en äldre godsägare, rik och mäktig. Trots vädjanden och hemliga möten gick det inte att ändra baronens beslut. På morgonen för bröllopet, dagen då ha","img":"https://www.spokkartan.se/wp-content/uploads/2025/02/Toftaholm-Herrgard.jpg","date":"Tue, 18 Feb","points":80,"categories":["Hemsökta Herrgårdar","Hemsöktaplatserismåland","Kronobergs Län","Småland"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1390","name":"Hellidens slott – skönhet, tragedi och oförklarliga skuggor","slug":"hellidens-slott","url":"https://www.spokkartan.se/hemsokta-slott/hellidens-slott/","lat":57.2628,"lng":12.0575,"country":"Sverige","region":"Västra Götalands Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Hellidens+slott+–+skönhet,+tragedi+och+oförklarliga+skuggor","teaser":"På västra sluttningen av Hellidsberget, bara några minuter från Tidaholm reser sig Hellidens slott. Med sin imponerande arkitektur och milsvida utsikt har det varit en plats för makt, utbild","description":"På västra sluttningen av Hellidsberget, bara några minuter från Tidaholm reser sig Hellidens slott. Med sin imponerande arkitektur och milsvida utsikt har det varit en plats för makt, utbildning och framgång. Men allt är inte bara historia och skönhet. Genom åren har både besökare och personal vittnat om oförklarliga fenomen – från steg i tomma korridorer till kalla vinddrag och skuggor som rör sig i ögonvrån. Spökena i Hellidens dunkla korridorer Slottets källare anses vara den mest hemsökta delen av byggnaden. Många som har vågat sig ner har berättat om en tung, tryckande atmosfär och en känsla av att vara iakttagen. En del har till och med upplevt att någon osynlig närmar sig i mörkret. K","img":"https://www.spokkartan.se/wp-content/uploads/2025/03/Hellidens-Slott.jpg","date":"Mon, 03 Mar","points":80,"categories":["Hemsökta Slott","Tidaholm","Västra Götalands Län"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1395","name":"Mörby slottsruin – slottet som Djävulen hjälpte till att bygga","slug":"morby-slottsruin","url":"https://www.spokkartan.se/ruiner/morby-slottsruin/","lat":60.5568,"lng":17.8105,"country":"Sverige","region":"Uppsala Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Mörby+slottsruin+–+slottet+som+Djävulen+hjälpte+till+att+bygga","teaser":"Mörby slottsruin är en plats där historiens vingslag blandas med mörka legender. Enligt sägnen var det inte enbart människohänder som byggde slottet – Djävulen själv sägs ha varit inblandad.","description":"Mörby slottsruin är en plats där historiens vingslag blandas med mörka legender. Enligt sägnen var det inte enbart människohänder som byggde slottet – Djävulen själv sägs ha varit inblandad. Kanske var det därför slottet drabbades av olyckor och tragedier? Och kanske är det därför som det än idag är en av Upplands mest hemsökta platser… Fem spöken sägs vandra genom ruinerna Djävulen i form av en svart hund Den mest skrämmande figuren i Mörby slottsruin är ingen mindre än Djävulen själv – eller i alla fall en av hans skepnader. Han visar sig som en stor svart hund med glödande ögon. Det sägs att den som ser hunden snart kommer drabbas av svår sjukdom eller olycka. Många besökare har känt en o","img":"https://www.spokkartan.se/wp-content/uploads/2025/03/Morby-Slottsruin.jpg","date":"Tue, 04 Mar","points":80,"categories":["Hemsökt Slott","Hemsökta Slott","Mörby Slottsruin","Norrtälje"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1419","name":"Spöken, skandaler och Sturemord – därför är Uppsala slott värt ett besök!","slug":"uppsala_slott","url":"https://www.spokkartan.se/hemsokta-slott/uppsala_slott/","lat":59.8163,"lng":18.3231,"country":"Sverige","region":"Uppsala Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Spöken,+skandaler+och+Sturemord+–+därför+är+Uppsala+slott+värt+ett+besök!","teaser":"Slottet där historien viskar tillbaka Uppsala slott ser kanske stillsamt ut där det tronar över staden, men för den som stannar upp en stund är det lätt att känna att allt inte står helt sti","description":"Slottet där historien viskar tillbaka Uppsala slott ser kanske stillsamt ut där det tronar över staden, men för den som stannar upp en stund är det lätt att känna att allt inte står helt still. Det sägs att väggarna bär på minnen, och ibland får man nästan för sig att de försöker säga något. Jag har själv gått runt bland ruinerna, pratat med guider, lyssnat på sägnerna och känt den där märkliga närvaron som många beskrivit. En av dem är Mia Ulin som jobbar på Vasaborgen , den äldsta delen av slottet som idag fungerar som både ruin och upplevelsearena. Hon guidar besökare, håller i spökvandringar och kallar sig ibland för slottsspöke. När jag frågade henne rakt ut om det verkligen spökar, sva","img":"https://www.spokkartan.se/wp-content/uploads/2025/03/Uppsala-slott-Vasaborgen.jpg","date":"Mon, 24 Mar","points":80,"categories":["Hemsökta platser i Uppsala","Hemsökta Slott","Spökhus","spökslott"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1430","name":"En spökhistoria från Hammars säteri","slug":"hammars-sateri","url":"https://www.spokkartan.se/varmlands-lan/hammars-sateri/","lat":59.872,"lng":12.757,"country":"Sverige","region":"Värmlands Län","type":"Herrgård","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=En+spökhistoria+från+Hammars+säteri","teaser":"Något rör sig på vinden. Ett svagt knarrande följs av ett dovt steg – ett till. Det stannar. Sedan hörs ett nytt ljud, ett slags släpande. Kanske ett träben? Kanske något ännu värre? På Hamm","description":"Något rör sig på vinden. Ett svagt knarrande följs av ett dovt steg – ett till. Det stannar. Sedan hörs ett nytt ljud, ett slags släpande. Kanske ett träben? Kanske något ännu värre? På Hammar säteri i Väse, drygt fyra kilometer från Rasta längs vägen mot Arnön, viskas det om en närvaro. En vålnad från en annan tid som vägrar lämna det gamla stenhuset ifred. Det handlar om Sophia Lowisa Soop – säteriets obestridliga spökdrottning. En gård där historien aldrig riktigt försvann Hammar är inte bara en av Värmlands äldsta gårdar, utan också en plats där tiden verkar ha fastnat i väggarna. De vitputsade fasaderna bär på mer än bara puts – de döljer sekler av dramatik, maktspel och sorg. Och kansk","img":"https://www.spokkartan.se/wp-content/uploads/2025/04/Hammars-Sateri-Gard.jpg","date":"Tue, 01 Apr","points":80,"categories":["Hammars Säteri","Hemsökta Herrgårdar","Hemsökta platser i Värmland","Soop"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1433","name":"Spökerier på Häringe slott","slug":"haringe-slott","url":"https://www.spokkartan.se/hemsokta-slott/haringe-slott/","lat":58.5551,"lng":16.3445,"country":"Sverige","region":"Södermanlands Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Spökerier+på+Häringe+slott","teaser":"Strax söder om Stockholm, där Södertörns skogar öppnar sig mot havsvikar och stilla vatten, vilar ett slott som länge lockat både nyfikna besökare och oroliga själar. Häringe slott bär på me","description":"Strax söder om Stockholm, där Södertörns skogar öppnar sig mot havsvikar och stilla vatten, vilar ett slott som länge lockat både nyfikna besökare och oroliga själar. Häringe slott bär på mer än sekler av historia. Det bär på röster från andra sidan. Frågan är bara vilka som fortfarande går kvar i salarna när mörkret faller. En plats med historiskt eko Häringe slott ligger i Västerhaninge och uppfördes år 1657 av fältmarskalken Gustaf Horn. Men marken bär på betydligt äldre minnen. Gravfält från järnåldern omger området, och i närheten står en runsten som påminner om platsens fornnordiska arv. I ett av rummen på övervåningen, det så kallade Gotiska rummet, sitter ibland en gestalt i en fåtöl","img":"https://www.spokkartan.se/wp-content/uploads/2025/04/Haringe-Slott.jpg","date":"Wed, 02 Apr","points":80,"categories":["Häringe Slott","hemsökta slott","Hemsökta Slott","Södermanlands Län"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1438","name":"Ätrajungfrun på Falkenbergs Borgruin","slug":"falkenbergs-borgruin","url":"https://www.spokkartan.se/hallands-lan/falkenbergs-borgruin/","lat":56.5477,"lng":12.7809,"country":"Sverige","region":"Hallands Län","type":"Ruin","scary":3,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Ätrajungfrun+på+Falkenbergs+Borgruin","teaser":"Falkenbergs borgruin, belägen vid Ätrans mynning i Halland, är en plats där historiens vingslag känns närvarande. Med anor från 1200-talet har borgen varit skådeplats för flera betydelsefull","description":"Falkenbergs borgruin, belägen vid Ätrans mynning i Halland, är en plats där historiens vingslag känns närvarande. Med anor från 1200-talet har borgen varit skådeplats för flera betydelsefulla händelser och bär på berättelser som sträcker sig över århundraden.​ En strategisk fästning Borgen Falkenberg uppfördes troligen under slutet av 1200-talet av den danske kungen Erik Plogpenning. Dess strategiska läge vid Ätrans sista fors mot Kattegatt gjorde den till en viktig försvarspunkt för den danska kungamakten i norr. Under medeltiden var Halland en del av Danmark, och borgen spelade en central roll i de konflikter som utspelade sig mellan danska och svenska styrkor. År 1434 brändes borgen ner a","img":"https://www.spokkartan.se/wp-content/uploads/2025/04/Falkenberg-Borg-1.jpg","date":"Sat, 05 Apr","points":60,"categories":["Ätrajungfrun","Ätran","Borgruin","Danmark"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1442","name":"Fältmarskalkens ande skrämmer besökare på Bäckaskog Slott","slug":"backaskogs-slott","url":"https://www.spokkartan.se/skane-lan/backaskogs-slott/","lat":56.2065,"lng":13.9061,"country":"Sverige","region":"Skåne Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Fältmarskalkens+ande+skrämmer+besökare+på+Bäckaskog+Slott","teaser":"Bäckaskog slott, beläget på näset mellan Ivösjön och Oppmannasjön i nordöstra Skåne, är en plats där historiens vingslag känns närvarande. Med anor från 1200-talet har slottet genomgått tran","description":"Bäckaskog slott, beläget på näset mellan Ivösjön och Oppmannasjön i nordöstra Skåne, är en plats där historiens vingslag känns närvarande. Med anor från 1200-talet har slottet genomgått transformationer från kloster till kungligt residens och är idag känt för sina berättelser om övernaturliga fenomen.​ Från kloster till slott Ursprungligen grundades Bäckaskog som ett premonstratenserkloster på 1200-talet. Efter reformationen 1537 omvandlades klostret till en befäst slottsanläggning under dansk överhöghet. Det var under denna period som slottet fick sitt nuvarande utseende, mycket tack vare adelsmannen Henrik Ramel och hans son Henrik Ramel den yngre, som stod för betydande ombyggnationer mel","img":"https://www.spokkartan.se/wp-content/uploads/2025/04/Backaskogs-Slott-1.jpg","date":"Tue, 08 Apr","points":80,"categories":["Bäckaskogs slott","hemsökta slott","Hemsökta Slott","Hemsökta slott i Sverige"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1467","name":"Har du vad som krävs för att lösa gåtan kring Österbybruks Herrgård?","slug":"osterbybruks-herrgard-mordgata","url":"https://www.spokkartan.se/okategoriserade/osterbybruks-herrgard-mordgata/","lat":60.9047,"lng":17.6762,"country":"Sverige","region":"Sverige","type":"Herrgård","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Har+du+vad+som+krävs+för+att+lösa+gåtan+kring+Österbybruks+Herrgård?","teaser":"Under en spökjakt samlas några deltagare kring ett gammalt Ouija-bräde. Vad som till en början verkar bli en händelselös session tar plötsligt en dramatisk vändning... Ljusen börjar fladdra","description":"Under en spökjakt samlas några deltagare kring ett gammalt Ouija-bräde. Vad som till en början verkar bli en händelselös session tar plötsligt en dramatisk vändning... Ljusen börjar fladdra och brädet tycks leva ett eget liv. Snabbt börjar deltagarna anteckna de bokstäver som intensivt och obevekligt formas till meningar framför deras ögon. Skräckslagna, men samtidigt fascinerade, inser de att brädet ger dem instruktioner som leder till en hittills okänd plats i huset. I ett av rummen finns en dold panel i väggen... Bakom panelen finner de en låda fylld med gamla, bortglömda brev. Snart går det upp för dem att något fruktansvärt har inträffat på Österbybruks Herrgård, en tragedi vars ekon fo","img":"https://www.spokkartan.se/wp-content/uploads/2025/04/Mordet-pa-1.jpg","date":"Sun, 13 Apr","points":80,"categories":["mordgåta","mordmysterium","Okategoriserade","österby bruk"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1500","name":"Hemsökta ruiner i Sverige","slug":"hemsokta-ruiner-i-sverige","url":"https://www.spokkartan.se/ruiner/hemsokta-ruiner-i-sverige/","lat":59.9742,"lng":18.2543,"country":"Sverige","region":"Sverige","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Hemsökta+ruiner+i+Sverige","teaser":"Det finns platser i Sverige där vinden tycks bära på viskningar från en svunnen tid. Där murar som en gång skyddade kungar, klosterbröder och slottsfruar nu står i tystnad, men långt ifrån ö","description":"Det finns platser i Sverige där vinden tycks bära på viskningar från en svunnen tid. Där murar som en gång skyddade kungar, klosterbröder och slottsfruar nu står i tystnad, men långt ifrån övergivna. Dessa ruiner, vars stenar bär minnen av eld, blod och förbannelser, lockar inte bara historiker – utan även de som söker det övernaturliga. För i skuggorna bland de fallna valven sägs andar vandra. Munkar. Jungfrur. Krigare. Djävulen själv. Följ med till några av Sveriges mest hemsökta ruiner, där varje sten har en historia och varje suck kan vara mer än bara vinden. Vad är egentligen en ruin? En ruin är det som återstår av en tidigare byggnad som delvis eller helt kollapsat eller förstörts – of","img":"https://www.spokkartan.se/wp-content/uploads/2025/03/Morby-Slottsruin.jpg","date":"Sun, 08 Jun","points":80,"categories":["borgruiner","Hemsökta ruiner","Ruiner","slottsruiner"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1527","name":"Spöken, makt och mysterier på Skoklosters slott","slug":"skoklosters-slott","url":"https://www.spokkartan.se/uppsala-lan/skoklosters-slott/","lat":60.4387,"lng":17.0368,"country":"Sverige","region":"Uppsala Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Spöken,+makt+och+mysterier+på+Skoklosters+slott","teaser":"Vid Mälarens glittrande vatten reser sig ett av Europas främsta barockslott, Skokloster. Men bakom de ståtliga fasaderna och praktfulla salarna viskas det om annat än kungliga porträtt och s","description":"Vid Mälarens glittrande vatten reser sig ett av Europas främsta barockslott, Skokloster. Men bakom de ståtliga fasaderna och praktfulla salarna viskas det om annat än kungliga porträtt och stucktak i marmor. Här sägs dokument brinna av sig själva, parfymdoft sväva i tomma rum och döda grevar viska om hemligheter som aldrig fick se dagens ljus. Följ med till Skokloster. En plats av makt, mystik och monument Skoklosters slott, beläget vid Mälarens strand i Uppland, är ett arkitektoniskt mästerverk som förenar militärhistoria, barockprakt och övernaturliga skuggor under ett och samma tak. Byggt mellan 1654 och 1676 av fältherren Carl Gustaf Wrangel, var detta Sveriges största privata slottsbygg","img":"https://www.spokkartan.se/wp-content/uploads/2025/07/Skokloster-Slott.jpg","date":"Wed, 02 Jul","points":80,"categories":["Håbo","Hemsökta Slott","Skoklosterslott","Spökvandring"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1534","name":"”Att skrämma folk blev min livsväg” – Möt mannen bakom Skräckfabriken","slug":"skrackfabriken","url":"https://www.spokkartan.se/hemsokta-slott/skrackfabriken/","lat":55.3443,"lng":13.3667,"country":"Sverige","region":"Skåne Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=”Att+skrämma+folk+blev+min+livsväg”+–+Möt+mannen+bakom+Skräckfabriken","teaser":"Det är något med mörkret i gamla borgar, skuggor som rör sig i ögonvrån och viskningar i tomma rum. Mikael P Wilson vet precis hur det känns – och han har gjort det till sin affärsidé. Sedan","description":"Det är något med mörkret i gamla borgar, skuggor som rör sig i ögonvrån och viskningar i tomma rum. Mikael P Wilson vet precis hur det känns – och han har gjort det till sin affärsidé. Sedan 2013 driver han Skräckfabriken AB , ett företag som bokstavligen lever på att väcka rysningar. Genom spökvandringar, skräckberättelser och levande teater skapar Mikael upplevelser där gränsen mellan fantasi och övernaturlig verklighet suddas ut. Men resan dit började på ett oväntat sätt. Glimmingehus Glimmingehus Glimmingehus – Jag har alltid jobbat med barn och unga som lärare, berättar Mikael. Men parallellt har jag haft en fot i teaterns och filmens värld – framför och bakom kameran. När han fortfaran","img":"https://www.spokkartan.se/wp-content/uploads/2025/08/3.jpg","date":"Thu, 07 Aug","points":80,"categories":["glimmingehus","guidade turer","Hemsökta Slott","Intervjuer"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1542","name":"Glimmingehus spöklika sägner","slug":"glimmingehus","url":"https://www.spokkartan.se/spokvandring/glimmingehus/","lat":55.715,"lng":12.9585,"country":"Sverige","region":"Skåne Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Glimmingehus+spöklika+sägner","teaser":"När man närmar sig den massiva stenborgen Glimmingehus på Österlen känns både historiens vingslag och en lätt rysning längs ryggraden. Borgen började uppföras år 1499 av den danske riddaren","description":"När man närmar sig den massiva stenborgen Glimmingehus på Österlen känns både historiens vingslag och en lätt rysning längs ryggraden. Borgen började uppföras år 1499 av den danske riddaren Jens Holgersson Ulfstand, och med sina metertjocka väggar, djupa vallgrav och minimala fönster var den mer en fortifikation än ett slott. I dag räknas Glimmingehus som Nordens bäst bevarade medeltida borg. Ett fascinerande museum där man kan uppleva vardagslivet under senmedeltiden. Men enligt sägnerna lämnar historien fortfarande spår i form av osaliga andar och paranormala fenomen. Vi får regelbundet in berättelser från besökare som påstår sig ha upplevt spöken, konstiga ljud eller en kall närvaro i de ","img":"https://www.spokkartan.se/wp-content/uploads/2025/08/5.jpg","date":"Thu, 07 Aug","points":80,"categories":["glimmingehus","hemsökt i skåne","hemsökta platser skåne","Hemsökta Slott"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1563","name":"Görvälns slott","slug":"gorvalns-slott","url":"https://www.spokkartan.se/stockholms-lan/gorvalns-slott/","lat":58.9297,"lng":19.0858,"country":"Sverige","region":"Stockholms Län","type":"Slott","scary":4,"free":false,"bookable":true,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Görvälns+slott","teaser":"Görvälns slott ligger vid Mälarens strand i Järfälla nordväst om Stockholm. I dag är byggnaden ett lyxigt hotell, men den långa historien och de många ägarbytena har lämnat spår som sträcker","description":"Görvälns slott ligger vid Mälarens strand i Järfälla nordväst om Stockholm. I dag är byggnaden ett lyxigt hotell, men den långa historien och de många ägarbytena har lämnat spår som sträcker sig från medeltid till modern tid. Platsen omnämns redan i 1400‑talets jordeböcker; då bestod godset av två gårdar. På 1500‑talet tillföll egendomen kronan, men Johan III skänkte den senare till en italiensk adelsman. På 1650‑talet tog Elsa Elisabeth Brahe över och lät bygga det påkostade stenhus som blev den nuvarande huvudbyggnaden – arbetet bedrevs 1659–1661 och stod klart omkring 1675. Kronans säteri och överklassens tillhåll Efter Brahe‑eran följde en rad ägare; i listorna över herrskap återkommer n","img":"https://www.spokkartan.se/wp-content/uploads/2025/08/Gorvalns-slott.jpg","date":"Tue, 02 Sep","points":80,"categories":["Bröllop","Görvälns Slott","Hemsökta Hotell","Hemsökta Slott"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1581","name":"Hörle herrgård – smedja, slottsfru och den vita damen","slug":"horle-herrgard","url":"https://www.spokkartan.se/hemsokta-herrgardar/horle-herrgard/","lat":57.689,"lng":15.0272,"country":"Sverige","region":"Jönköpings Län","type":"Herrgård","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Hörle+herrgård+–+smedja,+slottsfru+och+den+vita+damen","teaser":"I Hörle, åtta kilometer norr om Värnamo, ligger en av Sveriges mest välbevarade herrgårdar från 1700‑talet. Gården började som järnbruk när den holländske entreprenören Justus Baak 1659 fick","description":"I Hörle, åtta kilometer norr om Värnamo, ligger en av Sveriges mest välbevarade herrgårdar från 1700‑talet. Gården började som järnbruk när den holländske entreprenören Justus Baak 1659 fick privilegiet att anlägga en smedja vid Hörle falls ström. Efter Baaks död köpte Heinrich van Lindt bruket och 1726 gifte han sig med den unga Anna Margareta Lilliecreutz. Ett bygge i tre etapper Det nuvarande corps-de-logi uppfördes i tre etapper: Heinrich van Lindt köpte platsen och lät påbörja byggandet. Hans efterträdare Peter Brouwer, som också var svärson, byggde huset 1740–1742 och Gabriel von Seth fullbordade det 1746. Arkitekterna Bengt Wilhelm Carlberg och Carl Hårleman gav huset en klassicistisk","img":"https://www.spokkartan.se/wp-content/uploads/2025/12/Horle-Herrgard-3.jpg","date":"Mon, 01 Dec","points":80,"categories":["Hemsökta Herrgårdar","Hemsökta platser småland","Hörle Herrgård","Jönköpings Län"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1585","name":"Klara kyrkogård och nunnan i svart","slug":"klara-kyrkogard","url":"https://www.spokkartan.se/hemsokt-kyrka/klara-kyrkogard/","lat":59.4105,"lng":16.9914,"country":"Sverige","region":"Stockholms Län","type":"Kyrka","scary":3,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Klara+kyrkogård+och+nunnan+i+svart","teaser":"I centrala Stockholm, strax norr om Sergels torg, ligger Klara kyrkogård. Den är en rest av det gamla Klaraklostret , ett franciskanerkloster som grundades på 1200‑talet. Efter reformationen","description":"I centrala Stockholm, strax norr om Sergels torg, ligger Klara kyrkogård. Den är en rest av det gamla Klaraklostret , ett franciskanerkloster som grundades på 1200‑talet. Efter reformationen blev kyrkogården tillhörig Klara församling och var länge begravningsplats för borgare och kulturpersonligheter. I takt med att huvudstaden växte minskade kyrkogården i omfång och omslöts av stenhus; idag är det en grön oas mitt i trafiken. Spökenas promenad Enligt folktron hemsöks kyrkogården av en svartklädd nunna . Spökhus.se berättar att människor sett en kvinna i svart vanhelgsklut vandra bland gravarna och försvinna lika plötsligt. Hon sägs tillhöra det medeltida klostret och har blivit en symbol f","img":"https://www.spokkartan.se/wp-content/uploads/2025/08/Klara.jpg","date":"Thu, 02 Oct","points":60,"categories":["Hemsökt Kyrka","hemsökt kyrkogård","Klara kyrkogård","Spöken i stockholm"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1593","name":"Krapperups slott den vita frun och hundraårscykeln","slug":"krapperups-slott","url":"https://www.spokkartan.se/hemsokta-slott/krapperups-slott/","lat":56.6389,"lng":14.2965,"country":"Sverige","region":"Skåne Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Krapperups+slott+den+vita+frun+och+hundraårscykeln","teaser":"På Kullahalvön i nordvästra Skåne, några kilometer från Mölle, reser sig Krapperups slott. Med sin vallgrav, sina tjocka murar och sin romantiska park med porlande bäckar och exotiska träd k","description":"På Kullahalvön i nordvästra Skåne, några kilometer från Mölle, reser sig Krapperups slott. Med sin vallgrav, sina tjocka murar och sin romantiska park med porlande bäckar och exotiska träd känns det som att kliva in i en sagovärld. Det är inte konstigt att platsen rankas som en sevärdhet av Michelin-guiden. Men bakom den idylliska fasaden gömmer sig en historia av blod, galenskap och en märklig förbannelse. Borgen med anor från 1300-talet Krapperup är en av Skånes äldsta sätesgårdar; den nämns redan på 1200‑talet i dokument, då släkten Krognos ägde borgen. I mitten av 1300‑talet lät riddaren Johannes Jonaesson (Jens Jenssøn på danska) uppföra ett rektangulärt stenhus med festsal. Runt huvudb","img":"https://www.spokkartan.se/wp-content/uploads/2025/09/Krapperups-Slott.png","date":"Mon, 08 Sep","points":80,"categories":["Hemsökta Slott","Höganäs","Krapperups slott","Kullahalvön"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1595","name":"Körningsgården,  pensionatet på Höga Kusten","slug":"korningsgarden","url":"https://www.spokkartan.se/vasternorrlands-lan/korningsgarden/","lat":63.2004,"lng":18.3433,"country":"Sverige","region":"Västernorrlands Län","type":"Hotell","scary":4,"free":false,"bookable":true,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Körningsgården,++pensionatet+på+Höga+Kusten","teaser":"Nordingrå på Höga Kusten är känt för sitt dramatiska landskap och sina träkyrkor. Där ligger också Körningsgården , ett pensionat som ursprungligen byggdes som bygdens finaste bondgård på 18","description":"Nordingrå på Höga Kusten är känt för sitt dramatiska landskap och sina träkyrkor. Där ligger också Körningsgården , ett pensionat som ursprungligen byggdes som bygdens finaste bondgård på 1800‑talet. Sedan 1930‑talet har gården fungerat som pensionat och behållit sin glasveranda och matsal från den ursprungliga byggnaden. Spökande gäster och TV‑besök Pensionatet har figurerat i tv‑programmet Det okända . I en artikel från TV4 beskriver man att premiäravsnittet 2010 spelades in på Körningsgården, som sades vara hemsökt. Gäster hade klagat på att de vaknade av fotsteg och röster, och att något rörde vid dem när de låg och sov. Ägarinnan Birgit Dahlgren berättade att hon är van vid \"spökerier\" ","img":"https://www.spokkartan.se/wp-content/uploads/2025/08/Korningsgarden-pensionatet-pa-Hoga-Kusten.jpg","date":"Tue, 11 Nov","points":80,"categories":["Hemsökt pensionat","Hemsökta Hotell","Höga kusten","Körningsgården"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1791","name":"Utne Hotel, rum 15","slug":"utne-hotel","url":"https://www.spokkartan.se/spokplatser-i-norge/utne-hotel/","lat":61.0279,"lng":7.6691,"country":"Norge","region":"Norge","type":"Hotell","scary":4,"free":false,"bookable":true,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Utne+Hotel,+rum+15","teaser":"Utne hotell i Hardanger har tagit emot gäster sedan 1722, vilket gör det till ett av Norges äldsta gästgiverier. I mer än trehundra år har resande hittat vila i det rödmålade timmerhuset vid","description":"Utne hotell i Hardanger har tagit emot gäster sedan 1722, vilket gör det till ett av Norges äldsta gästgiverier. I mer än trehundra år har resande hittat vila i det rödmålade timmerhuset vid fjorden, där knarrande golv och handmålade rosmönster berättar om generationer av värdar. Hotellet betonar sina långa traditioner och lokala råvaror – här serveras Hardanger cider och hemlagad fårikål framför öppen spis. I rum 15 sägs ”Mor Utne” spöka. Hon var en stark kvinna som drev hotellet under 1800‑talet och hade full kontroll över personal och gäster. När hon dog lämnade hon inte sitt rum. Föremål flyttar sig, dörrar stängs när ingen är där och gäster har vaknat av att någon sitter på sängkanten. ","img":"https://www.spokkartan.se/wp-content/uploads/2025/09/Utne-Hotell-3.png","date":"Sun, 07 Sep","points":80,"categories":["Hemsökta Hotell","Spöken i Norge","Spökplatser i Norge","Utne Hotell"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1860","name":"Piken i karpedammen, Larvik","slug":"larvik-herrgard","url":"https://www.spokkartan.se/hemsokta-herrgardar/larvik-herrgard/","lat":60.447,"lng":7.783,"country":"Norge","region":"Norge","type":"Herrgård","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Piken+i+karpedammen,+Larvik","teaser":"Herregården i Larvik är en av de mest betydelsefulla byggnaderna i Vestfold. Den byggdes av statthållaren Ulrik Fredrik Gyldenløve 1677 som residens i Laurvigen grevskap och är ett vackert b","description":"Herregården i Larvik är en av de mest betydelsefulla byggnaderna i Vestfold. Den byggdes av statthållaren Ulrik Fredrik Gyldenløve 1677 som residens i Laurvigen grevskap och är ett vackert barockpalats med stor park. I parken finns en karpdamm, och här knyts en sorglig spökhistoria till huset. Piken från karpedammen anses vara ett gjenferd – ett spöke – som ska ha visat sig på Herregården i Larvik under 1600‑ och 1700‑talet. Legenden berättar att pigan var en morlös ung sömmerska som följde med Gyldenløve från Danmark 1671 för att bygga Herregården. Det enda hon hade var en medaljong hon delat med sin bror, med löfte om att sätta ihop smycket när de återförenades. Men hon kom aldrig hem. Eft","img":"https://www.spokkartan.se/wp-content/uploads/2025/09/Herrgarden-i-Larvik.png","date":"Sat, 13 Sep","points":80,"categories":["Hemsökta Herrgårdar","Herrgården i Larvik","Larvik","Piken i karpedammen"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1878","name":"Spökjakt på Gripsholms slott med Mandy och Emmely från Spökjakter","slug":"gripsholms-slott-spokjakter","url":"https://www.spokkartan.se/hemsokta-slott/gripsholms-slott-spokjakter/","lat":59.0417,"lng":15.4507,"country":"Sverige","region":"Södermanlands Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Spökjakt+på+Gripsholms+slott+med+Mandy+och+Emmely+från+Spökjakter","teaser":"Ett av Sveriges mest mytomspunna slott öppnar sina portar. Inte för kungligheter, utan för spökjägare. Gripsholms slott i Mariefred har i århundraden väckt både beundran och rysningar. Här v","description":"Ett av Sveriges mest mytomspunna slott öppnar sina portar. Inte för kungligheter, utan för spökjägare. Gripsholms slott i Mariefred har i århundraden väckt både beundran och rysningar. Här vandrar historien genom varje korridor – från Gustav Vasas tid på 1500-talet till de otaliga berättelserna om röster, skuggor och kalla vindar i de gamla fängelsehålorna. Nattetid är stämningen annorlunda. Tystnaden lägger sig tung över de massiva murarna, och mörkret avslöjar något av slottets sanna väsen. Intervjun med Mandy och Emmely När Mandy och Emmely från Spökjakter fick beskedet att de skulle få göra en utredning på Gripsholms slott, var känslorna svåra att beskriva. “Det kändes helt osannolikt. V","img":"https://www.spokkartan.se/wp-content/uploads/2025/10/e076b9c7-1358-4d93-b9be-0a0967b0ff25.jpeg","date":"Sun, 26 Oct","points":80,"categories":["gripsholms slott","Gustav Vasa","Hemsökta Slott","Mariefred"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1887","name":"Blombacka Herrgård","slug":"blombacka-herrgard","url":"https://www.spokkartan.se/hemsokta-herrgardar/blombacka-herrgard/","lat":57.5264,"lng":14.1047,"country":"Sverige","region":"Västra Götalands Län","type":"Herrgård","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Blombacka+Herrgård","teaser":"Tystnaden, Historien och Skuggan Som Dröjer Mitt i det mjukt böljande västgötska kulturlandskapet, strax utanför Skara, ligger Blombacka herrgård. En plats som vid första ögonkastet framstår","description":"Tystnaden, Historien och Skuggan Som Dröjer Mitt i det mjukt böljande västgötska kulturlandskapet, strax utanför Skara, ligger Blombacka herrgård. En plats som vid första ögonkastet framstår som stillsam: åkrar som rör sig långsamt i vinden, en allé som leder fram till huvudbyggnaden, timmer, puts, sten, natur. Men under den lugna ytan finns lager av historia och spår av liv som en gång formade både människor och mark. Blombacka är en sådan plats som dröjer kvar – inte bara i landskapet, utan i tanken. Blombacka omnämns första gången år 1483 , då godset tillhörde Peder Bengtsson Gylta . Under århundradena som följde passerade herrgården genom flera inflytelserika släkter. Efter 1594 kom gods","img":"https://www.spokkartan.se/wp-content/uploads/2025/11/Blombacka-Herrgard-3.jpg","date":"Sun, 09 Nov","points":80,"categories":["Hemsökta Herrgårdar","Podcast","Spökjakt","Västra Götalands Län"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1905","name":"Hemsökta Platser i Västergötland","slug":"hemsokta-platser-i-vastergotland","url":"https://www.spokkartan.se/avrattningsplats/hemsokta-platser-i-vastergotland/","lat":57.3443,"lng":13.6218,"country":"Sverige","region":"Västra Götalands Län","type":"Slott","scary":4,"free":false,"bookable":true,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Hemsökta+Platser+i+Västergötland","teaser":"Västergötland är ett av Sveriges äldsta kulturlandskap. Här finns kyrkor från medeltiden, uråldriga gravfält, herrgårdar där adelns intriger ekade genom korridorerna, och slott där makt och","description":"Västergötland är ett av Sveriges äldsta kulturlandskap. Här finns kyrkor från medeltiden, uråldriga gravfält, herrgårdar där adelns intriger ekade genom korridorerna, och slott där makt och passion formade öden. Och kanske är det just därför många menar att minnen här dröjer sig kvar längre än på andra platser . I detta landskap är berättelserna inte bara historia – de lever. Nedan följer tio av de mest omtalade hemsökta platserna i landskapet. Varje plats bär på sitt eget mysterium, en egen stämning och egna röster mellan väggarna. Torpa Stenhus Torpa Stenhus Torpa Stenhus i Länghem är en av Sveriges mest mytomspunna herrgårdar, och nästan varje rum bär på en historia som vägrar lämna vägga","img":"https://www.spokkartan.se/wp-content/uploads/2025/11/Hemsokta-platser-vastergotland.jpg","date":"Mon, 10 Nov","points":80,"categories":["Avrättningsplats","Falks Grav","Göteborg","hemsökt"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1912","name":"Intervju med Jenny & Johanna – Tvillingarna som blev Borgvattnets ”veteraner”","slug":"intervju-med-jenny-johanna-tvillingarna-som-blev-borgvattnets-veteraner","url":"https://www.spokkartan.se/jamtlands-lan/intervju-med-jenny-johanna-tvillingarna-som-blev-borgvattnets-veteraner/","lat":63.098,"lng":14.4752,"country":"Sverige","region":"Jämtlands Län","type":"Prästgård","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Intervju+med+Jenny+&+Johanna+–+Tvillingarna+som+blev+Borgvattnets+”veteraner”","teaser":"Två systrar. Två barndomsminnen ingen kan förklara. En prästgård som stulit deras hjärtan – och kanske ibland deras sömn. Vi träffade Jenny och Johanna, kända i spökkretsar för sin värme, si","description":"Två systrar. Två barndomsminnen ingen kan förklara. En prästgård som stulit deras hjärtan – och kanske ibland deras sömn. Vi träffade Jenny och Johanna, kända i spökkretsar för sin värme, sitt mod och sina otaliga nätter i Borgvattnets legendariskt hemsökta Prästgård. Här berättar de om första mötet med LaxTon, varför just de inte kan hålla sig borta från Jämtlands mest omtalade hus, och vilka ögonblick som fortfarande ger dem rysningar längs ryggraden. En av era starkaste dokumenterade upplevelser? Johanna: En novemberdag hörde vi allt på samma kväll: – fotsteg – mumlande – nynnande – vissling – beröring – en stol som flyttades – ett element som stod på 30 grader (!) Och det var första gång","img":"https://www.spokkartan.se/wp-content/uploads/2025/11/613800CD-0D47-474D-8B4D-8492EC3D693F.jpg","date":"Sat, 15 Nov","points":80,"categories":["borgvattnet","borgvattnets prästgård","Hemsökt Prästgård","Jämtlands Län"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1920","name":"Garnisionssjukhuset i Karlsborg – det övergivna mönstersjukhuset där tiden (och något annat) dröjer sig kvar","slug":"garnisionssjukhuset-i-karlsborg","url":"https://www.spokkartan.se/vastra-gotalands-lan/garnisionssjukhuset-i-karlsborg/","lat":58.4517,"lng":14.129,"country":"Sverige","region":"Västra Götalands Län","type":"Övergiven","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Garnisionssjukhuset+i+Karlsborg+–+det+övergivna+mönstersjukhuset+där+tiden+(och+något+annat)+dröjer+sig+kvar","teaser":"Längst ut på Vanäs udde, insvept i stilla parklandskap och milsvid utsikt över Vättern, ligger tre byggnader som bär på mer historia – och fler rykten – än nästan någon annan plats i Karlsbo","description":"Längst ut på Vanäs udde, insvept i stilla parklandskap och milsvid utsikt över Vättern, ligger tre byggnader som bär på mer historia – och fler rykten – än nästan någon annan plats i Karlsborg. Det övergivna Garnisionssjukhuset, en gång en modern och prisbelönad vårdanläggning, står idag tyst och förfallet. Fönsterluckor slår i vinden, målflagor faller från väggarna, och den som lyssnar riktigt noggrant sägs kunna höra steg i ekande korridorer där ingen längre går. Det är ett sjukhus som både vittnar om en svunnen tid av omsorg, disciplin och militär precision – och samtidigt lockar med berättelser om det övernaturliga. För de som vågat sig in, eller för väktare som patrullerar området om nä","img":"https://www.spokkartan.se/wp-content/uploads/2025/11/Garnisonssjukhuset-Karlsborg-1.png","date":"Sun, 23 Nov","points":80,"categories":["Karlsborg","Övergivet","Västra Götalands Län"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1931","name":"Hardemo kyrka – Närkes medeltida utkikspunkt där något fortfarande rör sig i skuggorna","slug":"hardemo-kyrka","url":"https://www.spokkartan.se/kyrkogardar/hardemo-kyrka/","lat":59.3592,"lng":15.7342,"country":"Sverige","region":"Örebro Län","type":"Kyrka","scary":3,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Hardemo+kyrka+–+Närkes+medeltida+utkikspunkt+där+något+fortfarande+rör+sig+i+skuggorna","teaser":"Det börjar alltid likadant, enligt dem som bor i trakten: ett svagt knackande från någon av de gamla gravstenarna, följt av en känsla av att inte vara ensam. Andra vittnar om en mörk skepnad","description":"Det börjar alltid likadant, enligt dem som bor i trakten: ett svagt knackande från någon av de gamla gravstenarna, följt av en känsla av att inte vara ensam. Andra vittnar om en mörk skepnad som rör sig runt kyrkomuren, som om någon vakar över platsen – eller försöker ta sig därifrån. Hardemo kyrka, belägen på en höjd i det öppna jordbrukslandskapet sydväst om Kumla, är en av de mest kulturhistoriskt intressanta kyrkorna i Närke. Men lika ofta som man pratar om dess långa historia, talar man om de märkliga fenomen som fortsätter att oroa besökare än idag. Historik – en kyrka med rötter i 1100-talet Hardemo kyrka ligger i Hardemo socken i Kumla kommun och tillhör Hardemo församling i Strängnä","img":"https://www.spokkartan.se/wp-content/uploads/2025/12/Hardemo-Kyrka-1.jpg","date":"Wed, 03 Dec","points":60,"categories":["Hardemo","Hardemo kyrka","hemsökt kyrka","Kyrkogårdar"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1979","name":"Läckö slott – ett av Sveriges vackraste och mest hemsökta slott","slug":"lacko-slott","url":"https://www.spokkartan.se/hemsokta-slott/lacko-slott/","lat":61.8977,"lng":16.8321,"country":"Sverige","region":"Västernorrlands Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Läckö+slott+–+ett+av+Sveriges+vackraste+och+mest+hemsökta+slott","teaser":"Det börjar ofta med en känsla. Ett kyligt drag i nacken, ett susande ljud bakom ryggen, skuggor som rör sig i ögonvrån. På Läckö slott, där Vänerns vatten möter sten och historia, är det int","description":"Det börjar ofta med en känsla. Ett kyligt drag i nacken, ett susande ljud bakom ryggen, skuggor som rör sig i ögonvrån. På Läckö slott, där Vänerns vatten möter sten och historia, är det inte bara de gamla väggarna som viskar – här sägs det att spökena aldrig riktigt lämnat. Den vitklädda kvinnan som skrider genom slottets salar. De klagande skriken från fängelsehålan. Greven som vägrar lämna sitt livsverk. Välkommen till Läckö slott , en av de mest hemsökta platserna i Västergötland – och kanske hela Sverige. Den vita damen och kökets förbannelse Den mest kända av Läckös spökhistorier handlar om den vita damen – en klassisk gestalt i svensk folktro, men här är hon långt mer än en sägen. Fle","img":"https://www.spokkartan.se/wp-content/uploads/2026/01/1.jpg","date":"Sat, 24 Jan","points":80,"categories":["De La Guardi","Hemsökta Slott","Läckö Slott","spökslott"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-1993","name":"Brahehus, ruinen vid Vätterns kant","slug":"brahehus-ruinen-vid-vatterns-kant","url":"https://www.spokkartan.se/jonkopings-lan/brahehus-ruinen-vid-vatterns-kant/","lat":58.5299,"lng":14.35,"country":"Sverige","region":"Jönköpings Län","type":"Ruin","scary":3,"free":false,"bookable":false,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Brahehus,+ruinen+vid+Vätterns+kant","teaser":"Högt ovanför Vättern, på en brant klippa strax norr om Gränna, ligger ruinen av Brahehus. Det som i dag är en stillsam och välbesökt utsiktsplats var en gång ett storslaget slottsbygge. Brah","description":"Högt ovanför Vättern, på en brant klippa strax norr om Gränna, ligger ruinen av Brahehus. Det som i dag är en stillsam och välbesökt utsiktsplats var en gång ett storslaget slottsbygge. Brahehus började uppföras år 1637 på initiativ av Per Brahe den yngre . Slottet stod färdigt först på 1650-talet och var tänkt som änkesäte, men kom i stället att användas för att ta emot gäster. Byggnaden bestod av en hög huvuddel vid klippkanten och två hörntorn, med vidsträckt utsikt över Vättern, Visingsö och Gränna. Efter Per Brahes död tömdes slottet på inredning. År 1708 bröt en brand ut i byn Uppgränna, och elden spred sig till Brahehus. Slottet brann ner till grunden och blev den ruin vi ser i dag. P","img":"https://www.spokkartan.se/wp-content/uploads/2026/02/Brahe-Hus2.jpg","date":"Sat, 14 Feb","points":60,"categories":["Brahehus","Gränna","Jönköpings Län","Ruiner"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"wp-2006","name":"Vadstena Klosterhotell","slug":"vadstena-klosterhotell","url":"https://www.spokkartan.se/hemsokta-hotell/vadstena-klosterhotell/","lat":58.4775,"lng":16.2151,"country":"Sverige","region":"Östergötlands Län","type":"Hotell","scary":4,"free":false,"bookable":true,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Vadstena+Klosterhotell","teaser":"Vadstena Klosterhotell är inrymt i byggnader som tillhör Vadstena kloster , grundat på 1300-talet enligt ordensregler utformade av Heliga Birgitta . Klosterområdet har använts nästan kontinu","description":"Vadstena Klosterhotell är inrymt i byggnader som tillhör Vadstena kloster , grundat på 1300-talet enligt ordensregler utformade av Heliga Birgitta . Klosterområdet har använts nästan kontinuerligt i över 600 år, vilket gör platsen ovanligt väl lämpad för att studera återkommande berättelser om oförklarliga fenomen i relation till historisk miljö. Klosterbyggnaden och dess funktion över tid Vadstena kloster uppfördes som ett så kallat dubbelkloster, med tydligt åtskilda delar för nunnor och munkar. Arkitekturen präglas av långa korridorer, slutna rum och få öppna ytor – utformad för disciplin, tystnad och kontroll. Redan under medeltiden bedrevs här både sjukvård och omhändertagande av pilgri","img":"https://www.spokkartan.se/wp-content/uploads/2026/02/59B0EDB8-8D2B-4262-B01D-D2BB8F0714FF.jpg","date":"Sat, 28 Feb","points":80,"categories":["hemsökta hotell","Hemsökta Hotell","hemsökthotell","Östergötlands Län"],"featured":false,"new":false,"status":"published","img_credit":"Spökkartan.se","img_author":"Fredrik Lundberg"},{"id":"new-hultaby-herrgard","name":"Hultaby Herrgård","slug":"hultaby-herrgard","url":"https://spokkartan.se/new-hultaby-herrgard","lat":57.7224,"lng":13.8601,"country":"Sverige","region":"Jönköpings Län","type":"Herrgård","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Sju svartklädda herrar i höga hattar anlände i ett ekipage av kolsvarta hästar — och godsägaren dog samma natt.","description":"Hultaby herrgård i Vetlanda sägs vara hemsökt sedan en mystisk natt i historiens dunkel. Knackningar och stönanden hörs från ena delen av huset. Legenden berättar om ett ekipage draget av kolsvarta hästar som stannade framför herrgården vid midnatt. Sju svartklädda herrar i höga hattar klev ur, gick in i huset, och försvann sedan i tomma intet. Samma natt dog godsägaren. Herrgården byggdes på 1700-talet.","img":"https://spokhus.se/wp-content/uploads/2015/10/hultaby-sateri-300x227.jpg","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published","img_credit":"Wikimedia Commons","img_author":""},{"id":"new-husby-sateri","name":"Husby Säteri","slug":"husby-sateri","url":"https://spokkartan.se/new-husby-sateri","lat":59.0073,"lng":16.2584,"country":"Sverige","region":"Södermanlands Län","type":"Herrgård","scary":3,"free":false,"bookable":false,"bookingUrl":"","teaser":"Det gamla säteriet i Södermanland där oförklarliga ljud och en grå gestalt hemsöker de gamla salarna.","description":"Husby säteri i Södermanland är ett historiskt herresäte med anor från 1600-talet. Personal och besökare har vittnat om oförklarliga ljud, steg som inte kan kopplas till någon levande person och en grå gestalt som visat sig i de gamla salarna. Platsen har ett rykte som en av länets mer anonyma men genuint hemsökta platser.","img":"","date":"Apr 2026","points":60,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-hackeberga-slott","name":"Häckeberga Slott","slug":"hackeberga-slott","url":"https://spokkartan.se/new-hackeberga-slott","lat":55.61,"lng":13.408,"country":"Sverige","region":"Skåne Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Rige Holgers avhuggna huvud sitter fastsurrat vid kroppen när hans vålnad irrar om slottet. Hans hustru drunknade i Fruasjön.","description":"Häckeberga slott söder om Dalby i Skåne huserar en av landets mest kusliga vålnader. På 1300-talet härskade feodalherren Helge Gregorson Ulvstrand, kallad Rige Holger, och kallade sig \"Lille kungen av Skåne\". Den danske kungen lät halshugga honom. Men Rige Holger kunde inte skiljas från sina ägor — hans vålnad med det avhuggna huvudet fastsurrat vid kroppen irrar fortfarande i slottet. I den angränsande skogstjärnen, Fruasjön, spökar hans hustru som i förtvivlan drunknade sig.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-haggsjoviks-gamla-skola","name":"Häggsjöviks Gamla Skola","slug":"haggsjoviks-gamla-skola","url":"https://spokkartan.se/new-haggsjoviks-gamla-skola","lat":62.6059,"lng":17.0712,"country":"Sverige","region":"Västernorrlands Län","type":"Övergiven","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Den övergivna skolbyggnaden vid Häggsjövik — barnens skratt hörs fortfarande i de tomma klassrummen.","description":"Den gamla skolan vid Häggsjövik i Norrland har stått övergiven i årtionden. Besökare rapporterar om ljud från tomma klassrum: skratt, steg och en känsla av att barn fortfarande befinner sig i byggnaden. Skolans historia är tragiskt kopplad till en olycka som drabbade ortens barn, och platsen anses av lokalborna vara genuint hemsökt.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-hallabrottet","name":"Hällabrottet","slug":"hallabrottet","url":"https://spokkartan.se/new-hallabrottet","lat":59.05,"lng":16.22,"country":"Sverige","region":"Södermanlands Län","type":"Övergiven","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Det övergivna kalkbrottet i Södermanland — här hördes rop och skrik länge efter olyckan.","description":"Hällabrottet i Södermanland är ett nedlagt kalkbrott med en mörk historia. Olyckor och dödsfall under brytningens era har satt spår i platsen. Lokala vittnen beskriver hur rop och skrik hörts från de tomma bergsskärningarna, och en tung, tryckande atmosfär präglar platsen — särskilt när dimma lägger sig över de öppna stenformationerna.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-hjortsberga-prastgard","name":"Hjortsberga Prästgård","slug":"hjortsberga-prastgard","url":"https://spokkartan.se/new-hjortsberga-prastgard","lat":56.18,"lng":15.23,"country":"Sverige","region":"Blekinge Län","type":"Prästgård","scary":5,"free":false,"bookable":false,"bookingUrl":"","teaser":"Hästarna från ridskolan vägrar passera huset. Prästen Bengt Randolfson såg ett spöke och tvingades fly.","description":"Hjortsberga prästgård nära Johannishus i Blekinge är så hemsökt att hästar från den angränsande ridskolan vägrar passera byggnaden. Komminister Bengt Randolfson berättade om steg i trapporna utan synlig orsak, dörrhandtag som trycktes ner av osynliga händer och böcker som föll från hyllor av sig själva. En reporter upplevde att dörrklockan ringde oavbrutet med ingen utanför. Hunden i huset blev som vansinnig. Till slut stod inte Randolfson ut och tvingades flytta.","img":"","date":"Apr 2026","points":100,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-haverödals-kvarn","name":"Häverödals Kvarn och Såg","slug":"haverödals-kvarn","url":"https://spokkartan.se/new-haverödals-kvarn","lat":59.98,"lng":18.6,"country":"Sverige","region":"Stockholms Län","type":"Övergiven","scary":3,"free":false,"bookable":false,"bookingUrl":"","teaser":"Den förfallna kvarnbyggnaden vid Hallstavik — inga verksamheter lever kvar, men något annat gör det.","description":"Häverödals kvarn och såg vid Hallstavik är en kvarnbyggnad som förfallit under lång tid. Platsen saknar sedan länge all verksamhet men det sägs att en osynlig närvaro dröjer kvar bland de gamla kvarnhjulen. Besökare beskriver plötsliga kalla drag, ljud av mekanik som tycks röra sig i den tomma byggnaden och en känsla av att iakttas.","img":"","date":"Apr 2026","points":60,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-kalmar-slott","name":"Kalmar Slott","slug":"kalmar-slott","url":"https://spokkartan.se/new-kalmar-slott","lat":56.66,"lng":16.365,"country":"Sverige","region":"Kalmar Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Vita frun räddade barn från att bli inlåsta — och vandrar fortfarande i de gamla salarna.","description":"Kalmar slott är ett av Sveriges bäst bevarade renässansslott med anor från 1100-talet. Den mest kända legenden handlar om den vita frun som räddade barn från att bli inlåsta i slottet. Besökare och personal har vittnat om hennes närvaro i de gamla salarna och tornen. Slottet har genomgått otaliga krig, belägringar och dramatiska händelser som enligt tradition lämnat andliga spår.","img":"https://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/Kalmar_castle.jpg/800px-Kalmar_castle.jpg","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published","img_credit":"Wikimedia Commons — CC BY-SA","img_author":"Wikimedia Commons"},{"id":"new-lindenborgssjön","name":"Lindenborgssjön","slug":"lindenborgssjön","url":"https://spokkartan.se/new-lindenborgssjön","lat":55.92,"lng":13.15,"country":"Sverige","region":"Skåne Län","type":"Övergiven","scary":3,"free":false,"bookable":false,"bookingUrl":"","teaser":"Vid den mystiska sjön i Skåne rapporteras mörka gestalter glida över vattnet i gryningen.","description":"Lindenborgssjön i Skåne är känd bland lokalborna för sina kusliga rykten. Mörka gestalter ska glida över vattnet i gryningen, och flera vittnen har berättat om hur deras hund plötsligt frostat och vägrat komma nära strandlinjen. Platsen har en lång historia av vattendunkna händelser och ouppklarade försvinnanden.","img":"","date":"Apr 2026","points":60,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-lis-jon-fivelstad","name":"Lis Jon i Fivelstad","slug":"lis-jon-fivelstad","url":"https://spokkartan.se/new-lis-jon-fivelstad","lat":58.35,"lng":15.1,"country":"Sverige","region":"Östergötlands Län","type":"Övergiven","scary":3,"free":false,"bookable":false,"bookingUrl":"","teaser":"Vid den mytomspunna graven i Fivelstad sägs det alltid ligga färska blommor — vem som lägger dit dem vet ingen.","description":"Lis Jon i Fivelstad, Östergötland, är en av de märkligaste mysterierna i trakten. Vid en gammal grav eller minnessten lägger okända händer regelbundet nya blommor — mitt i natten, utan att någon sett vem. Ortsbor har bevakat platsen utan att kunna förklara fenomenet. En lokal legend berättar om en kvinna som dog tragiskt och vars ande fortfarande vakar över platsen.","img":"","date":"Apr 2026","points":60,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-lunds-domkyrka","name":"Lunds Domkyrka","slug":"lunds-domkyrka","url":"https://spokkartan.se/new-lunds-domkyrka","lat":55.705,"lng":13.194,"country":"Sverige","region":"Skåne Län","type":"Kyrka","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Finn och hans hustru finns inmurade i kryptan — legenden om jätten som byggde kyrkan och hans fasansfulla öde.","description":"Lunds domkyrka, invigd 1145, är en av Nordens äldsta och mest imponerande katedraler. Legenden berättar om jätten Finn som hjälpte till att bygga kyrkan mot löfte om biskopens ögon eller hans namn. Biskopen list räddade honom — men Finn rasade och rusade ner i kryptan med sin hustru och barn. Sedan dess sägs deras vålnader vara inmurade djupt i kyrkans grundmurar. Besökare rapporterar om kall luft och en tryckt känsla i kryptan.","img":"https://upload.wikimedia.org/wikipedia/commons/thumb/b/b3/Lunds_domkyrka.jpg/800px-Lunds_domkyrka.jpg","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published","img_credit":"Wikimedia Commons — CC BY-SA","img_author":"Arild Vågen"},{"id":"new-medevi-brunn","name":"Medevi Brunn","slug":"medevi-brunn","url":"https://spokkartan.se/new-medevi-brunn","lat":58.56,"lng":14.805,"country":"Sverige","region":"Östergötlands Län","type":"Hotell","scary":3,"free":false,"bookable":false,"bookingUrl":"","teaser":"Sveriges äldsta kurort med anor från 1678 — och andar som aldrig lämnade badsällskapets tid.","description":"Medevi Brunn vid Vätterns strand är Sveriges äldsta kurort, grundad 1678 av Urban Hjärne. I mer än 300 år har gäster sökt hälsa vid källorna. Men somliga lämnade aldrig platsen. Besökare i de äldsta byggnaderna vittnar om figurer klädda i 1700-talsdräkter, ljud av minuetter från tomma salar och en känsla av dammig, gammal tid som dröjer sig kvar på ett sätt som inte kan förklaras.","img":"","date":"Apr 2026","points":60,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-noors-slott","name":"Noors Slott","slug":"noors-slott","url":"https://spokkartan.se/new-noors-slott","lat":59.8,"lng":17.57,"country":"Sverige","region":"Uppsala Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Den unge greve Fersen dog tragiskt och hans ande sägs vaka över slottet vid Fyrisån.","description":"Noors slott vid Fyrisån norr om Uppsala är ett barockslott byggt på 1690-talet. Slottet är kopplat till den tragiska historien om greve Axel von Fersen och hans familj. En yngre familjemedlem dog under oklara omständigheter och berättelsen om hans osaliga ande som söker rättvisa lever kvar bland slottets tjänare och gäster. Fotsteg hörs i oinredda rum och temperaturen sjunker utan förklaring.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-norra-kyrketorps-kyrka","name":"Norra Kyrketorps Kyrka","slug":"norra-kyrketorps-kyrka","url":"https://spokkartan.se/new-norra-kyrketorps-kyrka","lat":58.05,"lng":13.65,"country":"Sverige","region":"Västra Götalands Län","type":"Kyrka","scary":3,"free":false,"bookable":false,"bookingUrl":"","teaser":"En röst som läser högt ur bibeln hörs från den tomma kyrkan — prästen som aldrig slutade mässan.","description":"Norra Kyrketorps kyrka i Västergötland bär på berättelsen om en gammal präst som dog mitt under en gudstjänst och aldrig lät sin mässa avbrytas. Kyrkvaktmästare och besökare har hört en svag röst läsa högt inifrån den tomma och låsta byggnaden, och fotsteg följer besökare längs det gamla kyrkogolvet.","img":"","date":"Apr 2026","points":60,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-nyköpingshus","name":"Nyköpingshus","slug":"nyköpingshus","url":"https://spokkartan.se/new-nyköpingshus","lat":58.752,"lng":17.007,"country":"Sverige","region":"Södermanlands Län","type":"Fästning","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Birger Jarl kastade sina bröder i fängelsehålan 1317 — de hungerdöda bröderna söker fortfarande frihet.","description":"Nyköpingshus är platsen för ett av svensk historias mörkaste brott. År 1317 lät Birger Jarl fängsla sina bröder hertigarna Erik och Valdemar i slottets torn och kastade nyckeln i Nyköpingsån. Bröderna svalt ihjäl. Sedan dess berättas det om ljud från det gamla fängelsetornet, om en kall hand som griper tag om besökarnas axlar och om skuggor som rör sig längs källarvalven på natten.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-nasby-slott","name":"Näsby Slott","slug":"nasby-slott","url":"https://spokkartan.se/new-nasby-slott","lat":59.475,"lng":18.09,"country":"Sverige","region":"Stockholms Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Festernas slott i Täby — men mitt i jublet pågår något mystiskt och oförklarligt i de gamla salarna.","description":"Näsby slott, även kallat Festernas slott, ligger i Täby utanför Stockholm. Här arrangeras fester och finaler i kokstävlingar, men gäster och personal vittnar om oförklarliga fenomen: dörrar som öppnas utan synlig orsak, kalla drag i slutna rum och en kuslig närvaro som upplevs i de äldsta delarna av byggnaden. Slottet har en dramatisk historia med koppling till 1700-talets adel.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-onsala-kyrka","name":"Onsala Kyrka","slug":"onsala-kyrka","url":"https://spokkartan.se/new-onsala-kyrka","lat":57.404,"lng":12.03,"country":"Sverige","region":"Hallands Län","type":"Kyrka","scary":3,"free":false,"bookable":false,"bookingUrl":"","teaser":"Den medeltida kyrkan vid havet i Halland — sjömännen som aldrig återvände hemsöker fortfarande koret.","description":"Onsala kyrka med anor från medeltiden ligger vid Kattegattskusten i Halland. Generationer av sjömän välsignades här inför långa resor — och många återvände aldrig. Lokalbefolkningen berättar om ljud av sjömansvisa från den tomma kyrkan, fotsteg i koret mitt i natten och en tung känsla som präglar platsen under stormar.","img":"","date":"Apr 2026","points":60,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-ramsbergsgarden","name":"Ramsbergsgården","slug":"ramsbergsgarden","url":"https://spokkartan.se/new-ramsbergsgarden","lat":59.68,"lng":14.77,"country":"Sverige","region":"Örebro Län","type":"Herrgård","scary":3,"free":false,"bookable":false,"bookingUrl":"","teaser":"Den gamla gården i Bergslagen där en förbannad godsägares ande fortfarande håller vakt.","description":"Ramsbergsgården i Bergslagen är en historisk gård med koppling till den gamla järnhanteringen i trakten. En av de tidigare ägarna — känd för sin hårda hand mot torparna — skall enligt sägnen ha förbannats på dödsbädden och vandrar fortfarande i byggnaden. Steg hörs tidigt på morgonen, dörrar slår igen och det sägs att en ovanlig lukt av rök ibland sprider sig utan orsak.","img":"","date":"Apr 2026","points":60,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-rankhyttans-herrgard","name":"Rankhyttans Herrgård","slug":"rankhyttans-herrgard","url":"https://spokkartan.se/new-rankhyttans-herrgard","lat":60.21,"lng":15.1,"country":"Sverige","region":"Dalarnas Län","type":"Herrgård","scary":5,"free":false,"bookable":false,"bookingUrl":"","teaser":"Svarta damen, gårdskarlen Rune och jägmästaren Dybeck spökar — täcket slades ner för trapporna mitt i natten.","description":"Rankhyttans herrgård är byggd på ett gråstensvalv från medeltiden. Anders Persson halshöggs 1534 efter klockupproret. Nu spökar hans fru — Svarta damen — i herrgården. Gårdskarlen Rune och jägmästaren Dybeck, som tog livet av sig på gården, sägs också gå igen. En gäst som skrävlade om sin otro vaknade med täcket bortsläpat nerför trapporna.","img":"","date":"Apr 2026","points":100,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-rasta-odeshog","name":"Rasta i Ödeshög","slug":"rasta-odeshog","url":"https://spokkartan.se/new-rasta-odeshog","lat":58.22,"lng":14.66,"country":"Sverige","region":"Östergötlands Län","type":"Övergiven","scary":3,"free":false,"bookable":false,"bookingUrl":"","teaser":"Den gamla rastplatsen vid Vättern där olyckliga vägfarare aldrig verkar ha lämnat platsen.","description":"Rasta vid Ödeshög längs Vätterns västra strand är känd bland lokalbefolkningen för sina kusliga berättelser. Vägfarare som stannat vid platsen under de gångna seklen har ibland inte återvänt. En gammal sägen talar om en gästgivargård på platsen där gäster försvann. Moderna besökare rapporterar om en obehaglig känsla som driver dem att snabbt fortsätta sin resa.","img":"","date":"Apr 2026","points":60,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-riksvag-50-borlange","name":"Riksväg 50 mot Borlänge","slug":"riksvag-50-borlange","url":"https://spokkartan.se/new-riksvag-50-borlange","lat":60.43,"lng":15.46,"country":"Sverige","region":"Dalarnas Län","type":"Urban","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Riksväg 50 — Dalarnas mest hemsökta vägsträcka. Förarna ser gestalter som kliver ut mitt i natten.","description":"Riksväg 50 norrut mot Borlänge i Dalarna har ett ihårdigt rykte bland lastbilsförare och nattbilister. Gestalter som kliver ut på vägbanan, bilar som varnar för hinder som inte finns och en känsla av att inte vara ensam i bilen — särskilt vid en viss sträcka nära ett gammalt gravfält. Minst tre olösta trafikolyckor med försvinnanden kopplas till vägen.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-schefflerska-palatset","name":"Schefflerska Palatset","slug":"schefflerska-palatset","url":"https://spokkartan.se/new-schefflerska-palatset","lat":59.315,"lng":18.063,"country":"Sverige","region":"Stockholms Län","type":"Spökhus","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Det storstilade 1600-talspalatset på Södermalm — Silverkammaren dit ingen personal vill gå ensam.","description":"Schefflerska palatset på Södermalm i Stockholm är ett 1600-talspalats som blivit populärt för festarrangemang och middagar. Men bakom fashionabla fasader döljer sig mystiska ljud och framför allt Silverkammaren — ett rum som ingen ur personalen vill beträda ensam. Fenomen som förflyttade föremål, oförklarliga ljud och en osynlig närvaro rapporteras regelbundet.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-skanskvarnen","name":"Skanskvarnens Kvarn","slug":"skanskvarnen","url":"https://spokkartan.se/new-skanskvarnen","lat":59.317,"lng":18.077,"country":"Sverige","region":"Stockholms Län","type":"Övergiven","scary":3,"free":false,"bookable":false,"bookingUrl":"","teaser":"Den gamla kvarnen på Södermalm — murarna bär minnen av de som slitit och dött här.","description":"Skanskvarnens kvarnbyggnad på Södermalm i Stockholm är en historisk rest av den gamla kvarnen. Byggnaden har bevarat spår från en tid då hundratals människor slitit sig igenom ett hårt liv. Besökare i de delar som fortfarande är tillgängliga rapporterar om känslan av att inte vara ensam och om plötsliga temperatursänkningar utan förklaring.","img":"","date":"Apr 2026","points":60,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-skottorps-slott","name":"Skottorps Slott","slug":"skottorps-slott","url":"https://spokkartan.se/new-skottorps-slott","lat":56.62,"lng":12.72,"country":"Sverige","region":"Hallands Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Den vita damen vid Skottorps slott visar sig för dem som snart skall dö — en förbannelse från adelstiden.","description":"Skottorps slott i Halland är ett renässansslott med anor från 1500-talet. En vit dam sägs visa sig vid slottets fönster och trappor — enligt folktron ett varsel om dödsfall. Berättelsen om en olycklig adelskvinna som dog under omständigheter som aldrig fullt ut klarlagts har bitit sig fast i slottets murar och i bygdens minne.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-skrackshulta","name":"Skråckhulta","slug":"skrackshulta","url":"https://spokkartan.se/new-skrackshulta","lat":57.02,"lng":15.13,"country":"Sverige","region":"Kronobergs Län","type":"Övergiven","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Ortens namn avslöjar allt — Skråckhulta, platsen där skräcken bor. En gammal gård med ett dunkelt förflutet.","description":"Skråckhulta i Kronobergs län bär redan i sitt namn spåren av en mörk historia. Den gamla gården på platsen har länge ansetts hemsökt — hästarna vägrar stanna, hundar ylar utan anledning och ortsborna undviker platsen efter mörkrets fall. Exakt vad som hände här är inte dokumenterat men berättelserna om platsens ondska har gått i arv i generationer.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-skarbegs-lanthandel","name":"Skärbergs Lanthandel","slug":"skarbegs-lanthandel","url":"https://spokkartan.se/new-skarbegs-lanthandel","lat":58.72,"lng":13.2,"country":"Sverige","region":"Värmlands Län","type":"Spökhus","scary":3,"free":false,"bookable":false,"bookingUrl":"","teaser":"Den nedlagda lanthandeln i Värmland — den gamla handelsdisken där köpmannen tros stå kvar.","description":"Skärbergs lanthandel i Värmland är en nedlagd affär vars sista ägare enligt sägnen aldrig riktigt lämnade platsen. Personal som försökt sanera och rensa byggnaden vittnar om hur föremål återvänder till sina gamla platser, lampor tänds av sig själva och hur de hört en knarrande röst bakom den gamla disken.","img":"","date":"Apr 2026","points":60,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-snogeholms-slott","name":"Snogeholms Slott","slug":"snogeholms-slott","url":"https://spokkartan.se/new-snogeholms-slott","lat":55.63,"lng":13.58,"country":"Sverige","region":"Skåne Län","type":"Slott","scary":3,"free":false,"bookable":false,"bookingUrl":"","teaser":"Det vackra slottet i Skåne med den gröna sjön — och en adelsdam vars kärlek kostade henne livet.","description":"Snogeholms slott i Skåne omges av en pittoresk sjö. Bakom den vackra fasaden gömmer sig en tragisk kärlekshistoria från 1700-talet — en adelsdam vars kärlek till en man av lägre stånd ledde till hennes tragiska öde. Besökare rapporterar om en tunn, sorgsen gestalt som skymtas vid sjöns kant och om hur sorgsna toner från ett gammalt cembalo hörs i de övre salarna.","img":"","date":"Apr 2026","points":60,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-sperlingsholms-slott","name":"Sperlingsholms Slott","slug":"sperlingsholms-slott","url":"https://spokkartan.se/new-sperlingsholms-slott","lat":57.02,"lng":12.59,"country":"Sverige","region":"Hallands Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Riddaren som avrättades för förräderi vandrar fortfarande i fästningens källarvalv.","description":"Sperlingsholms slott i Halland är ett av länets mer anonyma men genuint hemsökta slott. En riddare som anklagades och avrättades för förräderi mot kronan under 1600-talets krig lämnade sin mörka historia i slottets murar. Källarvalven anses vara den mest aktiva platsen — kalla drag, fotsteg och en känsla av fångenskapens tyngd präglar rummen.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-stromsund-hotel-grand","name":"Strömstund Hotell Grand","slug":"stromsund-hotel-grand","url":"https://spokkartan.se/new-stromsund-hotel-grand","lat":63.85,"lng":15.55,"country":"Sverige","region":"Jämtlands Län","type":"Hotell","scary":4,"free":false,"bookable":true,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Strömstund+hotell","teaser":"Norrlands grand hotell med en evigt återkommande gäst — den gamles fotsteg hörs i korridoren varje midnatt.","description":"Hotell Grand i Strömsund är Norrlands stolta historiska hotell. Men en av de tidiga stammisarna lämnade aldrig. Varje midnatt hörs fotsteg i den övre korridoren — steg som tillhör en äldre man i välputsade skor, enligt vittnen. Personalen har vant sig, men nygäster somnar inte lätt.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-styggens-stuga","name":"Styggens Stuga","slug":"styggens-stuga","url":"https://spokkartan.se/new-styggens-stuga","lat":59.56,"lng":13.28,"country":"Sverige","region":"Värmlands Län","type":"Spökhus","scary":5,"free":false,"bookable":false,"bookingUrl":"","teaser":"Stugans namn avslöjar allt — den ondas boning i Värmlands skogar. Hit vänder man inte tillbaka med hela sinnet.","description":"Styggens stuga djupt inne i Värmlands skogar är en plats som bär ett namn som ortsborna tog på allvar. Stuggen — ett ord för djävulen i gammal dialekt — sägs ha valt denna plats som sin tillhåll. De som besökt stugan berättar om en total förändring av sinnesstämning vid ankomst: ångest, panik och en känsla av att vara bevakad av något ondskefullt och avsiktligt.","img":"","date":"Apr 2026","points":100,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-svaneholms-slott","name":"Svaneholms Slott","slug":"svaneholms-slott","url":"https://spokkartan.se/new-svaneholms-slott","lat":55.73,"lng":13.55,"country":"Sverige","region":"Skåne Län","type":"Slott","scary":4,"free":false,"bookable":true,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Svaneholms+Slott","teaser":"En tragisk baronessa och hennes sista natt på Svaneholms slott — spegeln i det blå rummet visar fortfarande hennes ansikte.","description":"Svaneholms slott i Skåne, byggt på 1500-talet, är känt för berättelsen om en baronessa vars sista natt i slottet slutade med en ouppklarad tragedi. Spegeln i det blå rummet sägs visa hennes ansikte för den som tittar tillräckligt länge — inte alltid direkt, men alltid till slut. Slottet erbjuder guidade spökvandringar för den modige.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-tyresto-slott","name":"Tyresö Slott","slug":"tyresto-slott","url":"https://spokkartan.se/new-tyresto-slott","lat":59.218,"lng":18.213,"country":"Sverige","region":"Stockholms Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Lilla Axel, bara två år gammal, gråter fortfarande i Sjöflygeln — vanvårdad av guvernanterna, inte förlåten av historien.","description":"Tyresö slott utanför Stockholm ägs av Nordiska museet. Den mest kända spökhistorien handlar om lille Axel, ett litet barn som dog tragiskt efter att ha vanvårdats av sina guvernanter. Hans gråt hörs fortfarande i Sjöflygeln av gäster och personal. En känsla av ett litet barns kalla närvaro har rapporterats av flertalet besökare som vistats i de berörda rummen.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-ulvhalls-herrgard","name":"Ulvhälls Herrgård","slug":"ulvhalls-herrgard","url":"https://spokkartan.se/new-ulvhalls-herrgard","lat":59.32,"lng":17.04,"country":"Sverige","region":"Södermanlands Län","type":"Herrgård","scary":4,"free":false,"bookable":true,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Ulvhälls+Herrgård","teaser":"Den gråklädda äldre damen i biljardrummet — hon slamrar med besticken när personalen stressar.","description":"Ulvhälls herrgård utanför Strängnäs är välkänt bland hotellpersonal för sin mystiska gäst. En äldre kvinna i grå klädsel visar sig i biljardrummet, oftast eftermiddagstid. Enligt sägnen är det en adelsdam av lägre börd vars man dog och lämnade henne utan hem. Hon byter ut ljusstakar nattetid och slamrar med besticken vid dukning — mest om personalen stressar.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-umedalen-mentalsjukhus","name":"Umedalens Mentalsjukhus","slug":"umedalen-mentalsjukhus","url":"https://spokkartan.se/new-umedalen-mentalsjukhus","lat":63.79,"lng":20.19,"country":"Sverige","region":"Västerbottens Län","type":"Sanatorium","scary":5,"free":false,"bookable":false,"bookingUrl":"","teaser":"En av norra Sveriges största institutioner för psykiskt sjuka — idag en skulpturpark där skuggorna rör sig.","description":"Umedalen utanför Umeå var en gång hem för hundratals patienter vid Piteå sjukhus och asyl — i 1950-talets topp 800 patienter. Lobotomi och elektrochock tillämpades. Idag är delar av området omvandlat till en skulpturpark, men de äldre byggnaderna bär på en tung historia. Besökare rapporterar om skuggor som rör sig i skulpturmiljön och röster från de gamla paviljongerna.","img":"","date":"Apr 2026","points":100,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-uppsala-gamla-kyrkogard","name":"Uppsala Gamla Kyrkogård","slug":"uppsala-gamla-kyrkogard","url":"https://spokkartan.se/new-uppsala-gamla-kyrkogard","lat":59.858,"lng":17.631,"country":"Sverige","region":"Uppsala Län","type":"Kyrkogård","scary":3,"free":false,"bookable":false,"bookingUrl":"","teaser":"Gamla Uppsala begravningsplats där riken reste och föll — de döda kungarna vaknar till liv i skymningen.","description":"Uppsala gamla kyrkogård i domkyrkans skugga är en av Sveriges historiskt tyngsta begravningsplatser. Kungar, biskopar och lärda vilar här. Vid skymningen, när ljuset bryter mot de gamla gravstenarna, har besökare vittnat om gestalter som rör sig längs de gamla gångarna — inte riktigt genomskinliga, inte riktigt solida. En närvaro som inte vill störas.","img":"","date":"Apr 2026","points":60,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-varbergs-fastning","name":"Varbergs Fästning","slug":"varbergs-fastning","url":"https://spokkartan.se/new-varbergs-fastning","lat":57.106,"lng":12.248,"country":"Sverige","region":"Hallands Län","type":"Fästning","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Bohuslänska fästningen med Bältespännarens mumie — den mördade mannens identity förblir ett mysterium.","description":"Varbergs fästning vid det hav som en gång var dansk mark rymmer en av historiens märkligaste fynd: en välbevarad mumie känd som Bältespännaren, hittad i ett torvmossar. Hans identity och dödsorsak är fortfarande okänd. Fästningen har en lång historia av krig och fångenskap. Vakter och nattanställda rapporterar om fotsteg, skuggor och en frusen känsla i de underjordiska kasematterna.","img":"https://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/Varberg_fortress.jpg/800px-Varberg_fortress.jpg","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published","img_credit":"Wikimedia Commons — CC BY-SA","img_author":"Wikimedia Commons"},{"id":"new-varnhems-prastgard","name":"Varnhems Prästgård","slug":"varnhems-prastgard","url":"https://spokkartan.se/new-varnhems-prastgard","lat":58.38,"lng":13.66,"country":"Sverige","region":"Västra Götalands Län","type":"Prästgård","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Cisterciensmunkarna från Varnhems kloster hemsöker prästgårdens källarvalv nattetid.","description":"Varnhems prästgård vid det berömda cisterciensklostret i Västergötland delar historia med en av Sveriges äldsta klostermiljöer. Munkarna begravdes i tusentals i klosterkyrkans golv och mark. Det sägs att munkarnas andar inte fann ro och att de vandrar i prästgårdens källarvalv, sjunger sina laudes i tystnaden och lämnar iskalla luftfläktar bakom sig.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-von-echstedtska-garden","name":"Von Echstedtska Gården","slug":"von-echstedtska-garden","url":"https://spokkartan.se/new-von-echstedtska-garden","lat":58.55,"lng":15.8,"country":"Sverige","region":"Östergötlands Län","type":"Herrgård","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Den rika köpmansfamiljens herrgård i Östergötland — en häxanklagad husfrugårs fortfarande runt om nätterna.","description":"Von Echstedtska gården i Östergötland är en välbevarad herrgård vars historia sträcker sig till 1600-talets handelseliter. En av gårdens tidiga husfruar anklagades för häxeri — aldrig dömd, men stigmatiserad för livet. Hennes osaliga ande sägs fortfarande röra sig genom de gamla trärummen, särskilt i de mörkare kvällstimmarna.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-vastana-slott","name":"Västanå Slott","slug":"vastana-slott","url":"https://spokkartan.se/new-vastana-slott","lat":57.87,"lng":14.48,"country":"Sverige","region":"Jönköpings Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Slottet vid sjön i Grännatrakten — den drunknande adelsdamen syns vid stranden när dimman lägger sig.","description":"Västanå slott vid sjön i Jönköpings läns natur är en romantisk bygdadel med en melankolisk historia. En ung adelsdam drunknade i sjön intill slottet under omständigheter som aldrig klarlagts. Vid dimma och skymning skymtas hennes vita gestalt vid strandbrinken, alltid vändandes mot vattnet, aldrig mot det som kallas hem.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-wenngarns-slott","name":"Wenngarns Slott","slug":"wenngarns-slott","url":"https://spokkartan.se/new-wenngarns-slott","lat":59.62,"lng":17.55,"country":"Sverige","region":"Stockholms Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Greve Magnus Gabriel De la Gardie och hans älskarinnas tragiska öde lever kvar i slottets djupaste rum.","description":"Wenngarns slott i Sigtuna-trakten är ett av de magnifika 1600-talsslotten kopplade till greve Magnus Gabriel De la Gardie. En kärlekshistoria med tragisk utgång sägs ha resulterat i att en ung kvinna dog inom slottets väggar. Hennes sorgliga presence rapporteras i de undre rummen — en tyst sorg snarare än terror, men oundviklig för den som lyssnar.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-angso-slott","name":"Ängsö Slott","slug":"angso-slott","url":"https://spokkartan.se/new-angso-slott","lat":59.44,"lng":16.9,"country":"Sverige","region":"Västmanlands Län","type":"Slott","scary":5,"free":false,"bookable":false,"bookingUrl":"","teaser":"Hunden Cotillion letar sin matte om natten. Hovnarren i grå kappa. Brita Bååt skrider kl 20 genom balsalen — varje kväll.","description":"Ängsö slott på en ö i Mälaren med anor från 1480-talet anses vara ett av Sveriges mest beryktade spökslott. Hunden Cotillion rör sig nattetid och letar efter grevinnans Sophie Piper. Hovnarren Anders Luxemburg i grå kappa syns, nästan 300 år efter sin död. Och klockan åtta varje kväll skrider en kvinna — Brita Bååt, som skrämdes till döds av osaliga andar — genom Kungapalatsrummet in i balsalen. Till och med djävulen har besökt Ängsö.","img":"","date":"Apr 2026","points":100,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-orenas-slott","name":"Örenäs Slott","slug":"orenas-slott","url":"https://spokkartan.se/new-orenas-slott","lat":56.21,"lng":12.56,"country":"Sverige","region":"Skåne Län","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Det vackra slottet i nordvästra Skåne med en hemlighet inmurad i källarvalven sedan 1600-talet.","description":"Örenäs slott vid Höganäs i Skåne är ett pittoreskt slott med havsutsikt. I slottets djupaste källarvalv sägs en gammal hemlighet vara inmurad — ett brott från 1600-talet som aldrig preskriberades i övernaturlig bemärkelse. Personal som arbetat sent vittnar om att ett rum i källaren aldrig värms upp oavsett värmning, och att en tryckt, gammal känsla aldrig lämnar platsen.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-ostersund-spoken","name":"Östersund","slug":"ostersund-spoken","url":"https://spokkartan.se/new-ostersund-spoken","lat":63.179,"lng":14.636,"country":"Sverige","region":"Jämtlands Län","type":"Stad","scary":3,"free":false,"bookable":false,"bookingUrl":"","teaser":"Storsjöodjuret är bara beginning — Östersund har spöken i varje gammalt kvarter.","description":"Östersund vid Storsjön är känt för sjöodjuret — men stadens äldre historia rymmer lika kusliga berättelser. De gamla trähusen i de centrala kvarteren, de nedlagda fångelsecellerna och slottsruinerna bär på berättelser som ortsborna inte delar med turister. Gamla militäranläggningar, spökkaffeer och ett torg med en mörkare historia än turistkartorna avslöjar.","img":"","date":"Apr 2026","points":60,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-akershus-festning","name":"Akershus Festning","slug":"akershus-festning","url":"https://spokkartan.se/new-akershus-festning","lat":59.906,"lng":10.736,"country":"Norge","region":"Norge","type":"Fästning","scary":5,"free":false,"bookable":false,"bookingUrl":"","teaser":"Norges mest hemsökta plats. 700 år av blod, fångars skrik och Malcanisen — hunden som varnar om dödsfall.","description":"Akershus festning i Oslo är Norges mest mytomspunna hemsökta plats. Byggt 1290 av kung Håkon V har fästningen aldrig erövrats av fiende — men blodet som runnit innanför murarna har lämnat märken. Fångarna som dömdes till hårt arbete i det strängaste fängelset i Norge på 1800-talet. Malcanisen, den mystiska hunden som syns när någon i den kungliga familjen ska dö. Whispers in the corridors. Anställda som vägrar patrullera ensamma nattetid.","img":"https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/Akershus_Fortress_from_Oslofjord.jpg/800px-Akershus_Fortress_from_Oslofjord.jpg","date":"Apr 2026","points":100,"categories":[],"featured":false,"new":true,"status":"published","img_credit":"Wikimedia Commons — CC BY-SA","img_author":"Wikimedia Commons"},{"id":"new-bergen-kulturhistorisk","name":"Kulturhistoriska Museet Bergen","slug":"bergen-kulturhistorisk","url":"https://spokkartan.se/new-bergen-kulturhistorisk","lat":60.392,"lng":5.325,"country":"Norge","region":"Norge","type":"Museum","scary":3,"free":false,"bookable":false,"bookingUrl":"","teaser":"Vikingatidens föremål och medeltida artefakter — och andarna av dem som en gång ägde dessa ting.","description":"Kulturhistoriska museet i Bergen förvarar tusentals artefakter från vikingatid och medeltid. En del av dessa föremål bär på sin ursprungliga ladda — och sina ursprungliga ägare. Nattanställda rapporterar om att föremål förflyttats, om kall luft i slutna salar och om känslan av en närvaro som inspekterar sina gamla ägodelar.","img":"","date":"Apr 2026","points":60,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-baroni-rosendal","name":"Baroni Rosendal","slug":"baroni-rosendal","url":"https://spokkartan.se/new-baroni-rosendal","lat":59.985,"lng":6.014,"country":"Norge","region":"Norge","type":"Slott","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Norges enda baroni med en olycklig grevinnas sorgliga presence i trädgårdarna och de gamla salarna.","description":"Baroni Rosendal i Hardanger är Norges enda baroni, grundat 1678. En av de tidiga grevinnnorna dog under omständigheter som aldrig helt klarlagdes, och hennes presence sägs fortfarande dröja i slottets trädgårdar och de rika interiörerna. Besökare rapporterar om en sorgsen atmosfär i de äldre delarna och om hur parfymdofter uppträder utan förklaring.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-essandsjoen-tydal","name":"Essandsjön, Tydal","slug":"essandsjoen-tydal","url":"https://spokkartan.se/new-essandsjoen-tydal","lat":62.99,"lng":11.97,"country":"Norge","region":"Norge","type":"Skog","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Den avlägsna fjällsjön i Tydal — näcken och andra vattenväsen håller fortfarande till vid den mörka stranden.","description":"Essandsjön i Tydal i Sør-Trøndelag är en fjällsjö omgiven av gammal folklore om vattenväsen. Lokala samer och bybor har i generationer varnat för att gå ensam vid sjöns strand efter skymning. Det sägs att de gamla vattenandarna, besläktade med näcken och fossegrimmen, fortfarande kräver respekt och ibland tar det de anser tillhör dem.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-agerup-gard","name":"Agerup Gård, Toröd, Nøtterøy","slug":"agerup-gard","url":"https://spokkartan.se/new-agerup-gard","lat":59.2,"lng":10.47,"country":"Norge","region":"Norge","type":"Herrgård","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Gården på Nøtterøy med en svart dam som visar sig för dem vars dagar är räknade.","description":"Agerup gård på Nøtterøy i Vestfold är en historisk bondgård med anor från medeltiden. En svart dam — en kvinna klädd helt i svart — sägs visa sig på gårdsplan och vid stugdörren för den som snart skall dö. Berättelsen är djupt rotad i ön Nøtterøys folklor och bekräftas av generation efter generation.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-skjeberg-prestegard","name":"Skjeberg Prestegård","slug":"skjeberg-prestegard","url":"https://spokkartan.se/new-skjeberg-prestegard","lat":59.2,"lng":11.21,"country":"Norge","region":"Norge","type":"Prästgård","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Prästgården vid Glomma — en okänd kvinna ber i tomma kyrksalen varje fredag vid midnatt.","description":"Skjeberg prestegård i Østfold vid Glommaelven är en av norska kyrkans äldre prästgårdar. En okänd kvinna i äldre dräkt — vem hon är har aldrig fastställts — ska be i den tomma kyrksalen varje fredagsnatt vid midnatt. Präster som bott i gården har rapporterat om hennes presence, och ingen har lyckats tala med henne innan hon försvinner.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-havøysund-hammerfest","name":"Havøysund i Hammerfest","slug":"havøysund-hammerfest","url":"https://spokkartan.se/new-havøysund-hammerfest","lat":70.99,"lng":24.66,"country":"Norge","region":"Norge","type":"Övergiven","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Det avlägsna fiskesamhället vid Nordkapets kuststräckor — de försvunna sjömännen och midnattssolens skuggor.","description":"Havøysund i Finnmark, nära Nordkap, är ett litet fiskesamhälle vid Arktiska havet. Under vinterns mörker och sommarens midnattssol uppstår en märklig atmosfär. Familjer som under generationer förlorat sina havsfarande på Barents hav rapporterar om möten med gestalter i gummistövlar och oljekläder — sjömän som aldrig återvände men som inte heller lämnat.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-mo-prestegard-frosta","name":"Mo Prestegård, Frosta","slug":"mo-prestegard-frosta","url":"https://spokkartan.se/new-mo-prestegard-frosta","lat":63.61,"lng":10.82,"country":"Norge","region":"Norge","type":"Prästgård","scary":3,"free":false,"bookable":false,"bookingUrl":"","teaser":"Prästgården på Frostahalvön vid Trondheimsfjorden — den döde prästen håller mässa i kapellet.","description":"Mo prestegård på Frostahalvön i Trøndelag är en gammal kyrklig egendom vid Trondheimsfjorden. En präst som dog mitt under en gudstjänst vägrar enligt sägnen låta sin mässa avslutas. Bybor har hört kyrkoklockan ringa vid ovanliga tider och sett ljus i kapellbyggnaden mitt i natten utan att någon levande person funnits där.","img":"","date":"Apr 2026","points":60,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-ovre-sandsvær-kongsberg","name":"Øvre Sandsvær, Kongsberg","slug":"ovre-sandsvær-kongsberg","url":"https://spokkartan.se/new-ovre-sandsvær-kongsberg","lat":59.75,"lng":9.68,"country":"Norge","region":"Norge","type":"Övergiven","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Det gamla gruvsamhället nära Kongsberg silvergruva — gruvarbetarnas andar har inte lämnat schakten.","description":"Øvre Sandsvær nära Kongsberg silver mine är präglat av tre hundra år av gruvdrift och minernas fara. Hundratals gruvarbetare dog i olyckor, ras och sjukdomar. De gamla schakten och arbetersätternas ruiner anses vara hemsökta av dem som gav sina liv i mörkret under jord. Vandrarlagets ledare rapporterar om att besökare ofta vänder tillbaka halvvägs utan att kunna förklara varför.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-howlid-garden","name":"Howlid Gården, Andenes","slug":"howlid-garden","url":"https://spokkartan.se/new-howlid-garden","lat":69.32,"lng":16.12,"country":"Norge","region":"Norge","type":"Herrgård","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Den gamla gården på Andøya — sjömanshustruns blick söker fortfarande horisonten efter den som aldrig kom hem.","description":"Howlid gården på Andøya i Nordland är en historisk gård vars historia är oupplösligt kopplad till havet och väntan. En sjömanshustru vars man aldrig återvände från Nordisen vakar fortfarande — hennes gestalt skymtas vid gårdens sjöbod, alltid vänd mot havet, alltid väntande.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-nazisten-jokerbutiken","name":"Nazisten på Jokerbutiken, Stavanger","slug":"nazisten-jokerbutiken","url":"https://spokkartan.se/new-nazisten-jokerbutiken","lat":58.971,"lng":5.734,"country":"Norge","region":"Norge","type":"Urban","scary":3,"free":false,"bookable":false,"bookingUrl":"","teaser":"En gammal Joker-butik i Stavanger där en gestalt i uniform syns i kylsektionens speglar.","description":"I en av Stavangers vardagligaste matbutiker cirkulerar en lokal legend om en gestalt i gammal uniform som syns i kylsektionens spegelglas. Legenden säger att byggnaden under ockupationsåren användes för ett syfte som aldrig officiellt dokumenterades. Butikspersonal som stänger ensamma rapporterar om en tryckt känsla och hastigt försvinnande skuggor.","img":"","date":"Apr 2026","points":60,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-filmteateret-stavanger","name":"Filmteateret, Stavanger","slug":"filmteateret-stavanger","url":"https://spokkartan.se/new-filmteateret-stavanger","lat":58.971,"lng":5.731,"country":"Norge","region":"Norge","type":"Urban","scary":3,"free":false,"bookable":false,"bookingUrl":"","teaser":"Den gamla biografen i Stavanger — den döde filmteknikern kontrollerar fortfarande vad som visas.","description":"Filmteateret i Stavanger är en gammal biograf med lång historia. En filmtekniker som arbetade där i decennier dog plötsligt mitt i sin tjänst. Sedan dess rapporterar kollegor om oförklarliga fel i projektorn, om att filmer byter ordning av sig själva och om att man höra steg i projektionsrummet när ingen ska vara där.","img":"","date":"Apr 2026","points":60,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-ladegarden-oslo","name":"Ladegården, Gamlebyen, Oslo","slug":"ladegarden-oslo","url":"https://spokkartan.se/new-ladegarden-oslo","lat":59.9,"lng":10.77,"country":"Norge","region":"Norge","type":"Herrgård","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Biskopens gård i Oslos äldsta stadsdel — medeltidsbiskopens vålnad vill inte att de levande glömmer honom.","description":"Ladegården i Gamlebyen, Oslo, är en av Norges äldsta bevarade byggnader med rötter till 1100-talets biskopsgård. Under medeltiden var detta maktcentrum för Oslo-biskopens styre. En biskops vålnad — man tror att det är biskop Eystein Aslaksson — sägs fortfarande vandra i de äldsta delarna av byggnaden, tydligen ovillig att lämna sitt jordiska maktcentrum.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-obersten-sverresborg","name":"Obersten på Vertshuset, Sverresborg","slug":"obersten-sverresborg","url":"https://spokkartan.se/new-obersten-sverresborg","lat":63.42,"lng":10.35,"country":"Norge","region":"Norge","type":"Hotell","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"En oberst som dog av sorg på fästningens värdshus — hans steg hörs varje natt vid klockan tre.","description":"Sverresborg, den gamla fästningen utanför Trondheim, inrymmer ett historiskt värdshus. En oberst som förlorade sin familj i en tragedi dog på värdshuset i total förtvivlan. Hans steg hörs av personal och nattgäster exakt klockan tre varje natt — aldrig vid annan tid, alltid i samma korridor.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-sjomannskolen-oslo","name":"Sjømannskolen, Oslo","slug":"sjomannskolen-oslo","url":"https://spokkartan.se/new-sjomannskolen-oslo","lat":59.9,"lng":10.72,"country":"Norge","region":"Norge","type":"Övergiven","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Den gamla sjömanskolan i Oslo — kadetternas fotsteg och sjömansvisor hörs fortfarande i de tomma korridorerna.","description":"Den gamla Sjømannskolen i Oslo utbildade generationer av sjömän för Norges stora fleet. Många av dess kadetter omkom senare till sjöss. Byggnaden, som stått tom i år, hör till de platser i Oslo där larminstallationer regelbundet löser ut utan synlig orsak och där vaktpersonal vägrar arbeta ensamma.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-hotel-hoyers","name":"Hotel Høyers, Skien","slug":"hotel-hoyers","url":"https://spokkartan.se/new-hotel-hoyers","lat":59.208,"lng":9.608,"country":"Norge","region":"Norge","type":"Hotell","scary":4,"free":false,"bookable":true,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Hotel+Høyers+Skien","teaser":"Henrik Ibsens hemstad och ett av Norges äldsta hotell — dramatikern sägs besöka sin ungdoms plats.","description":"Hotel Høyers i Skien, Henrik Ibsens hemstad, är ett av Norges äldsta hotell med anor från 1800-talet. Ibsen tillbringade sin barndom i Skien och en lokal legend hävdar att hans ande återvänder till hotellet — platsen för hans ungdoms drömmar och tragik. Gäster i det äldsta hörnet rapporterar om en man som sitter vid ett litet skrivbord och skriver, och som försvinner när man försöker se tydligare.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-skaugum-asker","name":"Skaugum, Asker","slug":"skaugum-asker","url":"https://spokkartan.se/new-skaugum-asker","lat":59.79,"lng":10.43,"country":"Norge","region":"Norge","type":"Herrgård","scary":3,"free":false,"bookable":false,"bookingUrl":"","teaser":"Kronprinsens residens i Asker — en gammal tradition om den vita damen som förebådar sorg i kungafamiljen.","description":"Skaugum i Asker är det norska kronprinsparets residens, byggt som en nationell gåva. Men på godsets ägor finns en äldre gård med en äldre historia. En vit dam — tradition och folktro — sägs visa sig vid godsets kant när sorg är på väg att drabba kungafamiljen. Berättelsen har cirkulerat i generationer bland ortsborna.","img":"","date":"Apr 2026","points":60,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-lea-hoyland-jæren","name":"Lea Høyland, Jæren","slug":"lea-hoyland-jæren","url":"https://spokkartan.se/new-lea-hoyland-jæren","lat":58.79,"lng":5.61,"country":"Norge","region":"Norge","type":"Herrgård","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Det gamla jordbruksgodset på Jæren — kustvindarnas vemod och spöket av en bonde som dog utan att förlåtas.","description":"Lea Høyland på Jærens öppna slätter är en gammal bondgård som bär på en historia om skuld och förlåtelse. En bonde som begick ett oförrätterligt brott mot sin grannes familj dog utan att söka försoning. Hans vålnad håller fortfarande till i ladugårdsbyggnaden och rapporteras av lantbrukare som arrenderat marken.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-kafe-celsius-oslo","name":"Kafe Celsius, Oslo","slug":"kafe-celsius-oslo","url":"https://spokkartan.se/new-kafe-celsius-oslo","lat":59.909,"lng":10.741,"country":"Norge","region":"Norge","type":"Spökhus","scary":3,"free":false,"bookable":false,"bookingUrl":"","teaser":"Den gamla källarkrogen i Oslo sedan 1626 — gästerna från 1600-talet lämnade aldrig bänkarna.","description":"Kafe Celsius i Oslo centrum är en av stadens äldsta krogar, med ursprung i 1626. I de gamla källarvalven under stadens gator samlas fortfarande skuggor av 400 år av gäster. Bartenders berättar om öl som tömts i ooglade glas, om stolar som dragits ut av sig själva och om en äldre man vid samma bord varje fredag kväll — som aldrig beställer.","img":"","date":"Apr 2026","points":60,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-lyktemannen-tinnosbanen","name":"Lyktemannen, Tinnosbanen, Telemark","slug":"lyktemannen-tinnosbanen","url":"https://spokkartan.se/new-lyktemannen-tinnosbanen","lat":59.73,"lng":8.85,"country":"Norge","region":"Norge","type":"Urban","scary":5,"free":false,"bookable":false,"bookingUrl":"","teaser":"Lyktemannen på den nedlagda järnvägen i Telemark — ett vandrande ljus på sträckan där ingen ska vara.","description":"Tinnosbanen i Telemark är en nedlagd järnväg med en av Norges mest kända paranormala fenomen. Lyktemannen — en ensam ljusglobus som vandrar längs de öde rälsen — har observerats av hundratals vittnen under decennier. Ingen rationell förklaring har fastslagits. Lokala berättelser kopplar ljuset till en banvakt som dog i tjänsten och aldrig lämnade sin sträcka.","img":"","date":"Apr 2026","points":100,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-gamlestua-borg","name":"Gamlestua på Borg, Asker","slug":"gamlestua-borg","url":"https://spokkartan.se/new-gamlestua-borg","lat":59.8,"lng":10.44,"country":"Norge","region":"Norge","type":"Spökhus","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Den gamla timmerstugan på Borgs gård i Asker — en kvinna i gammeldags dräkt uppenbarar sig vid höst.","description":"Gamlestua på Borgs gård i Asker är en av de äldre timmerbyggnaderna i trakten. En lokal kvinna i gammal nordisk folkdräkt uppenbarar sig vid hösttid i och kring stugan. Ingen har kunnat identifiera vem hon är baserat på historiska uppgifter från gårdens ägarelängd, men hennes presence är konsekvent rapporterad av generationer av ägare.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-den-sorte-dame","name":"Den Sorte Dame, Austad Gård","slug":"den-sorte-dame","url":"https://spokkartan.se/new-den-sorte-dame","lat":59.28,"lng":9.05,"country":"Norge","region":"Norge","type":"Herrgård","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Den svarta damen på Austad gård — hennes kall väcker de som ska dö och skrämmer de som lever.","description":"Austad gård i Telemark är hemvist för den berömda Den sorte dame — den svarta damen. Till skillnad från vitklädda spöken är hennes presence kopplad till mer direkt skräck: besökare som hört henne kalla på dem vid namn har rapporterat att en nära anhörig dött kort därefter. Gårdens ägare har levt med henne i generationer.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-nes-kirkeruiner","name":"Nes Kirkeruiner, Vormsund","slug":"nes-kirkeruiner","url":"https://spokkartan.se/new-nes-kirkeruiner","lat":60.13,"lng":11.47,"country":"Norge","region":"Norge","type":"Ruin","scary":3,"free":false,"bookable":false,"bookingUrl":"","teaser":"Medeltida kyrkoruiner vid Glomma i Akershus — munkarna som byggde kyrkan lämnade aldrig platsen.","description":"Nes kirkeruiner vid Vormsund i Akershus är rester av en medeltida kyrka vid Glommaelven. Munkarna som uppförde kyrkan och tjänade i generationer i trakten sägs aldrig ha lämnat platsen. Vid fullmåne hörs psalmsång från ruinen, och besökare har sett gestalter i munkdräkter röra sig bland de gamla stenarna.","img":"","date":"Apr 2026","points":60,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-spoker-pa-tjome","name":"Spöken på Tjøme","slug":"spoker-pa-tjome","url":"https://spokkartan.se/new-spoker-pa-tjome","lat":59.07,"lng":10.42,"country":"Norge","region":"Norge","type":"Ö","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Tjømes kust och fyr — sjömännen som förliste på revlarna spökar vid färjestationen.","description":"Tjøme i Vestfold är en skärgårdsö med lång sjöfartshistoria. Många fartyg förliste på de grunda revlarna och sjömännen som drunknade där sägs än idag visa sig vid de gamla färjebryggornas kant, vid fyren och längs strandvägarna under stormiga nätter. Öns befolkning har alltid respekterat havet — och havet kräver fortfarande sin respekt.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-jekta-kjopesenter","name":"Jekta Kjøpesenter, Tromsø","slug":"jekta-kjopesenter","url":"https://spokkartan.se/new-jekta-kjopesenter","lat":69.662,"lng":18.953,"country":"Norge","region":"Norge","type":"Urban","scary":3,"free":false,"bookable":false,"bookingUrl":"","teaser":"Köpcentrumet i Tromsø byggt på ett gammalt varvsområde — hantverkarna som byggde nordlandsjakterna är inte borta.","description":"Jekta köpcentrum i Tromsø är ett modernt shoppingcenter byggt på mark där nordlandsjaktar en gång byggdes. De gamla hantverkarna som tillbringade sina liv med att bearbeta trä och tjära sägs inte ha accepterat att deras verkstad försvann. Nattanställda rapporterar om hammarslag och sågljud från ingenstans, och om en stank av tjära i luften vid stängning.","img":"","date":"Apr 2026","points":60,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-folkmuseet-oslo","name":"Folkemuseet, Oslo","slug":"folkmuseet-oslo","url":"https://spokkartan.se/new-folkmuseet-oslo","lat":59.903,"lng":10.685,"country":"Norge","region":"Norge","type":"Museum","scary":3,"free":false,"bookable":false,"bookingUrl":"","teaser":"Norsk Folkemuseum med 160 flyttade byggnader — och andarna av alla som levde i dem.","description":"Norsk Folkemuseum i Oslo rymmer 160 historiska byggnader från hela Norge, samlade på Bygdøy. Bland stavkyrka och bondgårdar, härbärgen och stadshus cirkulerar andarna av dem som en gång levde i dessa väggar. Museet erbjuder spöktematiska vandringar, och personalen har egna berättelser om vad de mött under stängning.","img":"","date":"Apr 2026","points":60,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-bærums-verk","name":"Bærums Verk","slug":"bærums-verk","url":"https://spokkartan.se/new-bærums-verk","lat":59.93,"lng":10.48,"country":"Norge","region":"Norge","type":"Övergiven","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Järnverket från 1640 i Bærum — smedernas andar dunkar och slår i de gamla verkstadslokalerna.","description":"Bærums Verk är ett av Norges äldsta bevarade järnverk, grundat 1640. I de gamla smedjoorna och fabrikslokalerna arbetar smedarnas andar fortfarande — dunkar och hammarslag, orangeröd glöd som inte kan förklaras och värme utan eld. Besökare på kvällstid rapporterar konsekvent om kraftiga sinnesintryck.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-den-gra-dame-stavern","name":"Den Grå Dame i Stavern","slug":"den-gra-dame-stavern","url":"https://spokkartan.se/new-den-gra-dame-stavern","lat":59.0,"lng":10.02,"country":"Norge","region":"Norge","type":"Urban","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Den grå damen vid Stavernsfjorden — marinofficerens sörjande hustru som väntar på sin man.","description":"Stavern vid Larviksfjorden har en stark marinhistoria. Den grå damen — en kvinna klädd i grå 1800-talsklädsel — ses vandrar längs hamnkajen och vid de gamla officersmässarna. Hon söker sin man, en marinofficer som förliste under en av de norska flottans expeditioner. Berättelsen är lokal legend men bekräftas av ögonvittnen i varje generation.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-toras-fort","name":"Torås Fort, Tjøme","slug":"toras-fort","url":"https://spokkartan.se/new-toras-fort","lat":59.02,"lng":10.47,"country":"Norge","region":"Norge","type":"Fästning","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Det tyska kustfortet på Tjøme från WWII — soldaterna som dog här har inte funnit frid.","description":"Torås fort på Tjøme är ett tyskt kustfort från andra världskriget med kanoner och befästningar bevarade. Under ockupationen stationerades hundratals tyska soldater här och flera dog under stridigheter och olyckor. Nattliga besökare rapporterar om tyska röster, steg i stövlar och en tung militär atmosfär som inte hör till nutiden.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-lindesnes-fyr","name":"Lindesnes Fyr","slug":"lindesnes-fyr","url":"https://spokkartan.se/new-lindesnes-fyr","lat":57.982,"lng":7.047,"country":"Norge","region":"Norge","type":"Övergiven","scary":3,"free":false,"bookable":false,"bookingUrl":"","teaser":"Norges sydligaste punkt — fyrvaktaren som aldrig lämnade sin post och ljuset som tänds av sig självt.","description":"Lindesnes fyr är Norges äldsta och sydligaste fyr, tänd 1655. En av de äldsta fyrvaktarna — en man som vigde sitt liv åt att hålla elden brinnande — sägs aldrig ha lämnat sin tjänst. Moderna fyrvaktare och besökare berättar om hur fyrlampan tänds av sig självt vid svår storm och om en gammal mans silhuett mot havet vid gryning.","img":"","date":"Apr 2026","points":60,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-jomfruholmen-arendal","name":"Jomfruholmen, Arendal","slug":"jomfruholmen-arendal","url":"https://spokkartan.se/new-jomfruholmen-arendal","lat":58.46,"lng":8.77,"country":"Norge","region":"Norge","type":"Ö","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Den lilla holmen utanför Arendal där en ung kvinna dog ensam — och väntar fortfarande på räddning.","description":"Jomfruholmen utanför Arendal i Aust-Agder är en liten holme med en stor tragedi. En ung kvinna som förlorade sin båt strändade på holmen och dog ensam innan någon nådde henne. Hennes rop och tårar sägs fortfarande höras vid storm och hennes vita gestalt ses ibland från fastlandet vid gryning.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-morkemannen-kristiansand","name":"Mørkemannens Gjenferd, Kristiansand","slug":"morkemannen-kristiansand","url":"https://spokkartan.se/new-morkemannen-kristiansand","lat":58.147,"lng":7.995,"country":"Norge","region":"Norge","type":"Urban","scary":5,"free":false,"bookable":false,"bookingUrl":"","teaser":"Det mörka spöket i Kristiansand — Mørkemannen som straffar den som vandrar ensam om natten.","description":"Mørkemannen är en av Sørlandes mest fruktade folklorfigurer, koplad till Kristiansand. Han sägs straffa ensamma nattvandrare och har blivit ett inslag i lokala barnuppfostran sedan 1700-talet. Vuxna vittnar om en stor, mörk gestalt som förföljer dem i sidogator och sedan försvinner när de vänder sig om. Inte ett spöke av en specifik person — utan ett väsen.","img":"","date":"Apr 2026","points":100,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-teisen-gard-oslo","name":"Teisen Gård, Oslo","slug":"teisen-gard-oslo","url":"https://spokkartan.se/new-teisen-gard-oslo","lat":59.93,"lng":10.82,"country":"Norge","region":"Norge","type":"Herrgård","scary":3,"free":false,"bookable":false,"bookingUrl":"","teaser":"Den gamla gården i Oslos östra utkant — adeln som bodde här reste och kom aldrig tillbaka, men deras ande stannade.","description":"Teisen gård i östra Oslo är en gammal herrgård som nu omges av modern bebyggelse. Ursprungligen tillhörde gården en av Oslos gamla adelsätter. Gårdens ande — en äldre herremans gestalt i 1700-talskläder — observeras av grannarna och de som arbetar i de omvandlade lokalerna.","img":"","date":"Apr 2026","points":60,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-spiraltoppen-drammen","name":"Spiraltoppen, Drammen","slug":"spiraltoppen-drammen","url":"https://spokkartan.se/new-spiraltoppen-drammen","lat":59.74,"lng":10.22,"country":"Norge","region":"Norge","type":"Urban","scary":3,"free":false,"bookable":false,"bookingUrl":"","teaser":"Bergstoppen ovanför Drammen — en gammal sägen om skogsväsenden som bor i bergets spiral.","description":"Spiraltoppen ovanför Drammen nås via en spiralformad tunnel genom berget. Toppen ger utsikt men bär också på äldre folksägner om de väsen som bodde i berget innan tunneln borrades. Lokala klättrare och joggare undviker platsen i mörker och rapporterar om känslan av att vara oönskad.","img":"","date":"Apr 2026","points":60,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-stenberg-gard-toten","name":"Stenberg Gård, Toten","slug":"stenberg-gard-toten","url":"https://spokkartan.se/new-stenberg-gard-toten","lat":60.74,"lng":10.82,"country":"Norge","region":"Norge","type":"Herrgård","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Herrgården på Totenlandet — en gammal dame i svart som kliver ned för trappan varje måndagsmorgon.","description":"Stenberg gård på Totenlandet i Innlandet är ett gammalt herresäte med djupa rötter i norsk bondekultur. En gammal dam i svart 1800-talsdräkt observeras kliva nerför herrgårdens gamla trappa varje måndagsmorgon — exakt, pålitligt och oförklarligt. Ägare och personal har dokumenterat fenomenet i generationer.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-karvikhamn-senja","name":"Kårvikhamn, Senja Tromsø","slug":"karvikhamn-senja","url":"https://spokkartan.se/new-karvikhamn-senja","lat":69.38,"lng":17.51,"country":"Norge","region":"Norge","type":"Övergiven","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Det avlägsna fiskelägret på Senja — fiskarna som försvann i stormen och aldrig återfanns.","description":"Kårvikhamn på Senjaön i Troms är ett avlägset fiskeläger med en lång historia av förluster till havet. Under en ovanligt svår vinterstorm försvann flera båtar med sina besättningar utan att lämna spår. Hamnens gamla bodar och bryggor anses hemsökta av männen som aldrig kom hem.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-honse-birthe-fossholmen","name":"Hønse Birthe, Fossholmen","slug":"honse-birthe-fossholmen","url":"https://spokkartan.se/new-honse-birthe-fossholmen","lat":59.25,"lng":9.4,"country":"Norge","region":"Norge","type":"Urban","scary":3,"free":false,"bookable":false,"bookingUrl":"","teaser":"Hönsögumman Birthe på Fossholmen — en gammal kvinna med sina hönor som dök upp när olycka var på väg.","description":"Hønse Birthe är en lokalfolkloristisk figur kopplad till Fossholmen i Telemark. En gammal kvinna med sina hönor sågs alltid i byn precis innan en olycka inträffade — ett förebud lika pålitligt som väderomslag. Hennes gestalt rapporteras fortfarande: en liten kvinna med en höna under armen, vandrar längs de gamla stigarna och försvinner i skogen.","img":"","date":"Apr 2026","points":60,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-den-hvite-dame-fredriksten","name":"Den Hvite Dame, Fredriksten","slug":"den-hvite-dame-fredriksten","url":"https://spokkartan.se/new-den-hvite-dame-fredriksten","lat":59.113,"lng":11.392,"country":"Norge","region":"Norge","type":"Fästning","scary":5,"free":false,"bookable":false,"bookingUrl":"","teaser":"Fredriksten fästning och Den Hvite Dame — Karl XII dog här och hans general sörjer fortfarande.","description":"Fredriksten fästning vid Halden är platsen där Karl XII dog 1718 — en av Nordens historias mest dramatiska dödsfall. Den Hvite Dame — en vit gestalt — ses på fästningens vallar och sägs vara en kvinna vars man stupade i striderna kring fästningen. Fästningens vakter har under sekler bekräftat hennes presence.","img":"","date":"Apr 2026","points":100,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-bymyra-barnehage-tromso","name":"Bymyra Barnehage, Tromsø","slug":"bymyra-barnehage-tromso","url":"https://spokkartan.se/new-bymyra-barnehage-tromso","lat":69.65,"lng":18.95,"country":"Norge","region":"Norge","type":"Övergiven","scary":5,"free":false,"bookable":false,"bookingUrl":"","teaser":"Den gamla förskolan i Tromsø — barnens skratt och rop hörs fortfarande fast byggnaden stängt sedan länge.","description":"Bymyra barnehage i Tromsø är en nedlagd förskola vars historia slutade abrupt. Barn och personal som var kopplade till platsen dog under tragiska omständigheter. Sedan stängningen hörs barnens röster, skratt och gråt från den tomma byggnaden — rapporterat av grannar och förbipasserande under alla årstider.","img":"","date":"Apr 2026","points":100,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-haikeren-rissa","name":"Haikeren, Rissa","slug":"haikeren-rissa","url":"https://spokkartan.se/new-haikeren-rissa","lat":63.59,"lng":9.96,"country":"Norge","region":"Norge","type":"Övergiven","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Haiker-platsen utanför Rissa — de som gett liftar vittnar om passagerare som försvinner ur bilen.","description":"Haikeren utanför Rissa i Trøndelag är en välkänd plats längs E39 där ett märkligt fenomen rapporteras: förare som stoppar för att ge lift till en person vid vägen vittnar om att passageraren försvinner ur bilen innan de nått nästa samhälle. Berättelsen upprepas av oberoende vittnen sedan 1970-talet.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-laegerhytta-strynefjellet","name":"Lægerhytta, Strynefjellet","slug":"laegerhytta-strynefjellet","url":"https://spokkartan.se/new-laegerhytta-strynefjellet","lat":61.87,"lng":7.06,"country":"Norge","region":"Norge","type":"Övergiven","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Den gamla skidlägerhytan på Strynefjellet — en vinternatt med skidvakter som aldrig kom hem.","description":"Lægerhytta på Strynefjellet i Vestland är en gammal fjällstuga med koppling till en tragisk vintersäsong då ett skidlag försvann i snöstorm. Stugan hittades tom — en kall middag serverad på bordet. Sedan dess rapporterar vandrare om ljus i stugans fönster vid nattmörker och om en känsla av att välkomnas in av händer som inte syns.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-amot-osterdalen","name":"Åmot i Østerdalen","slug":"amot-osterdalen","url":"https://spokkartan.se/new-amot-osterdalen","lat":61.14,"lng":11.33,"country":"Norge","region":"Norge","type":"Urban","scary":3,"free":false,"bookable":false,"bookingUrl":"","teaser":"Det stillsamma Åmot vid Glomma — folklorens troll och skogsväsen håller fortfarande till i dalens kanter.","description":"Åmot i Østerdalen vid Glommadalen är ett litet samhälle med djupt rotad folklor om de väsen som bor i dalsidorna och längs Glommas branter. Ortsborna respekterar fortfarande gamla traditioner om att inte gå ut ensam vid midnatt under vinterhalvåret och att aldrig störa gamla offerplatser längs älven.","img":"","date":"Apr 2026","points":60,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-gravroeysa-granholmen","name":"Gravrøysa vid Granholmen","slug":"gravroeysa-granholmen","url":"https://spokkartan.se/new-gravroeysa-granholmen","lat":59.38,"lng":10.55,"country":"Norge","region":"Norge","type":"Övergiven","scary":3,"free":false,"bookable":false,"bookingUrl":"","teaser":"Den fornnordiska graven på Granholmen — vikingens ande vaktar sin skatt och driver bort inkräktare.","description":"Gravrøysa vid Granholmen är en fornnordisk gravhög från vikingatiden. Enligt gammal norsk tradition vaktar den döde sina ägodelar efter döden och drar sig inte för att visa detta. Lokala vittnen rapporterar om mörka gestalter i gammal utrustning vid röset och om en känsla av att aktivt bli avvisad från platsen.","img":"","date":"Apr 2026","points":60,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-hoff-prestegard","name":"Hoff Prestegård","slug":"hoff-prestegard","url":"https://spokkartan.se/new-hoff-prestegard","lat":60.63,"lng":11.05,"country":"Norge","region":"Norge","type":"Prästgård","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Prästgården i Stange — prästen som förgiftat sin hustru och dömdes av kyrkan vandrar i botgöring.","description":"Hoff prestegård i Stange, Innlandet, bär på en av norsk kyrkas mörkaste lokala historier. En präst som dömdes för sin hustrus förgiftning på 1800-talet avrättades och begravdes i oskillnad jord. Hans botgörande ande sägs vandra i prästgårdens källare och trädgård, sökande en förlåtelse han aldrig fick under livet.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-villa-fridheim","name":"Villa Fridheim","slug":"villa-fridheim","url":"https://spokkartan.se/new-villa-fridheim","lat":60.03,"lng":10.06,"country":"Norge","region":"Norge","type":"Herrgård","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Den victorianska villan på Tyrifjorden — en sommaridyll med en osalig dam som aldrig lämnade sin stuga.","description":"Villa Fridheim vid Tyrifjorden i Viken är en välbevarad victoriansk villa från 1880-talet. En av de tidiga sommargästerna — en dam av välsituerad härkomst — dog under sin sista sommar i villan och lämnade aldrig. Besökare i det äldsta gästrummet rapporterar om en svag parfym, om speglar som visar ansiktet en sekund för länge och om ett sakta gungande trycke i madrassen.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-slottsfjellet-tonsberg","name":"Slottsfjellet, Tönsberg","slug":"slottsfjellet-tonsberg","url":"https://spokkartan.se/new-slottsfjellet-tonsberg","lat":59.267,"lng":10.408,"country":"Norge","region":"Norge","type":"Ruin","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Nordens äldsta stad och dess slottsruin — korsfararnas och vikingars ande rusar fortfarande genom ruinerna.","description":"Slottsfjellet — slottsberget — i Tønsberg är ruinen av ett av Norges starkaste medeltida slott, kopplat till vikingar och korsfarare. Tønsberg sägs vara Nordens äldsta stad. De historiska lagrens tyngd gör platsen unik. Besökare nattetid rapporterar om ett oöverskådligt antal ljud — rustningar, hästar, rop — som tycks komma ur berget självt.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-vallø-kirke","name":"Vallø Kirke, Tönsberg","slug":"vallø-kirke","url":"https://spokkartan.se/new-vallø-kirke","lat":59.33,"lng":10.37,"country":"Norge","region":"Norge","type":"Kyrka","scary":3,"free":false,"bookable":false,"bookingUrl":"","teaser":"Den gamla kyrkan vid Vallø slott — klostrets nunnor sjunger fortfarande i gryningen.","description":"Vallø kirke nära Tønsberg är intimt kopplad till det angränsande Vallø slott, en gång ett cistercienserkloster. Nunnornas sång — alltid vid gryning, aldrig vid annan tid — rapporteras av de som bor eller arbetar nära kyrkan. Berättelsen är konsekvent och sträcker sig tillbaka till slottets omvandling efter reformationen.","img":"","date":"Apr 2026","points":60,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-finnskogen-valgunahol","name":"Finnskogen, Vålgunahol","slug":"finnskogen-valgunahol","url":"https://spokkartan.se/new-finnskogen-valgunahol","lat":60.77,"lng":12.22,"country":"Norge","region":"Norge","type":"Skog","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Det finska skogslandskapet på Finnskogen — trollkarlens plats och skogens djupaste hemligheter.","description":"Finnskogen längs gränsen mot Sverige är ett kulturlandskap format av finska skogsfinnarnas invandring på 1600-talet. Vålgunahol är ett av skogens heliga ställen enligt finsk tradition — en plats där de som äger skogsmagi möts. Moderna vandrare rapporterar om ovanliga ljud, om stigar som tycks byta riktning och om en känsla av att välkomnas eller avvisas beroende på avsikt.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-blaafarveværket","name":"Blaafarveværket, Modum","slug":"blaafarveværket","url":"https://spokkartan.se/new-blaafarveværket","lat":59.96,"lng":9.89,"country":"Norge","region":"Norge","type":"Övergiven","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Den gamla koboltgruvan i Modum — gruvarbetarnas barn som dog i blåmälning och smuts spökar i verket.","description":"Blaafarveværket i Modum är en gammal koboltgruva och färgverk där blå pigment producerades för Europas konstnärer under 1700- och 1800-talen. Tusentals arbetare, inklusive barn, slitade under hårda förhållanden och många dog av giftiga ämnen. De gamla fabrikslokalerna och gruvschakten anses vara hemsökta av dem som offrade sina liv för blåfärgen.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-utstein-kloster","name":"Utstein Kloster","slug":"utstein-kloster","url":"https://spokkartan.se/new-utstein-kloster","lat":59.1,"lng":5.68,"country":"Norge","region":"Norge","type":"Kyrka","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Norges bäst bevarade medeltida kloster — cisterciensermunkarnas sång hörs fortfarande vid midnatt.","description":"Utstein kloster på Mosterøy utanför Stavanger är Norges bäst bevarade medeltida kloster, grundat på 1200-talet. Munkarna som levde och dog här under fyra sekler lämnade djupa spår i stenen. Vid midnatt, under klara och tysta nätter, rapporteras gregoriansk sång höras från klosterkyrkans valv — ett ljud utan synlig källa.","img":"https://upload.wikimedia.org/wikipedia/commons/thumb/c/ca/Utstein_kloster.jpg/800px-Utstein_kloster.jpg","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published","img_credit":"Wikimedia Commons — CC BY-SA","img_author":"Wikimedia Commons"},{"id":"new-vestre-toten-museum","name":"Vestre Toten Museum","slug":"vestre-toten-museum","url":"https://spokkartan.se/new-vestre-toten-museum","lat":60.73,"lng":10.83,"country":"Norge","region":"Norge","type":"Museum","scary":3,"free":false,"bookable":false,"bookingUrl":"","teaser":"Museet på Toten med gamla föremål och de som saknar dem — artefakternas ägare besöker sitt gods.","description":"Vestre Toten Museum i Innlandet samlar historia från Totenområdets jordbrukskultur. Bland de gamla föremålen — kläder, redskap, möbler — cirkulerar ibland andarna av dem som ägde dem. Nattanställda och städpersonal berättar om föremål som förflyttats, om dofter från gammal mat och om steg i de stängda utställningssalarna.","img":"","date":"Apr 2026","points":60,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-down-town-porsgrunn","name":"Down Town, Porsgrunn","slug":"down-town-porsgrunn","url":"https://spokkartan.se/new-down-town-porsgrunn","lat":59.14,"lng":9.66,"country":"Norge","region":"Norge","type":"Urban","scary":3,"free":false,"bookable":false,"bookingUrl":"","teaser":"Baren i Porsgrunn där en av de tidiga ägarna dog och aldrig slutade stänga.","description":"Down Town i Porsgrunn är en bar i en gammal fastighet med historia tillbaka till 1800-talets handelsstad. En av de tidiga barägarna dog plötsligt efter stängning och berättelsen om honom lever kvar: stolar som ställs upp på borden av sig självt, ljus som tänds i det stängda lokalet och kassasystemet som visar konstiga rörelser.","img":"","date":"Apr 2026","points":60,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-lyngstad-skole","name":"Lyngstad Skole, Inderøy","slug":"lyngstad-skole","url":"https://spokkartan.se/new-lyngstad-skole","lat":63.92,"lng":11.25,"country":"Norge","region":"Norge","type":"Övergiven","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Den nedlagda skolan på Inderøy — läraren som aldrig slutade undervisa och barnens röster i klassrummen.","description":"Lyngstad skole på Inderøy i Trøndelag är en gammal skola som lagts ned efter att byn krympt. En lärare som ägnat sitt liv åt skolan dog kort efter stängningen och sägs aldrig ha accepterat slutet. Föräldrar som passerar rapporterar om barnröster och en lärares röst bakom de låsta dörrarna.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-spellemannshaugen-borre","name":"Spellemannshaugen, Borre","slug":"spellemannshaugen-borre","url":"https://spokkartan.se/new-spellemannshaugen-borre","lat":59.39,"lng":10.45,"country":"Norge","region":"Norge","type":"Övergiven","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Gravhögen i Borre nationalpark — spelmannen som spelade för de döda kungarna på högens topp.","description":"Spellemannshaugen i Borres nationalpark — hem för Norges äldsta samling av kungliga gravhögar från vikingatiden — har fått sitt namn från en lokal sägen. En spelman spelade en natt på högens topp och försvann. Sedan dess hörs hans musik vid gryning under sommarnätter: en gammal folkmelodi utan synlig musiker.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-fleischer-hotel","name":"Fleischer Hotel, Voss","slug":"fleischer-hotel","url":"https://spokkartan.se/new-fleischer-hotel","lat":60.629,"lng":6.416,"country":"Norge","region":"Norge","type":"Hotell","scary":4,"free":false,"bookable":true,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Fleischer+Hotel+Voss","teaser":"Det pittoreska hotell Fleischer i Voss — gästen i den gamla vintersalongen som aldrig checkade ut.","description":"Hotell Fleischer i Voss är ett av Norges klassiska bergshotell, öppnat 1889. En tidiga gäst — en engelsman som kom för vintersport — dog i hotellpianots sal under oklara omständigheter. Hans gestalt rapporteras fortfarande i den gamla vintersalongen, alltid sittande vid pianot med ryggen mot dörren.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-sorenskrivergarden","name":"Sorenskrivergården, Brønnøysund","slug":"sorenskrivergarden","url":"https://spokkartan.se/new-sorenskrivergarden","lat":65.475,"lng":12.213,"country":"Norge","region":"Norge","type":"Herrgård","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Den gamle sorenskriverens residens i Brønnøysund — rättvisan han skipade lever kvar i murarna.","description":"Sorenskrivergården i Brønnøysund är en gammal domargård vid Helgelandskysten. Den magistrat som dömde människor till hårda straff under 1800-talets Norge sägs vaka över sin gamla gård och sina handlingar. Gårdans nattliga ljud och en tryckt, juridisk atmosfär präglar platsen.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-garden-pa-gjovik","name":"Gården på Gjøvik","slug":"garden-pa-gjovik","url":"https://spokkartan.se/new-garden-pa-gjovik","lat":60.8,"lng":10.7,"country":"Norge","region":"Norge","type":"Herrgård","scary":5,"free":false,"bookable":false,"bookingUrl":"","teaser":"En gård utanför Gjøvik med direktfilmstyrka — paranormala undersökare från hela världen vallfärdar hit.","description":"En namnlös gård strax utanför Gjøvik i Innlandet har blivit ett av Norges mest studerade paranormala objekt. Återkommande oförklarliga händelser — föremål som flyger, dörrar som smäller, en kvinna i fönstret på andra våningen när huset är tomt — dokumenteras av oberoende grupper. Paranormalforskare värdesätter platsen högt.","img":"","date":"Apr 2026","points":100,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-soldaten-pa-heia","name":"Soldaten på Heia","slug":"soldaten-pa-heia","url":"https://spokkartan.se/new-soldaten-pa-heia","lat":59.8,"lng":8.5,"country":"Norge","region":"Norge","type":"Skog","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Skogen på heia — en soldat från andra världskriget som marscherar längs de gamla patrullstigarna.","description":"På en ospecificerad \"heia\" i sydnorge — bergsplatån känd av ortsborna men svår att hitta på kartor — patrullerar en soldat i 1940-tals uniform längs gamla stigar. Sannolikt en fallskärmsjägare eller motståndsman. Fotvandare som stött på gestalten beskriver hur han stannar, ser på dem, och sedan marscherar in i skogen och försvinner.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-brekke-museum","name":"Brekke Museum, Skien","slug":"brekke-museum","url":"https://spokkartan.se/new-brekke-museum","lat":59.209,"lng":9.606,"country":"Norge","region":"Norge","type":"Museum","scary":3,"free":false,"bookable":false,"bookingUrl":"","teaser":"Det lilla museet i Skien — Ibsens farföräldrar levde här och dramatikern besöker sin barndoms plats.","description":"Brekke Museum i Skien är kopplat till Henrik Ibsens familjehistoria i staden. Ibsens farföräldrar levde i trakten och hans tidiga barndomsminnen formade hans dramatik. Museets vakter berättar om att ha sett en man som liknar porträtten av den unge Ibsen — stående och betraktande de gamla föremålen, och sedan gående igenom en stängd dörr.","img":"","date":"Apr 2026","points":60,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-torolv-torsadalen","name":"Torolv i Torsådalen","slug":"torolv-torsadalen","url":"https://spokkartan.se/new-torolv-torsadalen","lat":61.2,"lng":6.5,"country":"Norge","region":"Norge","type":"Skog","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Dalens troll Torolv — en fornnorsk tradition om bergets herre som kräver respekt och offergåvor.","description":"Torsådalen i det inre av Vestland är en dal vars invånare sedan vikingatiden hedrat bergets ande Torolv. Att missakta dalen — skräpa ned, jaga olovligt, eller förolämpa traditionen — sägs leda till olycka. Moderna rapporter bekräftar att hundar och hästar vägrar gå in i dalen vid vissa tider, och att GPS-utrustning uppvisar oregelbundna störningar.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-skarsjoen-lofoten","name":"Skarsjøen, Lofoten","slug":"skarsjoen-lofoten","url":"https://spokkartan.se/new-skarsjoen-lofoten","lat":68.18,"lng":14.28,"country":"Norge","region":"Norge","type":"Skog","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Den avlägsna fjällsjön på Lofoten — näcken och de nordliga väsendena kräver fortfarande respekt.","description":"Skarsjøen på Lofoten är en isolerad fjällsjö omgiven av dramatiska bergsprofiler. Lofotens samiska och norska folklor om vattenväsen är stark. Den som inte respekterar sjöns gräns — som badar ensam, kastar skräp eller talar illa om naturen nära vattnet — sägs dras ned av osynliga händer.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-kloverhuset-bergen","name":"Kløverhuset, Bergen","slug":"kloverhuset-bergen","url":"https://spokkartan.se/new-kloverhuset-bergen","lat":60.393,"lng":5.324,"country":"Norge","region":"Norge","type":"Urban","scary":3,"free":false,"bookable":false,"bookingUrl":"","teaser":"Det gamla köpcentrumet i Bergens centrum byggt på medeltidshistoriens mark — marknadshandlarnas andar.","description":"Kløverhuset i Bergen centrum är ett modernt köpcentrum byggt i ett historiskt block. Under grundläggningsarbetena hittades rester av medeltida handelsgårdar. Handelsmännen från Hansan och det gamla Bergen sägs inte accepterat att deras mark togs i anspråk — nattanställda rapporterar om stegljud och röster i norska och lågtyska.","img":"","date":"Apr 2026","points":60,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-tjøtta-helgeland","name":"Tjøtta, Helgeland","slug":"tjøtta-helgeland","url":"https://spokkartan.se/new-tjøtta-helgeland","lat":65.82,"lng":12.43,"country":"Norge","region":"Norge","type":"Övergiven","scary":5,"free":false,"bookable":false,"bookingUrl":"","teaser":"Den fornnordiska platsen på Helgeland — nordens mäktigaste jarls gravhög och hans eviga vakt.","description":"Tjøtta på Helgeland är platsen för gravhögen tillhörande Hårek av Tjøtta, en av 900-talets mäktigaste norska jarlar. Den norrøna traditionen att den döde håller vakt om sin grav är särskilt stark på Tjøtta — besökare rapporterar om en tryckt känsla kring gravhögen, om att kameror slutar fungera och om att de inte kan lämna platsen lika snabbt som de vill.","img":"","date":"Apr 2026","points":100,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-bibliotekaren-fredrikstad","name":"Bibliotekaren i Fredrikstad","slug":"bibliotekaren-fredrikstad","url":"https://spokkartan.se/new-bibliotekaren-fredrikstad","lat":59.207,"lng":10.949,"country":"Norge","region":"Norge","type":"Urban","scary":3,"free":false,"bookable":false,"bookingUrl":"","teaser":"Det gamla biblioteket i Fredrikstad fästning — en bibliotekarissa som dog mitt i sin katalogisering.","description":"Fredrikstad gamla stad inrymmer ett historiskt bibliotek där en passionerad bibliotekarissa dog mitt i sitt arbete under 1900-talets tidiga hälft. Hon ägnade livet åt att katalogisera och bevara stadens historia och vägrar fortfarande lämna den. Böcker hittas omsorterade, lappade och markerade — arbete som ingen anställd utfört.","img":"","date":"Apr 2026","points":60,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-gamla-gullhaug","name":"Gamla Gullhaug, Lier","slug":"gamla-gullhaug","url":"https://spokkartan.se/new-gamla-gullhaug","lat":59.76,"lng":10.23,"country":"Norge","region":"Norge","type":"Herrgård","scary":4,"free":false,"bookable":false,"bookingUrl":"","teaser":"Det gamla godset i Lier med ett guldhorn som aldrig hittades och en godsägare som aldrig slutade söka.","description":"Gamla Gullhaug i Lier i Viken är ett gammalt godssäte vars namn syftar på en lokal legend om ett nedgrävt guldhorn. Den godsägare som en gång ägt hornet och begravt det som skydd dog innan han avslöjat platsen. Hans ande sägs fortfarande söka igenom godsets mark, och metalldetektorister rapporterar om egendomliga störningar och oförklarliga impulsljud.","img":"","date":"Apr 2026","points":80,"categories":[],"featured":false,"new":true,"status":"published"},{"id":"new-svanoe-vandrarhem","name":"Svänö Vandrarhem","slug":"svanoe-vandrarhem","url":"https://spokkartan.se/svanoe","lat":56.85,"lng":14.42,"country":"Sverige","region":"Kronobergs Län","type":"Hotell","scary":4,"free":false,"bookable":true,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Svänö+vandrarhem","teaser":"Mitt i Store Mosse nationalpark — ett vandrarhem som bär på sorg och ouppklarade hemligheter djupt i den svenska vildmarken.","description":"Mitt inne i den stilla och vidsträckta Store Mosse nationalpark i Småland ligger Svänö Vandrarhem — ett hus som bär på mer än bara naturens ro. Vandrhemmet, isolerat bland myrar och gammal skog, har en historia som lockar spökjägare och nyfikna besökare från hela Sverige. Gäster vittnar om fotsteg utan ägare, dörrar som öppnas och en tryckt, melankolisk stämning som inte försvinner ens i solsken. Platsen är omgiven av en av Europas nordligaste högmossemiljöer, och den avskildhet som naturen erbjuder gör att platsens hemligheter känns extra svåra att lämna bakom sig.","img":"","date":"2025","points":80,"categories":["Hemsökt Hotell","Kronobergs Län","Store Mosse"],"featured":false,"new":true,"status":"published"},{"id":"new-gripsholms-vardshus","name":"Gripsholms Värdshus","slug":"gripsholms-vardshus","url":"https://spokkartan.se/gripsholms-vardshus","lat":59.255,"lng":16.882,"country":"Sverige","region":"Södermanlands Län","type":"Hotell","scary":4,"free":false,"bookable":true,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Gripsholms+Värdshus","teaser":"Sveriges äldsta värdshus från 1609 — munkarna som en gång levde i klostret låser upp dörrar och stoppar om gästerna mitt i natten.","description":"Gripsholms Värdshus i Mariefred, grundat 1609, är Sverige äldsta värdshus — en plats där historia och övernaturlighet smälter samman. Under 1400-talet låg ett kloster på platsen, och det är munkarna därifrån som enligt sägnen fortfarande hemsöker huset. Föremål som förflyttas, lampor som tänds och låsta dörrar som öppnas av sig själva rapporteras regelbundet. Gäster har upplevt figurer i mörka luvor som rör sig i korridorerna och upplevt att de på natten blivit omstoppade i sina sängar — som av osynliga händer.","img":"","date":"2025","points":80,"categories":["Hemsökt Hotell","Södermanlands Län","Gripsholm"],"featured":false,"new":true,"status":"published"},{"id":"new-sodertuna-slott","name":"Södertuna Slott","slug":"sodertuna-slott","url":"https://spokkartan.se/sodertuna-slott","lat":59.07,"lng":16.82,"country":"Sverige","region":"Södermanlands Län","type":"Slott","scary":4,"free":false,"bookable":true,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Södertuna+Slott","teaser":"Ebba von Hallwyl och den svarta damen i källarvalven — ett slott med en blodig historia som börjar med ett mord 1381.","description":"Södertuna slott utanför Gnesta i Södermanland har en historia som börjar dramatiskt: slottets första ägare, riddaren Karl Nilsson, dräptes 1381. Slottsfrun Ebba von Hallwyl, som ärvde slottet 1891, ses fortfarande vandra bland de vackra interiörerna. Men det är den Svarta damen i källarvalven som skrämmer personalen mest — en gestalt som ropar och rör sig i mörkret under slottets golv. Dörrar slår upp utan förklaring, vindar far genom stängda rum och röster hörs utan synliga ägare.","img":"","date":"2025","points":80,"categories":["Hemsökta Slott","Södermanlands Län","Gnesta"],"featured":false,"new":true,"status":"published"},{"id":"new-haringe-slott","name":"Häringe Slott","slug":"haringe-slott","url":"https://spokkartan.se/haringe-slott","lat":58.97,"lng":18.15,"country":"Sverige","region":"Stockholms Län","type":"Hotell","scary":4,"free":false,"bookable":true,"bookingUrl":"https://www.booking.com/searchresults.sv.html?ss=Häringe+Slott","teaser":"Lille Axel gråter i Sjöflygeln och en munk i Gotiska rummet — Stockholms kusligaste slottshotell.","description":"Häringe slott söder om Stockholm har anor från vikingatiden och är nu ett boutiquehotell med spöktematiserade rum. Den mest kända historien handlar om lille Axel, son till greve Gustaf Horn, som dog bara två år gammal. Gäster i Sjöflygeln hör barnet gråta om nätterna eller känner en iskall närvaro krypa ner i sängen bredvid dem. I det Gotiska rummet på övervåningen bor ett 400-år gammalt munkspöke. Slottet erbjuder spökjakter och mordmysterier för de modiga.","img":"","date":"2025","points":80,"categories":["Hemsökta Hotell","Stockholms Län","Spökvandring"],"featured":false,"new":true,"status":"published"},{"id":"new-kymlinge-silverpilen","name":"Kymlinge – Silverpilen","slug":"kymlinge-silverpilen","url":"https://spokkartan.se/kymlinge-silverpilen","lat":59.38,"lng":17.94,"country":"Sverige","region":"Stockholms Län","type":"Urban","scary":5,"free":false,"bookable":false,"bookingUrl":"","teaser":"Silverpilen stannar aldrig. Men på Kymlinge — den station som aldrig öppnades — stiger de döda på.","description":"Kymlinge station på Stockholms tunnelbanas blå linje är en av Nordens mest kända övernaturliga platser. Stationen planerades och byggdes men öppnades aldrig för publik — den förblir en betongspöksstation i mörkret. Enligt sägnen stannar det silverfärgade tåget Silverpilen en gång om natten vid Kymlinge. Passagerarna som stiger på är de som dött i tunnelbanan — stela, stirrande rakt fram. En röst säger 'slutstation', sedan försvinner tåget. Platsen är avspärrad och bevakad, men spökentusiaster vallfärdar hit.","img":"","date":"2025","points":100,"categories":["Urban","Stockholms Län","Silverpilen"],"featured":true,"new":true,"status":"published"},{"id":"int-uk-01","name":"Tower of London","country":"Storbritannien","region":"London, England","type":"Slott","scary":5,"lat":51.508,"lng":-0.076,"teaser":"Antas vara Storbritanniens mest hemsökta plats. Anne Boleyn, Lady Jane Grey och hundratals andra avrättade vandrar i de medeltida murarna.","description":"Tower of London har stått vid Themsen sedan 1066 och har tjänat som fängelse, avrättningsplats och kunglig bostad. Mellan 1100 och 1952 avrättades otaliga fångar här i fruktansvärda former. Anne Boleyns avhuggna huvud har setts bäras under armen av en gestalt vid Tower Green. Lady Jane Grey och Sir Walter Raleigh sägs fortfarande vandra korridorerna. Tornet Bloody Tower är känt för spöket av två unga prinsar — Edward V och Richard, hertig av York — som mördades på order av Richard III 1483. Beefeater-vakter vittnar om nattliga händelser som inte kan förklaras.","status":"published","free":false,"bookable":false,"bookingUrl":"","img":"","date":"2026","points":100,"categories":["Storbritannien","Slott"],"featured":false,"new":true,"slug":"int-uk-01","url":"https://spokkartan.se/int-uk-01"},{"id":"int-uk-02","name":"Hampton Court Palace","country":"Storbritannien","region":"Surrey, England","type":"Slott","scary":4,"lat":51.404,"lng":-0.337,"teaser":"Henrik VIII:s palats vid Themsen. Catherine Howards skrik hörs fortfarande i den långa galleriet — hon sprang och vädjade till kungen innan sin avrättning.","description":"Hampton Court byggdes av kardinal Wolsey och övertogs av Henrik VIII. Palatset har fem av Henrik VIII:s sex hustrur kopplade till sig i spökhistorier. Catherine Howard, Henrik VIII:s femte hustru, slets ifrån kapellet dit hon sprungit för att be om nåd inför sin avrättning 1542. Hennes skrik och gestalt rapporteras fortfarande i det långa galleriet. 2003 fångade övervakningskameror 'Skeletor' — en gestalt i medeltida klädsel som öppnade en branddörr och sedan försvann. Jane Seymour har setts vid Silverhjulets trappa.","status":"published","free":false,"bookable":false,"bookingUrl":"","img":"","date":"2026","points":80,"categories":["Storbritannien","Slott"],"featured":false,"new":true,"slug":"int-uk-02","url":"https://spokkartan.se/int-uk-02"},{"id":"int-uk-03","name":"Edinburgh Castle","country":"Storbritannien","region":"Edinburgh, Skottland","type":"Fästning","scary":5,"lat":55.948,"lng":-3.2,"teaser":"Edinburghs urberg med 3000 år av historia — tunnlarna under slottet är bland de mest intensivt undersökta paranormala platserna i världen.","description":"Edinburgh Castle tronar på ett vulkaniskt berg och har stått i någon form sedan järnåldern. Under slottet löper ett nätverk av tunnlar och kamrar som fyndiggjorts under arkeologiska utgrävningar. En studie 2001 med 240 frivilliga visade att 51% upplevde paranormala fenomen — kalla drag, känslan av att bli tryckt eller skuggor — utan att känna till platsernas historia. En pipa-spelande gestalt, ett headlöst trumslag och ett spökhund vars ägare försvann är bland de mest dokumenterade fenomenen.","status":"published","free":false,"bookable":false,"bookingUrl":"","img":"","date":"2026","points":100,"categories":["Storbritannien","Fästning"],"featured":false,"new":true,"slug":"int-uk-03","url":"https://spokkartan.se/int-uk-03"},{"id":"int-uk-04","name":"Chillingham Castle","country":"Storbritannien","region":"Northumberland, England","type":"Slott","scary":5,"lat":55.527,"lng":-1.895,"teaser":"Englands mest hemsökta slott. Platsens historia av avrättningar och tortyr har lämnat djupa övernaturliga spår — och du kan övernatta här.","description":"Chillingham Castle i Northumberland anses av många vara det mest hemsökta slottet i England. I 800 år har slottet tillhört samma familj — familjen Wakefield. Dess historia är fylld av krig, avrättningar och massakrer under de engelsk-skotska krigen. Det mest fruktade rummet är torturrummet, och dess mest kända spöke är The Boy in Pink — ett litet barn som dör av törst instängt i väggen. Slottet erbjuder övernattningar och guidade spökvandringar.","bookable":true,"bookingUrl":"https://www.booking.com/searchresults.en.html?ss=Chillingham+Castle","status":"published","free":false,"img":"","date":"2026","points":100,"categories":["Storbritannien","Slott"],"featured":false,"new":true,"slug":"int-uk-04","url":"https://spokkartan.se/int-uk-04"},{"id":"int-uk-05","name":"Berry Pomeroy Castle","country":"Storbritannien","region":"Devon, England","type":"Ruin","scary":5,"lat":50.453,"lng":-3.65,"teaser":"Den blå och vita damen — två av Englands mest ökända spöken bor i denna jakobinska ruinerna i Devon.","description":"Berry Pomeroy Castle i Devon anses vara ett av Englands mest hemsökta slott. Blå Damen — anda av en Normanfortens herre dotter vars spädbarn strypt av fadern — lockar besökare mot farliga delar av ruinen. Vita Damen är Lady Margaret Pomeroy, inlåst av sin avundsjuka syster tills hon svälte ihjäl. Hennes sörgliga gestalt lodar besökare att falla. Ruinen är genuint farlig att besöka, och känslan av att aktivt bli avvisad rapporteras konsekvent.","status":"published","free":false,"bookable":false,"bookingUrl":"","img":"","date":"2026","points":100,"categories":["Storbritannien","Ruin"],"featured":false,"new":true,"slug":"int-uk-05","url":"https://spokkartan.se/int-uk-05"},{"id":"int-uk-06","name":"Mary King's Close, Edinburgh","country":"Storbritannien","region":"Edinburgh, Skottland","type":"Urban","scary":4,"lat":55.949,"lng":-3.191,"teaser":"Det underjordiska gatunätverket under Edinburgh City Chambers — inmurade under 1600-talspesten med sina invånare.","description":"Mary King's Close är ett nätverk av gator och kamrar från 1600-talet som byggdes in under Edinburgh City Chambers. Under pestutbrott stängdes invånarna inne med sina döda. Platsen är nu ett museum med guidade turer, men paranormal aktivitet rapporteras regelbundet. Det kusligaste rummet är 'Annie's Room' — ett litet rum där barnet Annie sägs ha lämnat sin docka kvar och nu omges av leksaker och gåvor från besökare.","bookable":true,"bookingUrl":"https://www.marykingsclose.com/","status":"published","free":false,"img":"","date":"2026","points":80,"categories":["Storbritannien","Urban"],"featured":false,"new":true,"slug":"int-uk-06","url":"https://spokkartan.se/int-uk-06"},{"id":"int-uk-07","name":"Pluckley Village","country":"Storbritannien","region":"Kent, England","type":"Urban","scary":4,"lat":51.159,"lng":0.756,"teaser":"Englands mest hemsökta by med 12 kända spöken — den skrikande mannen, den brinnande kvinnan och motorvägsrånaren vid Skräckkorset.","description":"Pluckley i Kent erkändes av Guinness World Records som Englands mest hemsökta by, med upp till 12 dokumenterade spöken. Det mest dramatiska är den skrikande mannen — en tegel-groper som dog av kvicksilverförgiftning och hörs skrika på väg till den gamla lergropen. En kvinna som antände sig själv syns vid The Pinnock. Vid Fright Corner — Skräckkorset — uppenbarar sig en motorvägsrånare för nattsförare.","status":"published","free":false,"bookable":false,"bookingUrl":"","img":"","date":"2026","points":80,"categories":["Storbritannien","Urban"],"featured":false,"new":true,"slug":"int-uk-07","url":"https://spokkartan.se/int-uk-07"},{"id":"int-uk-08","name":"Tower of London – Raven Cage","country":"Storbritannien","region":"London, England","type":"Fästning","scary":4,"lat":51.507,"lng":-0.075,"teaser":"Om Ravens lämnar Tower of London ska kungariket falla — en 1000-årig förbannelse som britterna fortfarande tar på allvar.","description":"Tower of London håller alltid minst sex ravens fångna i enlighet med en urgammal kunglig förbannelse: om ravens lämnar, ska tornet och kungariket falla. Charles II instiftade detta krav i lag. Ravens har tjänat vid tornet i sekler och fått namn och pensioner. Ravenmaster — en beefeater utsedd enbart till ravens vård — är en av de mest unika tjänsterna i brittisk historia. Under WWII dog næsten alla ravens och Churchill beordrade omedelbar ersättning.","status":"published","free":false,"bookable":false,"bookingUrl":"","img":"","date":"2026","points":80,"categories":["Storbritannien","Fästning"],"featured":false,"new":true,"slug":"int-uk-08","url":"https://spokkartan.se/int-uk-08"},{"id":"int-uk-09","name":"Highgate Cemetery","country":"Storbritannien","region":"London, England","type":"Kyrkogård","scary":4,"lat":51.568,"lng":-0.148,"teaser":"En av världens vackraste och mest hemsökta kyrkogårdar — och historiens mest berömda vampyrjakt utspelades här på 1970-talet.","description":"Highgate Cemetery i norra London öppnades 1839 och är begravningsplats för Karl Marx, Douglas Adams och George Eliot bland andra. Men det är vampyrhistorien från 1970-talet som gjort kyrkogården världsberömd. Ögonvittnen rapporterade en stor mörk gestalt med röda ögon bakom staketet, och snart arrangerades vampyrjakter. Media lockades av berättelserna om 'Highgate Vampire'. Oavsett förklaring är kyrkogårdens atmosfär omisskännlig — täta ekar, victoriansk sten och känslan av tusentals vilande liv.","status":"published","free":false,"bookable":false,"bookingUrl":"","img":"","date":"2026","points":80,"categories":["Storbritannien","Kyrkogård"],"featured":false,"new":true,"slug":"int-uk-09","url":"https://spokkartan.se/int-uk-09"},{"id":"int-uk-10","name":"Glamis Castle","country":"Storbritannien","region":"Angus, Skottland","type":"Slott","scary":5,"lat":56.609,"lng":-3.011,"teaser":"Prins Charles barndomshem och skottlands läskigaste slott — det hemliga rummet, monster och Lady Glamis bränd som häxa 1537.","description":"Glamis Castle är kungafamiljens skotska barndomshem. Slottets mest kända hemlighet är det gömt rummet — ingen vet exakt var det är, men varje generation vittnar om dess existence. Lady Glamis brändes på bål 1537 anklagad för att ha försökt förgifta kung James V. Hennes gestalt ses vid slottets klocktorn, omsvept i ett rödaktigt sken. En 'monster' — ett missformat barn som inte fick visas offentligt — sägs ha levt i det hemliga rummet. Och Vampyren av Glamis — en osalig blodsugare inmurad i en källarvägg — väntar fortfarande.","status":"published","free":false,"bookable":false,"bookingUrl":"","img":"","date":"2026","points":100,"categories":["Storbritannien","Slott"],"featured":false,"new":true,"slug":"int-uk-10","url":"https://spokkartan.se/int-uk-10"},{"id":"int-us-01","name":"Eastern State Penitentiary","country":"USA","region":"Philadelphia, Pennsylvania","type":"Fängelse","scary":5,"lat":39.968,"lng":-75.173,"teaser":"Det gotiska fängelset i Philadelphia som pionjärade isolationssystemet 1829 — tusentals sinnen knäcktes, och deras andar stannade kvar.","description":"Eastern State Penitentiary öppnade 1829 som ett revolutionärt experiment i isolationsbestraffning. Fångarna hölls i fullständig isolering, tvingades bära huvor när de förflyttades och fick aldrig tala. Systemet drev otaliga till galensinnets rand. Al Capone satt här, och hans spöke sägs fortfarande dröja i cell 8. 1971 stängde fängelset, nu är det ett museum med nattliga spökturer och det mest studerade paranormala objektet i USA. Cellblock 12 är känt för otaliga ögonvittnen.","bookable":true,"bookingUrl":"https://www.easternstate.org/","status":"published","free":false,"img":"","date":"2026","points":100,"categories":["USA","Fängelse"],"featured":false,"new":true,"slug":"int-us-01","url":"https://spokkartan.se/int-us-01"},{"id":"int-us-02","name":"The Stanley Hotel","country":"USA","region":"Estes Park, Colorado","type":"Hotell","scary":4,"lat":40.379,"lng":-105.521,"teaser":"Inspirationen till Stephen Kings 'The Shining' — pianot spelar av sig självt i baren, och rum 217 föredrar fortfarande Stephen King.","description":"The Stanley Hotel i Estes Park, Colorado, öppnade 1909 och inspirerade Stephen King att skriva 'The Shining' efter en övernattning 1974. Rum 217 — där King bodde — är det mest begärda rummet. Gäster rapporterar om opackade resväskor, ljus som tänds och pianot i baren som spelar av sig självt mitt i natten. Ghostly barn springer och leker i korridoren på fjärde våningen. Hotellet erbjuder guidade spökturer och är fortfarande ett lyxhotell med övernattningar.","bookable":true,"bookingUrl":"https://www.booking.com/searchresults.en.html?ss=Stanley+Hotel+Estes+Park","status":"published","free":false,"img":"","date":"2026","points":80,"categories":["USA","Hotell"],"featured":false,"new":true,"slug":"int-us-02","url":"https://spokkartan.se/int-us-02"},{"id":"int-us-03","name":"Winchester Mystery House","country":"USA","region":"San Jose, Kalifornien","type":"Spökhus","scary":5,"lat":37.318,"lng":-121.951,"teaser":"Sarah Winchester byggde detta labyrinth i 38 år för att förvirra spökena från Winchesters gevär — 160 rum, trappor till ingenstans, dörrar mot väggar.","description":"Winchester Mystery House byggdes av Sarah Winchester, änka efter vapenfabrikanten William Wirt Winchester. En medium meddelade henne att de 38 år av kontinuerligt byggande var nödvändigt för att blidka andarna av dem som dödats av familjen Winchesters gevär. Resultatet är ett labyrintartat palats på 160 rum med trappor som leder rakt upp i taket, dörrar som öppnas mot tegelstensmurar och hemliga passager. Än idag rapporterar besökare om kalla fläktar, fotsteg och att bli desorienterade mitt i huset.","bookable":true,"bookingUrl":"https://winchestermysteryhouse.com/","status":"published","free":false,"img":"https://upload.wikimedia.org/wikipedia/commons/thumb/8/80/Winchester_Mystery_House_%E2%80%93_Aerial_View.jpg/800px-Winchester_Mystery_House_%E2%80%93_Aerial_View.jpg","date":"2026","points":100,"categories":["USA","Spökhus"],"featured":false,"new":true,"slug":"int-us-03","url":"https://spokkartan.se/int-us-03","img_credit":"Wikimedia Commons — CC BY-SA 4.0","img_author":"Sanfranman59"},{"id":"int-us-04","name":"Gettysburg Battlefield","country":"USA","region":"Gettysburg, Pennsylvania","type":"Övergiven","scary":5,"lat":39.811,"lng":-77.232,"teaser":"50 000 stupade på tre dagar 1863 — soldaternas andar marscherar fortfarande i Devil's Den och photographeras i tusentals bilder.","description":"Gettysburg var plats för det blodigaste slaget i det amerikanska inbördeskriget, 1-3 juli 1863. Omkring 51 000 soldater dog, skadades eller försvann på tre dagar. Det paranormala engagemanget här är väldokumenterat — fotografer fångar konsekvent gestalter på bilder som inte är synliga för ögat, termometrar sjunker utan förklaring i Devil's Den och fotsteg och skott hörs av guiderna. Gettysburg anses vara USA:s mest hemsökta plats.","status":"published","free":false,"bookable":false,"bookingUrl":"","img":"","date":"2026","points":100,"categories":["USA","Övergiven"],"featured":false,"new":true,"slug":"int-us-04","url":"https://spokkartan.se/int-us-04"},{"id":"int-us-05","name":"Alcatraz Federal Penitentiary","country":"USA","region":"San Francisco, Kalifornien","type":"Fängelse","scary":4,"lat":37.827,"lng":-122.423,"teaser":"The Rock — ön det var omöjligt att fly från. Al Capone spelade banjo i kapellet för att hålla ångesten borta — nu hemsöks hans cell.","description":"Alcatraz Federal Penitentiary på San Francisco-bukten var aktivt 1934-1963 och höll USA:s mest ökände brottslingar: Al Capone, Machine Gun Kelly och George 'The Birdman'. Vakter rapporterade om oförklarliga ljud, skratt och steg i tomma celler. Cell 14D — isolationscellen — är känd för extrema kalla fläktar och känslan av ett ont presence. Park rangers berättar om en man i vit kappa som uppenbarat sig och sedan försvunnit och om skrik från Utility Corridor.","bookable":true,"bookingUrl":"https://www.alcatrazcruises.com/","status":"published","free":false,"img":"","date":"2026","points":80,"categories":["USA","Fängelse"],"featured":false,"new":true,"slug":"int-us-05","url":"https://spokkartan.se/int-us-05"},{"id":"int-us-06","name":"Waverly Hills Sanatorium","country":"USA","region":"Louisville, Kentucky","type":"Sanatorium","scary":5,"lat":38.179,"lng":-85.863,"teaser":"'The Body Chute' — tunneln man körde ut tusentals döda tuberkulospatienter genom för att inte demoralisera de levande.","description":"Waverly Hills Sanatorium öppnade 1910 för tuberkulospatienter när sjukdomen grasserade i Kentucky. Under sin storhetstid dog uppskattningsvis 63 000 patienter här — mer per capita än vid något annat sjukhus i USA. 'Death Tunnel' eller 'Body Chute' var en 152 meter lång sluttande tunnel som användes för att diskret transportera ut likerna. Rum 502 — där en sjuksköterska begick självmord — är det mest aktiva. Spökjägare från hela världen vallfärdar hit.","bookable":true,"bookingUrl":"https://www.therealwaverlyhills.com/","status":"published","free":false,"img":"","date":"2026","points":100,"categories":["USA","Sanatorium"],"featured":false,"new":true,"slug":"int-us-06","url":"https://spokkartan.se/int-us-06"},{"id":"int-us-07","name":"The Myrtles Plantation","country":"USA","region":"St. Francisville, Louisiana","type":"Herrgård","scary":4,"lat":30.759,"lng":-91.437,"teaser":"Byggt på 12 fornnordamerikanska gravar — slaven Chloe, som fick öronen avskurna och hängdes, syns fortfarande i fotografier.","description":"The Myrtles Plantation i Louisiana anlades 1796 på mark som var heligt för Tunica-indianerna. Det mest kända spöket är Chloe, en slavinna som enligt legenden förgiftade familjens kaka och hängdes av de andra slavarna i straff. Hennes gestalt i grön turban fångas konsekvent på fotografier. Spegeln i salongen — dit de döda familjerna sägs ha fastnat — är täckt med handavtryck som inte kan tvättas bort. En av USA:s mest fotograferade hemsökta platser.","bookable":true,"bookingUrl":"https://www.booking.com/searchresults.en.html?ss=Myrtles+Plantation","status":"published","free":false,"img":"","date":"2026","points":80,"categories":["USA","Herrgård"],"featured":false,"new":true,"slug":"int-us-07","url":"https://spokkartan.se/int-us-07"},{"id":"int-us-08","name":"Salem, Massachusetts","country":"USA","region":"Salem, Massachusetts","type":"Stad","scary":4,"lat":42.519,"lng":-70.899,"teaser":"De 19 orättfärdigt avrättades stad från häxprocesserna 1692 — hela staden är genomsyrad av deras öden.","description":"Salem, Massachusetts, är oupplösligt förknippat med häxprocesserna 1692 då 19 personer hängdes och en trycktes till döds anklagade för häxeri. Stadens mest hemsökta platser inkluderar Joshua Ward House (där domare Corwin bodde), Charter Street Cemetery och Witch Trials Memorial. Hundratals spökvandringen erbjuds varje år, och October — Haunted Happenings Festival — drar tiotusentals besökare. Medellångst hemsökt stad i Amerika.","status":"published","free":false,"bookable":false,"bookingUrl":"","img":"","date":"2026","points":80,"categories":["USA","Stad"],"featured":false,"new":true,"slug":"int-us-08","url":"https://spokkartan.se/int-us-08"},{"id":"int-de-01","name":"Burg Frankenstein","country":"Tyskland","region":"Darmstadt, Hessen","type":"Slott","scary":5,"lat":49.734,"lng":8.658,"teaser":"Det verkliga Frankenstein-slottet som inspirerade Mary Shelley — alkemisten Konrad Dippel försökte återuppliva döda och hans ande hemsöker fortfarande.","description":"Burg Frankenstein utanför Darmstadt anses ha inspirerat Mary Shelleys roman. Konrad Dippel von Frankenstein bodde här på 1700-talet — han var alkemist, gravplundrare och vetenskapsman som påstods ha försökt återuppliva döda med sin uppfinning 'Dippels olja'. Hans ande sägs visa sig på julafton och nyårsafton. SyFy:s Ghost Hunters International filmade ett avsnitt här och bekräftade 'signifikant paranormal aktivitet'. Slottet arrangerar Halloween-events.","status":"published","free":false,"bookable":false,"bookingUrl":"","img":"https://upload.wikimedia.org/wikipedia/commons/thumb/8/8b/Burg_Frankenstein_frontal.jpg/800px-Burg_Frankenstein_frontal.jpg","date":"2026","points":100,"categories":["Tyskland","Slott"],"featured":false,"new":true,"slug":"int-de-01","url":"https://spokkartan.se/int-de-01","img_credit":"Wikimedia Commons — CC BY-SA 3.0","img_author":"Wolkenkratzer"},{"id":"int-de-02","name":"Spandau Citadel","country":"Tyskland","region":"Berlin","type":"Fästning","scary":4,"lat":52.535,"lng":13.208,"teaser":"Berlins vita dam — Anna Sydow, fången av kurfursten Joachim II:s son, vandrar fortfarande i fästningens korridorer.","description":"Spandau Citadell i Berlin är en av Europas bäst bevarade renässansfästningar. Dess mest kända spöke är Anna Sydow — Kurfurst Joachim II:s älskarinna. På sin dödsbädd bad Joachim sin son ta hand om Sydow, men sonen lät istället fängsla henne i citadellet resten av livet. Hennes gestalt — den vita damen — rapporteras fortfarande vandra i de gamla murarna. Under WWII gömdes dessutom Hitlers byst och Tredje rikets skatter i citadellets tunnlar.","status":"published","free":false,"bookable":false,"bookingUrl":"","img":"","date":"2026","points":80,"categories":["Tyskland","Fästning"],"featured":false,"new":true,"slug":"int-de-02","url":"https://spokkartan.se/int-de-02"},{"id":"int-de-03","name":"Wewelsburg Castle","country":"Tyskland","region":"Büren, Nordrhein-Westfalen","type":"Slott","scary":5,"lat":51.606,"lng":8.649,"teaser":"SS-kvartershögen under Himmler — ockultism, ritualer och de lidandes andar präglar detta trekantiga slott.","description":"Wewelsburg i Nordrhein-Westfalen var Heinrich Himmlers SS-högkvarter under Tredje riket. Himmler var djupt intresserad av ockultism och använde slottet för SS-ritualer och occultistisk symbolik. Nordrummet med sin 'Svarta sol'-symbol var ritualmässans centrum. Tusentals tvångsarbetare från det angränsande koncentrationslägret Niederhagen dog under slottets ombyggnad 1939-1943. Paranormala utredare rapporterar om en överväldigande tyngd och ont presence.","status":"published","free":false,"bookable":false,"bookingUrl":"","img":"","date":"2026","points":100,"categories":["Tyskland","Slott"],"featured":false,"new":true,"slug":"int-de-03","url":"https://spokkartan.se/int-de-03"},{"id":"int-de-04","name":"Beelitz-Heilstätten","country":"Tyskland","region":"Brandenburg","type":"Sanatorium","scary":5,"lat":52.234,"lng":12.892,"teaser":"Europas en gång störste sjukhus — Hitler behandlades här efter Somme 1916, och nu filmas Skyfall och Walküre i de övergivna hallarna.","description":"Beelitz-Heilstätten i Brandenburg öppnade 1902 som ett massivt sanatorieomplex och var Europas största sjukhus med 60 byggnader. Adolf Hitler vårdades här efter att ha sårats vid Somme 1916. Under Kalla kriget övertos komplexet av Röda armén. Sedan ryssarna lämnade 1994 har komplexet stått övergivet — filmat i James Bond-filmen Valkyrie. Urbex-besökare rapporterar om tung atmosfär, fotsteg och gestalter.","status":"published","free":false,"bookable":false,"bookingUrl":"","img":"","date":"2026","points":100,"categories":["Tyskland","Sanatorium"],"featured":false,"new":true,"slug":"int-de-04","url":"https://spokkartan.se/int-de-04"},{"id":"int-de-05","name":"Heidelberg Castle","country":"Tyskland","region":"Heidelberg, Baden-Württemberg","type":"Slott","scary":3,"lat":49.41,"lng":8.714,"teaser":"Den store Frederick vandrar ruinerna — och Heidleberg var ursprungligen dömd av en häxas förbannelse.","description":"Heidelberg Slott är en av Tysklands mest ikoniska ruiner, konstruerad på 1200-talet. Legenden om häxans förbannelse säger att slottet kondemnades av en häxa vars familj drivits bort. Frederick den Store sägs fortfarande patrullera ruinerna nattetid och inspektera sitt forna rike. Besökare rapporterar om kalla fläktar i de slutna tornen och känslan av att observeras i de gamla festlokalerna.","status":"published","free":false,"bookable":false,"bookingUrl":"","img":"","date":"2026","points":60,"categories":["Tyskland","Slott"],"featured":false,"new":true,"slug":"int-de-05","url":"https://spokkartan.se/int-de-05"},{"id":"int-fi-01","name":"Finlands Nationalteater, Helsingfors","country":"Finland","region":"Helsingfors","type":"Urban","scary":3,"lat":60.171,"lng":24.944,"teaser":"Tre kända spöken: Den grå damen och skådespelarna Aarne Leppänen och Urho Somersalmi — inga nätter utan aktivitet backstage.","description":"Finlands Nationalteater i Helsingfors är ett av Nordeuropas mest kända spökhus inom kulturlivet. Tre välkända spöken håller till — den mystiska Grå Damen vars identitet aldrig fastställts, och skådespelarna Aarne Leppänen och Urho Somersalmi som tydligen inte lyckats ge upp sina roller. Personal backstage vittnar regelbundet om fotsteg, temperaturfall och en känsla av närvaro.","status":"published","free":false,"bookable":false,"bookingUrl":"","img":"","date":"2026","points":60,"categories":["Finland","Urban"],"featured":false,"new":true,"slug":"int-fi-01","url":"https://spokkartan.se/int-fi-01"},{"id":"int-fi-02","name":"Haihara Herrgård, Tammerfors","country":"Finland","region":"Tammerfors","type":"Herrgård","scary":4,"lat":61.477,"lng":23.865,"teaser":"Den blå tjänsteflickan hemsöker herrgården — en pigas tragiska öde lever kvar i Haihara.","description":"Haihara herrgård i Tammerfors är känt för Den blå tjänsteflickan — en pigas ande vars exakta historia är oklar men vars presence är välbekräftad. Besökare och personal vittnar om en blå gestalt som rör sig i de gamla rummen, om plötsliga kylförändringar och om dörrar som öppnas och stängs utan synlig orsak.","status":"published","free":false,"bookable":false,"bookingUrl":"","img":"","date":"2026","points":80,"categories":["Finland","Herrgård"],"featured":false,"new":true,"slug":"int-fi-02","url":"https://spokkartan.se/int-fi-02"},{"id":"int-fi-03","name":"Nummela Sanatorium","country":"Finland","region":"Röykkä, Nyland","type":"Sanatorium","scary":5,"lat":60.352,"lng":24.298,"teaser":"Det övergivna sjukhuset i Röykkä — spöklika ljus i fönstren och ett barnspöke som faller från taket om och om igen.","description":"Nummela Sanatorium i Röykkä har stått övergiven sedan det stängde. Platsen anses vara ett av Finlands mest hemsökta ställen. Mystiska ljus syns i fönstren och på taklisterna på natten — och det rapporteras om en ung flickas ande som tycks upprepa sin tragiska död, fallet från en av byggnadens övre plan.","status":"published","free":false,"bookable":false,"bookingUrl":"","img":"","date":"2026","points":100,"categories":["Finland","Sanatorium"],"featured":false,"new":true,"slug":"int-fi-03","url":"https://spokkartan.se/int-fi-03"},{"id":"int-no-01","name":"Fredriksten Fästning","country":"Norge","region":"Halden","type":"Fästning","scary":5,"lat":59.113,"lng":11.392,"teaser":"Karl XII sköts här 1718 — och den hvite damen söker fortfarande sin man längs vallarnas murar.","description":"Fredriksten fästning i Halden är platsen för Karl XII:s mystiska och omdebatterade död den 11 december 1718. Den svenske kungen dog av ett skott — antingen från norska befästningar eller av en av hans egna officerare. Den Hvite Dame — en vit gestalt — ses på fästningens vallar och söker sin man, en officer som stupade i striderna. Fästningens 700 år av historia har lämnat talrika paranormala spår.","bookable":true,"bookingUrl":"https://www.fredrikstenfestning.no/","status":"published","free":false,"img":"","date":"2026","points":100,"categories":["Norge","Fästning"],"featured":false,"new":true,"slug":"int-no-01","url":"https://spokkartan.se/int-no-01"},{"id":"int-dk-01","name":"Kronborg Slot (Hamlet's Castle)","country":"Danmark","region":"Helsingør","type":"Slott","scary":4,"lat":56.036,"lng":12.621,"teaser":"Hamlets slott vid Öresund — prins Hamlets faders ande vandrar fortfarande i kasematterna, och Holger Danske sover i källaren.","description":"Kronborg Slot i Helsingør är världsberömt som förlagan till Shakespeares Hamlet och är ett UNESCO-världsarv. Under slottet sover Holger Danske — den mytologiska hjälten som vaknar och försvarar Danmark om landet hotas. Prins Hamlets faders ande rapporteras vandra kasematterna nattetid. Slottet byggdes 1574-1585 och förstördes av brand 1629 men återuppbyggdes. En av Nordens mest besökta historiska platser.","bookable":true,"bookingUrl":"https://www.kongernes.dk/slotte/kronborg-slot/","status":"published","free":false,"img":"https://upload.wikimedia.org/wikipedia/commons/thumb/9/9b/Kronborg_castle.jpg/800px-Kronborg_castle.jpg","date":"2026","points":80,"categories":["Danmark","Slott"],"featured":false,"new":true,"slug":"int-dk-01","url":"https://spokkartan.se/int-dk-01","img_credit":"Wikimedia Commons — CC BY-SA","img_author":"Tomasz Sienicki"},{"id":"int-dk-02","name":"Hammershus Slot","country":"Danmark","region":"Bornholm","type":"Ruin","scary":3,"lat":55.298,"lng":14.775,"teaser":"Nordeuropas största medeltida borgruin på Bornholms klippiga nordkust — de inmurades andar lever i stenen.","description":"Hammershus Slot på Bornholm är Nordeuropas största medeltida borgruin. Fästningen byggdes på 1200-talet och stod i bruk till 1700-talet. Bland ruinerna berättas om andar från de som fängslades, torterats och dog bakom murarna under jahrhunderens konflikter. Platsen arrangerar spökvandring om hösten och stämningen vid skymning är omisskännlig.","status":"published","free":false,"bookable":false,"bookingUrl":"","img":"","date":"2026","points":60,"categories":["Danmark","Ruin"],"featured":false,"new":true,"slug":"int-dk-02","url":"https://spokkartan.se/int-dk-02"},{"id":"int-dk-03","name":"Rosenholm Gods","country":"Danmark","region":"Hornslet, Midtjylland","type":"Herrgård","scary":4,"lat":56.326,"lng":10.336,"teaser":"Godset vid Rosenholm Sø med en vit dam som visar sig inför dödsfall i familjens blodslinje.","description":"Rosenholm Gods nära Hornslet i Jutland är ett av Danmarks bäst bevarade herresäten med anor från 1500-talet. Spöket av en vit dam — en av de tidiga adelsfruar som dog tragiskt — sägs visa sig i godsets rum och trädgårdar inför dödsfall bland de som är kopplade till godset. Legenden är djupt rotad i lokal folklore.","status":"published","free":false,"bookable":false,"bookingUrl":"","img":"","date":"2026","points":80,"categories":["Danmark","Herrgård"],"featured":false,"new":true,"slug":"int-dk-03","url":"https://spokkartan.se/int-dk-03"},{"id":"int-pl-01","name":"Malbork Slott","country":"Polen","region":"Malbork, Pommern","type":"Slott","scary":4,"lat":54.039,"lng":19.028,"teaser":"Världens största gotiska tegelborg — Tyska Ordens befäste och ett levande museum med en väktargest som vandrar vallarna.","description":"Malbork Slott i norra Polen är världens största gotiska slott av tegel, byggt av Tyska Orden på 1200-talet. Under WWII ockuperades och skadades slottet svårt. Restaureringsarbeten har pågått sedan kriget. En väktargestalt i medeltida rustning ses på vallarnas topp vid skymning. Slottets underjordiska tunnlar och fängelsehålor anses vara de mest aktiva paranormalt.","bookable":true,"bookingUrl":"https://www.zamek.malbork.pl/","status":"published","free":false,"img":"https://upload.wikimedia.org/wikipedia/commons/thumb/9/97/Malbork_Castle_August_2013_repaired.jpg/800px-Malbork_Castle_August_2013_repaired.jpg","date":"2026","points":80,"categories":["Polen","Slott"],"featured":false,"new":true,"slug":"int-pl-01","url":"https://spokkartan.se/int-pl-01","img_credit":"Wikimedia Commons — CC BY-SA 3.0","img_author":"Mariusz Cieszewski"},{"id":"int-pl-02","name":"Auschwitz-Birkenau","country":"Polen","region":"Oświęcim, Lillpolen","type":"Museum","scary":5,"lat":50.027,"lng":19.203,"teaser":"Platsen för historiens kanske mörkaste händelse — besökare vittnar konsekvent om tyngd, överväldigande sorg och oförklarliga fotografier.","description":"Auschwitz-Birkenau är ett UNESCO-världsarv och minnesmärke över Förintelsen. Mer än 1,1 miljoner människor mördades här mellan 1940 och 1945. Besökare — även de som inte tror på paranormala fenomen — vittnar konsekvent om en fysisk tyngd, plötsliga temperaturfall och en känsla av sorg som inte kan sättas ord på. Fotografier som tas visar ibland former och ljus som inte var synliga för fotografen. Platsen är ett av de viktigaste historiska vittnesmålen i världen.","status":"published","free":false,"bookable":false,"bookingUrl":"","img":"","date":"2026","points":100,"categories":["Polen","Museum"],"featured":false,"new":true,"slug":"int-pl-02","url":"https://spokkartan.se/int-pl-02"},{"id":"int-pl-03","name":"Wawel Slott, Kraków","country":"Polen","region":"Kraków, Lillpolen","type":"Slott","scary":4,"lat":50.054,"lng":19.935,"teaser":"Polens kungliga slott på Vistulans klippa — Chakraen i källaren som sägs locka kosmisk energi och pilgrimernas oförklarliga upplevelser.","description":"Wawel Slott i Kraków är Polen och kungligheternas historiska residens sedan 1000-talet. En av de mest fascinerande aspekterna är tron på att ett av världens sju Chakra-centra befinner sig i slottets källare — en gammal hinduisk och esoterisk tradition. Pilgrimer vallfärdar hit och vittnar om kraftig energi, transtillstånd och visioner. Slottet rymmer dessutom otaliga historiska spöken från Polen dramatiska historia.","status":"published","free":false,"bookable":false,"bookingUrl":"","img":"","date":"2026","points":80,"categories":["Polen","Slott"],"featured":false,"new":true,"slug":"int-pl-03","url":"https://spokkartan.se/int-pl-03"},{"id":"int-nl-01","name":"Muiderslot Slott","country":"Nederländerna","region":"Muiden, Noord-Holland","type":"Slott","scary":4,"lat":52.332,"lng":5.072,"teaser":"Det medeltida slottet vid Vecht-flodens mynning — greven Floris V mördades här och vandrar fortfarande i tornen.","description":"Muiderslot utanför Amsterdam är ett av de bäst bevarade medeltida slotten i Nordeuropa, byggt 1285. Greven Floris V mördades brutalt i slottet 1296 av sina motståndare. Sedan dess rapporteras hans ande och rösterna av hans mördare i de gamla tornen. Slottet är nu ett museum med spökvandring under Halloween.","bookable":true,"bookingUrl":"https://www.muiderslot.nl/","status":"published","free":false,"img":"","date":"2026","points":80,"categories":["Nederländerna","Slott"],"featured":false,"new":true,"slug":"int-nl-01","url":"https://spokkartan.se/int-nl-01"},{"id":"int-nl-02","name":"Kasteel de Haar","country":"Nederländerna","region":"Haarzuilens, Utrecht","type":"Slott","scary":3,"lat":52.104,"lng":5.029,"teaser":"Hollands mest romantiska slott — och den döde arkitektens ande som fortfarande inspekterar restaureringen han drog i gång.","description":"Kasteel de Haar nära Utrecht är Hollands mest magnifika slott, ombyggt 1892-1912 av arkitekten Pierre Cuypers. Cuypers drog i gång den stora restaureringen och hann se den fullbordas. Men hans ande sägs fortfarande besöka slottet och inspektera arbetet. Personal vittnar om fotsteg i de nya vingarna, om dörrar som öppnas och om en gammal herres silhuett vid ritbordet i biblioteket.","status":"published","free":false,"bookable":false,"bookingUrl":"","img":"","date":"2026","points":60,"categories":["Nederländerna","Slott"],"featured":false,"new":true,"slug":"int-nl-02","url":"https://spokkartan.se/int-nl-02"},{"id":"uk-tower-of-london","name":"Tower of London","country":"Storbritannien","region":"London, England","type":"Fästning","scary":5,"lat":51.5082,"lng":-0.0762,"teaser":"Rapporterade fenomen omfattar processioner och apparitioner av avrättade fångar — Anne Boleyns spöke är det mest kända i hela England.","description":"Tower of London har i nästan tusen år varit både kungligt residens, avrättningsplats, fängelse och symbol för statsmakt. Den mörka historien är själva motorn bakom spöktraditionen. Anne Boleyns avhuggna huvud bärs under armen av en gestalt vid Tower Green. Lady Jane Grey och Sir Walter Raleigh sägs fortfarande vandra korridorerna. De två unga prinsarna — Edward V och Richard, hertig av York — mördade på order av Richard III 1483 — hemsöker Bloody Tower. Beefeater-vakter vittnar om nattliga händelser som inte kan förklaras av moderna medel.","img":"https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Tower_of_London_viewed_from_the_River_Thames.jpg/800px-Tower_of_London_viewed_from_the_River_Thames.jpg","bookable":false,"bookingUrl":"","status":"published","free":false,"points":100,"new":true,"featured":true,"date":"2026","categories":["UK","Fästning","London"],"slug":"tower-of-london","img_credit":"Wikimedia Commons — CC BY-SA 3.0","img_author":"Diliff"},{"id":"uk-hampton-court","name":"Hampton Court Palace","country":"Storbritannien","region":"Surrey, England","type":"Slott","scary":4,"lat":51.4034,"lng":-0.3375,"teaser":"Catherine Howards skrik hörs fortfarande i det långa galleriet — hon sprang och vädjade till Henrik VIII innan sin avrättning 1542.","description":"Hampton Court byggdes av kardinal Wolsey och övertogs av Henrik VIII. Catherine Howard, Henrik VIII:s femte hustru, slets ifrån kapellet dit hon sprungit för att be om nåd inför sin avrättning. Hennes skrik och gestalt rapporteras fortfarande i det långa galleriet. 2003 fångade övervakningskameror en gestalt i medeltida klädsel som öppnade en branddörr och sedan försvann. Jane Seymour har setts vid Silverhjulets trappa.","img":"https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Hampton_Court_Palace_from_the_Thames.jpg/800px-Hampton_Court_Palace_from_the_Thames.jpg","bookable":false,"bookingUrl":"","status":"published","free":false,"points":80,"new":true,"featured":false,"date":"2026","categories":["UK","Slott","Surrey"],"slug":"hampton-court-palace","img_credit":"Wikimedia Commons — CC BY-SA 3.0","img_author":"Wikimedia Commons"},{"id":"uk-berry-pomeroy","name":"Berry Pomeroy Castle","country":"Storbritannien","region":"Devon, England","type":"Ruin","scary":5,"lat":50.4493,"lng":-3.6365,"teaser":"Den blå och vita damen — två av Englands mest ökända spöken bor i dessa jakobinska ruiner. Ruinen är genuint farlig att besöka.","description":"Berry Pomeroy Castle i Devon anses vara ett av Englands mest hemsökta slott. Historiskt började anläggningen byggas om på 1500-talet till ett magnifikt residens, men övergavs omkring 1700. Blå Damen — andan av en herres dotter vars spädbarn stryptes av fadern — lockar besökare mot farliga delar av ruinen. Vita Damen är Lady Margaret Pomeroy, inlåst av sin avundsjuka syster tills hon svalt ihjäl. Ruinromantiken och det verkliga spökryktet gör platsen till en magnet för gotiska berättelser.","img":"https://commons.wikimedia.org/wiki/Special:FilePath/Berry_Pomeroy_Castle_-_geograph.org.uk_-_8105385.jpg","bookable":false,"bookingUrl":"","status":"published","free":false,"points":100,"new":true,"featured":false,"date":"2026","categories":["UK","Ruin","Devon"],"slug":"berry-pomeroy-castle","img_credit":"Wikimedia Commons — CC BY-SA 2.0","img_author":"Roger Cornfoot via geograph.org.uk"},{"id":"uk-bolsover-castle","name":"Bolsover Castle","country":"Storbritannien","region":"Derbyshire, England","type":"Slott","scary":4,"lat":53.2314,"lng":-1.2969,"teaser":"English Heritage beskriver Bolsover som ett av landets mest hemsökta slott — personalen för ett särskilt spökbok över alla rapporterade händelser.","description":"Bolsover Castle är ett av de mest dokumenterat hemsökta slotten i England enligt English Heritage. Personalen för ett särskilt 'ghost book' där alla rapporter om märkliga syner, ljud och dofter nedtecknas. Slottet skapades av familjen Cavendish som en tidig modern nöjes- och representationsmiljö, och den praktfulla arkitekturen kontrasterar mot de återkommande berättelserna om oförklarliga fenomen.","img":"","bookable":false,"bookingUrl":"","status":"published","free":false,"points":80,"new":true,"featured":false,"date":"2026","categories":["UK","Slott","Derbyshire"],"slug":"bolsover-castle"},{"id":"uk-carlisle-castle","name":"Carlisle Castle","country":"Storbritannien","region":"Cumbria, England","type":"Fästning","scary":4,"lat":54.8962,"lng":-2.9382,"teaser":"En blodig gränshistoria med belägringar och fångenskapens Licking Stones — kungliga och militära gestalter vandrar i de gamla gångarna.","description":"Carlisle Castle kopplas i officiellt English Heritage-material till återkommande spöksyner, bland annat berättelser om kunglig och militär närvaro i gångarna. Platsen har en ovanligt blodig gränshistoria med belägringar, fångenskap och hårda fängelseförhållanden. Fångar inmurade i källaren sades ha slickat fukt från stenarna för att överleva — dessa stenar kallas än i dag 'Licking Stones'. Just slottets dungeons har blivit centrala i den hemsökta bilden.","img":"","bookable":false,"bookingUrl":"","status":"published","free":false,"points":80,"new":true,"featured":false,"date":"2026","categories":["UK","Fästning","Cumbria"],"slug":"carlisle-castle"},{"id":"uk-treasurers-house","name":"Treasurer's House, York","country":"Storbritannien","region":"Yorkshire, England","type":"Herrgård","scary":4,"lat":53.963,"lng":-1.0808,"teaser":"Romerska soldater marscherar i källaren under huset — byggt ovanpå den romerska staden Eboracum, ett av världens mest dokumenterade spökvittnen.","description":"Treasurer's House är ett av de mest specifikt dokumenterade spökhansen i England. Officiella National Trust-sidan återger romerska soldater i källaren, en katt, barnsyner, cigarrdoft och en 'grey lady'. Huset står ovanpå den romerska staden Eboracum, och platsens långa brukskontinuitet — från romersk väg till medeltida och modern bostadsmiljö — förklarar varför så många lager av hemsökningsberättelser uppstått här. En ung hantlangare som arbetade i källaren på 1950-talet vittnade om att se romerska soldater marschera igenom väggen.","img":"https://commons.wikimedia.org/wiki/Special:FilePath/The_Treasurer%27s_House1.jpg","bookable":false,"bookingUrl":"","status":"published","free":false,"points":80,"new":true,"featured":false,"date":"2026","categories":["UK","Herrgård","Yorkshire"],"slug":"treasurers-house-york","img_credit":"Wikimedia Commons — CC BY-SA 2.0","img_author":"Wikimedia Commons"},{"id":"uk-blickling-hall","name":"Blickling Hall","country":"Storbritannien","region":"Norfolk, England","type":"Herrgård","scary":4,"lat":52.8109,"lng":1.2309,"teaser":"Anne Boleyn återvänder varje år på årsdagen av sin avrättning — med sitt avhuggna huvud i famnen — till sin gamla familjeegendom i Norfolk.","description":"Blickling Hall förknippas framför allt med Anne Boleyn-legenden, där hennes ande sägs återvända på årsdagen av hennes avrättning den 19 maj. Platsen är historiskt viktig som gammal Boleyn-egendom och senare Hobart-residens. Den långa ägarhistorien och 1500-talets kopplingar till hovpolitik är centrala för hemsökningsberättelsens genomslag i brittisk folkkultur.","img":"https://commons.wikimedia.org/wiki/Special:FilePath/Blickling_Hall_-_west_wing_-_geograph.org.uk_-_774820.jpg","bookable":false,"bookingUrl":"","status":"published","free":false,"points":80,"new":true,"featured":false,"date":"2026","categories":["UK","Herrgård","Norfolk"],"slug":"blickling-hall","img_credit":"Wikimedia Commons — CC BY-SA 2.0","img_author":"Evelyn Simak via geograph.org.uk"},{"id":"uk-corfe-castle","name":"Corfe Castle","country":"Storbritannien","region":"Dorset, England","type":"Ruin","scary":4,"lat":50.6395,"lng":-2.0566,"teaser":"En huvudlös kvinna i vitt vandrar på murarna — ett av Englands mest ikoniska inbördeskrigsslott, delvis förstört 1646.","description":"National Trust återger den klassiska berättelsen om en huvudlös kvinna i vitt som sägs vandra på murarna. Historiskt är Corfe ett av de mest ikoniska engelska inbördeskrigsslotten, delvis förstört 1646 av parlamentariska styrkor. Platsens mer än tusenåriga kungliga och militära förflutna gör den till en naturlig nod för förräderi- och spöktraditioner. Ruinerna tronar dramatiskt på en kulle och syns miltals.","img":"","bookable":false,"bookingUrl":"","status":"published","free":false,"points":80,"new":true,"featured":false,"date":"2026","categories":["UK","Ruin","Dorset"],"slug":"corfe-castle"},{"id":"uk-fyvie-castle","name":"Fyvie Castle","country":"Storbritannien","region":"Aberdeenshire, Skottland","type":"Slott","scary":4,"lat":57.445,"lng":-2.393,"teaser":"Green Lady — Lilias Drummond — och hennes sorg hemsöker Fyvie. Steg hörs i tomma rum och personalen vittnar om en konstant närvaro.","description":"Fyvie Castle är i National Trust for Scotlands material starkt knutet till 'Green Lady', ofta identifierad som Lilias Drummond som dog av sorg efter att ha behandlats illa av sin man. Besökare och personal har rapporterat steg och ljud i tomma rum. Slottet är ett av de mest berömda skotska exemplen där en familjetragedi och en konkret gestalt blivit själva varumärket för platsens hemsökningsprofil.","img":"","bookable":false,"bookingUrl":"","status":"published","free":false,"points":80,"new":true,"featured":false,"date":"2026","categories":["UK","Slott","Skottland"],"slug":"fyvie-castle"},{"id":"uk-crathes-castle","name":"Crathes Castle","country":"Storbritannien","region":"Aberdeenshire, Skottland","type":"Slott","scary":5,"lat":57.06,"lng":-2.444,"teaser":"Green Lady bär ett spädbarn — och under härden i samma rum hittades ett barnskelett. Historiens mörkaste bevis för ett spökes existens.","description":"Crathes förknippas med den berömda Green Lady, som i NTS berättelse ses bära ett spädbarn och återkomma till ett rum där ett barnskelett faktiskt påträffades under härden under renoveringsarbeten. Kombinationen av fysisk fyndhistoria och kontinuerliga vittnesmål har gjort platsen särskilt seglivad i spökfolkloren. Det välbevarade skotska tower house byggdes på 1500-talet.","img":"","bookable":false,"bookingUrl":"","status":"published","free":false,"points":100,"new":true,"featured":false,"date":"2026","categories":["UK","Slott","Skottland"],"slug":"crathes-castle"},{"id":"uk-culzean-castle","name":"Culzean Castle","country":"Storbritannien","region":"Ayrshire, Skottland","type":"Slott","scary":4,"lat":55.354,"lng":-4.791,"teaser":"En försvunnen pipare i grottorna under klipporna och apparitioner i State Bedroom — med dramatiskt kustläge vid Firth of Clyde.","description":"Culzean har flera officiellt återgivna spökberättelser: den försvunne piparen i grottorna under klipporna, apparitioner i State Bedroom och olika berörings­fenomen rapporterade av besökare och personal. Slottet är betydelsefullt för sin aristokratiska historia och sitt dramatiska kustläge. Underjordiska gångar och grottor spelar stor roll i platsens hemsökta topografi.","img":"","bookable":false,"bookingUrl":"","status":"published","free":false,"points":80,"new":true,"featured":false,"date":"2026","categories":["UK","Slott","Skottland"],"slug":"culzean-castle"},{"id":"uk-drum-castle","name":"Drum Castle","country":"Storbritannien","region":"Aberdeenshire, Skottland","type":"Slott","scary":3,"lat":57.1,"lng":-2.335,"teaser":"Unge Alexander Irvines skratt hörs fortfarande i huset — ett gammalt familjesäte där hemsökel­sen kopplas till ett barns tragiska bortgång.","description":"NTS beskriver Drum Castle som hem för flera spöken, särskilt den unge Alexander Irvine vars skratt och närvaro sägs återkomma i huset. Historiskt är det ett gammalt familjesäte med flera byggnadsfaser. Hemsökel­sen knyts inte primärt till krig eller avrättningar utan till barns död och släktminne — en ovanlig och mänskligare spökberättelse.","img":"","bookable":false,"bookingUrl":"","status":"published","free":false,"points":60,"new":true,"featured":false,"date":"2026","categories":["UK","Slott","Skottland"],"slug":"drum-castle"},{"id":"uk-falkland-palace","name":"Falkland Palace","country":"Storbritannien","region":"Fife, Skottland","type":"Slott","scary":3,"lat":56.252,"lng":-3.206,"teaser":"Grey Lady väntar på en soldatälskare som aldrig återvände — ett kungligt renässanspalats med en berättelse om förlust och evig väntan.","description":"Falkland Palace förknippas med Grey Lady, som i NTS tolkning sägs vänta på en soldatälskare som aldrig återvände. Det kungliga palatset har stark renässansprägel och var ett av Stuartdynastins favoritresidenser. Hemsöknings­berättelsen fokuserar på förlust och emotionell restenergi snarare än direkta våldsbrott.","img":"","bookable":false,"bookingUrl":"","status":"published","free":false,"points":60,"new":true,"featured":false,"date":"2026","categories":["UK","Slott","Skottland"],"slug":"falkland-palace"},{"id":"uk-balvenie-castle","name":"Balvenie Castle","country":"Storbritannien","region":"Moray, Skottland","type":"Ruin","scary":4,"lat":57.452,"lng":-3.127,"teaser":"En White Lady, oförklarlig stillhet och skuggor av hästar — en av Skottlands äldsta slottsmiljöer med spår av seklers maktstrider.","description":"VisitScotland beskriver Balvenie som en ruin där människor länge rapporterat en ovanlig stillhet, oförklarliga ljud och skuggfigurer, inklusive en White Lady och hästar. Den äldre stenborgen är viktig som en av Skottlands äldsta slottsmiljöer och bär tydliga spår av flera århundradens maktstrider. Ruinen ägs av familjen Duff of Fife och är öppen för besök.","img":"","bookable":false,"bookingUrl":"","status":"published","free":false,"points":80,"new":true,"featured":false,"date":"2026","categories":["UK","Ruin","Skottland"],"slug":"balvenie-castle"},{"id":"uk-castell-coch","name":"Castell Coch","country":"Storbritannien","region":"Cardiff, Wales","type":"Slott","scary":3,"lat":51.5356,"lng":-3.2549,"teaser":"Ett kavaliersspöke vid fotändan av sängen och skattkistor gömda i bergssidorna — ett romantiskt viktorian­skt nybygge på medeltida grund.","description":"Officiell walesisk turisminformation återger berättelsen om ett kavaliersspöke som setts stå vid fotändan av en säng, samt äldre skatt- och trollformels­legender kopplade till platsen. Slottet är anmärkningsvärt som ett 1800-talsromantiskt nybygge på ett äldre medeltida läge, ritat av William Burges åt Lord Bute. Nygotik, medeltidsfantasi och hemsökningsberättelser förstärker varandra.","img":"","bookable":false,"bookingUrl":"","status":"published","free":false,"points":60,"new":true,"featured":false,"date":"2026","categories":["UK","Slott","Wales"],"slug":"castell-coch"},{"id":"uk-caerphilly-castle","name":"Caerphilly Castle","country":"Storbritannien","region":"Caerphilly, Wales","type":"Slott","scary":4,"lat":51.5744,"lng":-3.2197,"teaser":"Green Lady rör sig mellan tornen och söker sin döde älskare — en av Wales största medeltida borgar med en kärlekstragedi inbyggd i murarna.","description":"Caerphillys mest kända spökfigur är Green Lady, som sägs röra sig mellan tornen i sökandet efter sin döde älskare. Slottet är historiskt betydelsefullt som en av Wales största medeltida borgar, byggd av Gilbert de Clare på 1260-talet. Den officiella turisthistorien binder hemsökel­sen direkt till en berättelse om kärlek, svartsjuka och plötslig död.","img":"","bookable":false,"bookingUrl":"","status":"published","free":false,"points":80,"new":true,"featured":false,"date":"2026","categories":["UK","Slott","Wales"],"slug":"caerphilly-castle"},{"id":"uk-margam-castle","name":"Margam Castle","country":"Storbritannien","region":"Neath Port Talbot, Wales","type":"Herrgård","scary":5,"lat":51.561,"lng":-3.734,"teaser":"Ett av Storbritanniens mest hemsökta hus — en mördad gamekeeper och barnröster i korridorerna i ett hus med tusentals år av historia.","description":"Margam Castle beskrivs officiellt som ett av Storbritanniens mest hemsökta hus, med rapporter om den mördade gamekeepern Robert Scott och lekande barnröster i korridorerna. Platsen är historiskt komplex — området har använts i årtusenden och rymde tidigare ett kloster innan 1800-talets nygotiska herrgård byggdes — vilket ger hemsöknings­narrativen flera tidslager.","img":"","bookable":false,"bookingUrl":"","status":"published","free":false,"points":100,"new":true,"featured":false,"date":"2026","categories":["UK","Herrgård","Wales"],"slug":"margam-castle"},{"id":"uk-skirrid-mountain-inn","name":"Skirrid Mountain Inn","country":"Storbritannien","region":"Monmouthshire, Wales","type":"Hotell","scary":5,"lat":51.84,"lng":-2.981,"teaser":"Över 180 hängningar utfördes här — gäster känner snaran runt halsen, hör soldatlät och ser glas flyga av sig självt.","description":"Skirrid Mountain Inn är ett ovanligt starkt officiellt exempel på ett hemsökt värdshus. Besökare har rapporterat parfymdoft, flygande glas, soldatlät och känslan av en snara runt halsen. Byggnaden fungerade också som domstol och avrättningsplats — berättelserna om över 180 hängningar är direkt integrerade i platsens hemsökta identitet. Värdshuset sägs vara ett av de äldsta i Wales.","img":"","bookable":true,"bookingUrl":"https://www.booking.com/searchresults.en.html?ss=Skirrid+Mountain+Inn","status":"published","free":false,"points":100,"new":true,"featured":false,"date":"2026","categories":["UK","Hotell","Wales"],"slug":"skirrid-mountain-inn"},{"id":"uk-gwrych-castle","name":"Gwrych Castle","country":"Storbritannien","region":"Conwy, Wales","type":"Ruin","scary":4,"lat":53.31,"lng":-3.73,"teaser":"Woman in White — grevinnan vars ande vandrar ruinerna — ett 1800-talsslott i förfall med populärkulturell exponering från I'm a Celebrity.","description":"Officiell walesisk turisminfo kopplar Gwrych till många observationer av spöken, särskilt 'Woman in White', identifierad som en grevinna. Slottet är ett tydligt exempel på hur 1800-talets romantiska slottsbyggen kan generera lika seglivade hemsökningsberättelser som genuina medeltidsruiner, särskilt när platsen är starkt laddad av förfall och populärkulturell exponering.","img":"","bookable":false,"bookingUrl":"","status":"published","free":false,"points":80,"new":true,"featured":false,"date":"2026","categories":["UK","Ruin","Wales"],"slug":"gwrych-castle"},{"id":"uk-ruthin-gaol","name":"Ruthin Gaol","country":"Storbritannien","region":"Denbighshire, Wales","type":"Fängelse","scary":4,"lat":53.114,"lng":-3.314,"teaser":"Dörrsmällar, mumlande röster och skratt i korridorerna — ett viktorianskt fängelse som höll regionens hårdast behandlade fångar.","description":"Visit Wales beskriver Ruthin Gaol som en plats där besökare återger dörrsmällar, mumlande röster, skratt i korridorerna och känslan av närvaro i mörkret. Fängelset är historiemässigt viktigt som en av regionens hårdast behandlade fångesanläggningar. Den paranormala berättelsen har en tydlig materiell och social kontext i de verkliga lidanden som skedde här.","img":"","bookable":false,"bookingUrl":"","status":"published","free":false,"points":80,"new":true,"featured":false,"date":"2026","categories":["UK","Fängelse","Wales"],"slug":"ruthin-gaol"},{"id":"uk-caldicot-castle","name":"Caldicot Castle","country":"Storbritannien","region":"Monmouthshire, Wales","type":"Slott","scary":3,"lat":51.5937,"lng":-2.7435,"teaser":"En normandisk borg med kunglig medeltidshistoria — och ett chilling dungeon där flera spöken sägs ha sitt tillhåll.","description":"Caldicot presenteras officiellt som ett slott där flera spöken sägs finnas, särskilt i det mörka slottsfängelset. Det är en normandisk anläggning som utvecklades i kunglig regi under medeltiden och senare restaurerades som viktorianskt familjehem. Både militär och domesticerad slottsmiljö ryms i samma hemsökningsberättelse.","img":"","bookable":false,"bookingUrl":"","status":"published","free":false,"points":60,"new":true,"featured":false,"date":"2026","categories":["UK","Slott","Wales"],"slug":"caldicot-castle"},{"id":"uk-craig-y-nos","name":"Craig y Nos Castle","country":"Storbritannien","region":"Powys, Wales","type":"Hotell","scary":5,"lat":51.824,"lng":-3.69,"teaser":"Visit Wales kallar Craig y Nos det mest hemsökta slottet i Wales — operastjärnans hem som förvandlats till ett paranormalt övernattningshotell.","description":"Visit Wales kallar Craig y Nos 'det mest hemsökta slottet i Wales'. Historiskt är slottet främst känt som hem för Adelina Patti, en av 1800-talets stora operastjärnor. Den starka personhistorien, den senare institutionsanvändningen och den isolerade landskapsmiljön har gjort platsen särskilt mottaglig för hemsökningsnarrativ. Erbjuder paranormala övernattningar.","img":"","bookable":true,"bookingUrl":"https://www.booking.com/searchresults.en.html?ss=Craig+y+Nos+Castle","status":"published","free":false,"points":100,"new":true,"featured":false,"date":"2026","categories":["UK","Hotell","Wales"],"slug":"craig-y-nos-castle"},{"id":"uk-ballygally-castle","name":"Ballygally Castle Hotel","country":"Storbritannien","region":"County Antrim, Nordirland","type":"Hotell","scary":3,"lat":54.892,"lng":-5.857,"teaser":"Ett vänligt spöke och ett särskilt spökrum — en 1600-tals befäst bostad som blivit ett hotell med sin folkloriska identitet intakt.","description":"Discover Northern Ireland beskriver Ballygally som ett hotell som hemsöks av ett vänligt spöke, och lyfter fram det särskilda 'ghost room'. Byggnaden är ett ovanligt tydligt exempel på hur en 1600-tals befäst bostad övergått till hotell men behållit sin folkloriska hemsökningsprofil som en del av platsens publika identitet. Erbjuder övernattning med spöktematik.","img":"","bookable":true,"bookingUrl":"https://www.booking.com/searchresults.en.html?ss=Ballygally+Castle+Hotel","status":"published","free":false,"points":60,"new":true,"featured":false,"date":"2026","categories":["UK","Hotell","Nordirland"],"slug":"ballygally-castle-hotel"},{"id":"uk-hillsborough-castle","name":"Hillsborough Castle","country":"Storbritannien","region":"County Down, Nordirland","type":"Slott","scary":3,"lat":54.4609,"lng":-6.0885,"teaser":"Officiellt residens i Nordirland — personal vittnar om oförklarliga ljud, steg i tomma rum och smällande dörrar i de historiska salarna.","description":"Hillsborough Castle behandlar hemsökningsmotivet försiktigt men officiellt. Personal har rapporterat oförklarliga ljud, steg i tomma rum och smällande dörrar. Platsen är historiskt viktig både som storslaget familjehem och som officiell residens- och förhandlingsmiljö i Nordirland, vilket ger hemsökningsberättelsen en institutionellt ovanlig tyngd.","img":"","bookable":false,"bookingUrl":"","status":"published","free":false,"points":60,"new":true,"featured":false,"date":"2026","categories":["UK","Slott","Nordirland"],"slug":"hillsborough-castle"},{"id":"uk-crumlin-road-gaol","name":"Crumlin Road Gaol","country":"Storbritannien","region":"Belfast, Nordirland","type":"Fängelse","scary":5,"lat":54.613,"lng":-5.938,"teaser":"Ett av Irlands mest hemsökta platser — ett viktorianskt fängelsemuseum med avrättningar, isolering och ett trauma som fortfarande är kännbart.","description":"Crumlin Road Gaol marknadsförs officiellt som ett stort viktorianskt fängelsemuseum, men beskrivs också som en av Irlands mest hemsökta platser. Den mörka fängelsehistorian — isolering, avrättningar och lång användning inom straffsystemet — gör att platsen befinner sig i gränslandet mellan dokumenterat trauma och hemsökningskultur. Erbjuder kvällsvandringar och paranormala turer.","img":"","bookable":true,"bookingUrl":"https://www.crumlinroadgaol.com/","status":"published","free":false,"points":100,"new":true,"featured":false,"date":"2026","categories":["UK","Fängelse","Nordirland"],"slug":"crumlin-road-gaol"},{"id":"dk-dragsholm-slot","name":"Dragsholm Slot","country":"Danmark","region":"Sjælland","type":"Slott","scary":5,"lat":55.7708,"lng":11.3903,"teaser":"Danmarks mest dokumenterade hemsökta plats med över 100 genfärder — jarlen av Bothwell kedjades här i 10 år och Vita Damen hittades inmurad med sitt skelett på 1930-talet.","description":"Dragsholm Slot grundades omkring 1215 av biskopen i Roskilde och fungerade efter reformationen 1536 som statsfängelse för högreståndsfångar. James Hepburn, 4:e jarlen av Bothwell och Maria Stuarts tredje make, hölls kedjad vid en pelare i tio år fram till sin död 1578. Besökare hör ljud av hans spöklika vagn rulla in i borggården. Vita Damen — Celina Bolves — inmurads levande av sin far efter att ha blivit gravid med en ofrälse arbetare. På 1930-talet hittade hantverkare under restaurering ett skelett i vit klänning inuti en av väggarna — ett av de starkaste fysiska bevisen för ett spöksagns verkliga rot. Slottet sägs hysa över 100 enskilda genfärder, inklusive en Grå Dam.","img":"https://upload.wikimedia.org/wikipedia/commons/thumb/c/cf/DragsholmBuilding.jpg/800px-DragsholmBuilding.jpg","bookable":true,"bookingUrl":"https://www.booking.com/searchresults.en.html?ss=Dragsholm+Slot","status":"published","free":false,"points":100,"new":true,"featured":true,"date":"2026","categories":["Danmark","Slott","Sjælland"],"slug":"dragsholm-slot","img_credit":"Wikimedia Commons — CC BY-SA 3.0","img_author":"Niels Elgaard Larsen"},{"id":"dk-spottrup-borg","name":"Spøttrup Borg","country":"Danmark","region":"Midtjylland","type":"Fästning","scary":4,"lat":56.6397,"lng":8.7828,"teaser":"Studekongen Nis Nissen vaktar fortfarande sin borg vid Limfjorden — 13 till 14 olika genfärder rör sig i de kalla medeltida salarna.","description":"Spøttrup Borg vid Limfjorden representerar den råa medeltida försvarsarkitekturen i sin renaste form. Dess hemsökelser är starkt kopplade till den legendariske 'Studekongen' Nis Nissen, som ägde borgen under 1800-talet och var känd för sin extrema sparsamhet som gränsade till det groteska. Hans närvaro sägs fortfarande vaka över borgen. Spøttrup sägs hysa mellan 13 och 14 olika genfärder som rör sig i de kalla salarna, inklusive en Vita Dam med okänd identitet.","img":"","bookable":false,"bookingUrl":"","status":"published","free":false,"points":80,"new":true,"featured":false,"date":"2026","categories":["Danmark","Fästning","Jylland"],"slug":"spottrup-borg"},{"id":"dk-voergaard-slot","name":"Voergaard Slot","country":"Danmark","region":"Nordjylland","type":"Slott","scary":5,"lat":57.2422,"lng":10.3344,"teaser":"Ingeborg Skeel — tyrann och genfärd — släcker ljus och vandrar med jämmerlig röst. Blodfläcken i tornrummet återkommer varje gång man sliper bort den.","description":"Voergaard Slot domineras av sin ökände ägare Ingeborg Skeel, som styrde egendomen mellan 1578 och 1604. Hon anklagas för att ha skubbet arkitekten i vallgraven och misshandlat underlydande. Som genfärd sägs hon släcka ljus, smälla i dörrar och vandra med en jämmerlig röst. Den oförklarliga blodfläcken i tornrummet — blodet från en ung flicka hon lät mörda — återkommer ständigt trots upprepade försök att slipa bort den. Vid kemisk analys 1997 bekräftades fläckens blodlika sammansättning. En kulturell traumaminnesplats av rang.","img":"","bookable":false,"bookingUrl":"","status":"published","free":false,"points":100,"new":true,"featured":false,"date":"2026","categories":["Danmark","Slott","Nordjylland"],"slug":"voergaard-slot"},{"id":"dk-kronborg-slot","name":"Kronborg Slot","country":"Danmark","region":"Nordsjälland","type":"Slott","scary":4,"lat":56.0392,"lng":12.6225,"teaser":"Hamlets slott vid Öresund — Holger Danske sover i källaren och väntar på att Danmark ska behöva honom. Prins Hamlets faders ande vandrar vallarna.","description":"Kronborg Slot i Helsingør är världsberömt som förlagan till Shakespeares Hamlet och UNESCO-världsarv, byggt 1574–1585. Under slottet sover Holger Danske — den mytologiske hjälten som vaknar och försvarar Danmark om landet hotas. Prins Hamlets faders ande rapporteras vandra kasematterna. Akustiska fenomen och steg hörs regelbundet av vakter och nattanställda i de underjordiska gångarna.","img":"https://upload.wikimedia.org/wikipedia/commons/thumb/9/9b/Kronborg_castle.jpg/800px-Kronborg_castle.jpg","bookable":true,"bookingUrl":"https://www.kongernes.dk/slotte/kronborg-slot/","status":"published","free":false,"points":80,"new":true,"featured":false,"date":"2026","categories":["Danmark","Slott","Nordsjælland"],"slug":"kronborg-slot","img_credit":"Wikimedia Commons — CC BY-SA","img_author":"Tomasz Sienicki"},{"id":"dk-egeskov-slot","name":"Egeskov Slot","country":"Danmark","region":"Fyn","type":"Slott","scary":4,"lat":55.1764,"lng":10.4894,"teaser":"Trädockan som inte får flyttas — annars störtar slottet i vallgraven julnatten. Och Rigborg Brockenhuus, inlåst i tornet i fem år, vandrar fortfarande.","description":"Egeskov Slot på Fyn är en av Europas bäst bevarade vattenborgar från renässansen. Trädockan som vilar på loftet får aldrig flyttas — annars störtar hela Egeskov i vallgraven nästa julnatt, enligt ett seglivat sagn som fungerar som rituell skyddsmekanism. Rigborg Brockenhuus, dotter till slottets byggherre, hölls inlåst i tornet i fem år som straff för att ha blivit gravid utanför äktenskapet. Vita Damen i vit klänning vandrar fortfarande i korridorerna.","img":"https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Egeskov_Slot.jpg/800px-Egeskov_Slot.jpg","bookable":true,"bookingUrl":"https://www.booking.com/searchresults.en.html?ss=Egeskov+Slot","status":"published","free":false,"points":80,"new":true,"featured":false,"date":"2026","categories":["Danmark","Slott","Fyn"],"slug":"egeskov-slot","img_credit":"Wikimedia Commons — CC BY-SA","img_author":"Wikimedia Commons"},{"id":"dk-aalborghus-slot","name":"Aalborghus Slot","country":"Danmark","region":"Nordjylland","type":"Fästning","scary":5,"lat":57.0494,"lng":9.9242,"teaser":"Tio kvinnor brändes på bål 1620 anklagade för häxeri — fängelsehålan bär fortfarande deras närvaro med en tryckt atmosfär som inte försvinner.","description":"I fängelsehålan på Aalborghus Slot hölls tio kvinnor fängslade 1620 anklagade för häxeri. De dömdes för att ha skapat ett voksbarn för att förhäxa en rådmans hustru och brändes slutligen på bål. Idag upplevs fängelsehålan som en plats med extremt tung atmosfär, där ekon av de dödsdömda kvinnornas närvaro sägs dröja kvar. En av de mörkaste platserna i danskt häxprocessarv.","img":"","bookable":false,"bookingUrl":"","status":"published","free":false,"points":100,"new":true,"featured":false,"date":"2026","categories":["Danmark","Fästning","Nordjylland"],"slug":"aalborghus-slot"},{"id":"dk-rosenholm-slot","name":"Rosenholm Slot","country":"Danmark","region":"Midtjylland","type":"Slott","scary":4,"lat":56.3319,"lng":10.3311,"teaser":"En inmurad adelskvinna och en huvudlös riddare — hålrum med skelettdelar hittades under renovering, precis som sagnet beskriver.","description":"Rosenholm Slot i Jutland förknippas med en inmurad adelskvinna och en huvudlös riddare som vandrar i slottets djupaste rum. Sagnets trovärdighet stärks av att hålrum med skelettdelar faktiskt hittades i tornkammaren under renovering — en parallell till Dragsholms Vita Dam. Godset är ett av Danmarks bäst bevarade herrensäten med anor från 1500-talet.","img":"","bookable":false,"bookingUrl":"","status":"published","free":false,"points":80,"new":true,"featured":false,"date":"2026","categories":["Danmark","Slott","Jylland"],"slug":"rosenholm-slot"},{"id":"dk-selsø-slot","name":"Selsø Slot","country":"Danmark","region":"Sjælland","type":"Slott","scary":4,"lat":55.7422,"lng":12.0106,"teaser":"Anne Munk hölls i husarrest i 12 år av sin man — hennes fotsteg och suckar hörs i de barocksalar som saknar el och vatten än idag.","description":"Selsø Slot vid Roskilde Fjord saknar fortfarande el och vatten, vilket skapar en atmosfär av frusen tid. Anne Munk, hustru till riksamiral Mogens Ulfeldt, hölls i husarrest på Selsø i över tolv år vid 1600-talets början — sannolikt på grund av ett påstått utomäktenskapligt förhållande. Hennes närvaro manifesterar sig som fotsteg och suckar i slottets barocksalar. Slottets 150-åriga glömska som övergiven ruin har bevarat berättelserna om 'spökslottet' intakta.","img":"","bookable":false,"bookingUrl":"","status":"published","free":false,"points":80,"new":true,"featured":false,"date":"2026","categories":["Danmark","Slott","Sjælland"],"slug":"selsø-slot"},{"id":"dk-børglum-kloster","name":"Børglum Kloster","country":"Danmark","region":"Nordjylland","type":"Kyrka","scary":5,"lat":57.3139,"lng":9.5292,"teaser":"Byggnaden som försvinner för dem som söker den — H.C. Andersen noterade fenomenet 1859. Vita nunnor inmurads i hemliga gångar och barnskelett hittades utanför källarmuren.","description":"Børglum Kloster på en kulle i Vendsyssel har en historia från 1000-talet som kungsgård för Knud den Hellige. Fenomenet att byggnaden 'försvinner' för dem som söker den beskrevs av H.C. Andersen under hans besök 1859. De vita nunnorna — mördade eller inmurads i hemliga gångar som förbandt Børglum med kringliggande platser — är de mest frekventa observationerna. Arkeologiska fynd av barnskelett nära dessa murar ger en dyster fond till berättelserna om förbjudna relationer mellan munkar och nunnor.","img":"https://upload.wikimedia.org/wikipedia/commons/thumb/d/d4/B%C3%B8rglum_Kloster_jth.jpg/800px-B%C3%B8rglum_Kloster_jth.jpg","bookable":false,"bookingUrl":"","status":"published","free":false,"points":100,"new":true,"featured":false,"date":"2026","categories":["Danmark","Kyrka","Nordjylland"],"slug":"børglum-kloster","img_credit":"Wikimedia Commons — Public Domain","img_author":"J.Th. Hansen, 1899"},{"id":"dk-gram-slot","name":"Gram Slot","country":"Danmark","region":"Sønderjylland","type":"Slott","scary":3,"lat":55.2944,"lng":9.0472,"teaser":"Grevinnan Anne Sophie Schacks sorgliga presence dröjer kvar i de gamla salarna — en adelsdam vars historia är oupplösligt knuten till slottets öde.","description":"Gram Slot i Sønderjylland förknippas med grevinnan Anne Sophie Schack, vars sorgliga presence sägs dröja kvar i de gamla salarna. Slottet har anor från medeltiden och är ett av Sønderjyllands bäst bevarade herresäten. Grevinnan Schacks historia är oupplösligt knuten till slottets öde och de sociala begränsningar som präglade 1700-talets danska adelsliv.","img":"","bookable":true,"bookingUrl":"https://www.booking.com/searchresults.en.html?ss=Gram+Slot","status":"published","free":false,"points":60,"new":true,"featured":false,"date":"2026","categories":["Danmark","Slott","Sønderjylland"],"slug":"gram-slot"},{"id":"dk-helnan-phønix","name":"Helnan Phønix Hotel","country":"Danmark","region":"Nordjylland","type":"Hotell","scary":5,"lat":57.0486,"lng":9.9181,"teaser":"Brigadör von Halling bröt ett led på sin hustru för varje år hon inte blev gravid — och murade slutligen in henne i källaren. Hennes ande hjälper fortfarande till i hotellets kök.","description":"Helnan Phønix Hotel i Aalborg huserar i en byggnad från 1700-talet med en mörk koppling till brigadör William von Halling. Halling, som återvände från Indien med slavar, sägs ha brutit ett led på sin hustru för varje år barnlösheten varade — och till sist murade in henne i källaren. En hjälpsam spök-städjungfru och en diskare som fortfarande utför sina sysslor sägs röra sig i hotellets dolda vrår. En av Danmarks mörkaste hotellhistorier.","img":"","bookable":true,"bookingUrl":"https://www.booking.com/searchresults.en.html?ss=Helnan+Phønix+Hotel+Aalborg","status":"published","free":false,"points":100,"new":true,"featured":false,"date":"2026","categories":["Danmark","Hotell","Nordjylland"],"slug":"helnan-phønix-hotel"},{"id":"dk-hindsgavl-slot","name":"Hindsgavl Slot","country":"Danmark","region":"Fyn","type":"Hotell","scary":4,"lat":55.5047,"lng":9.7014,"teaser":"Den drunknade bruden visar sig bara för män — i det gröna rummet 146 flyttar hon stolar och släcker ljus. Hon dog i en vagnolycka strax före sitt bröllop.","description":"Hindsgavl Slot på Fyns västspets vid Lillebält hyser en Vita Dam — en ung brud som dog i en vagnolycka i slottsparken strax före sitt bröllop. Hon visar sig endast för män, ofta i rum 146, där hon manifesterar sin närvaro genom att flytta stolar och blåsa ut ljus. Slottets historia sträcker sig till 1200-talet och platsen har varit skådeplats för viktiga möten mellan danska och norska kungar. Idag ett konferenshotell.","img":"","bookable":true,"bookingUrl":"https://www.booking.com/searchresults.en.html?ss=Hindsgavl+Slot","status":"published","free":false,"points":80,"new":true,"featured":false,"date":"2026","categories":["Danmark","Hotell","Fyn"],"slug":"hindsgavl-slot"},{"id":"dk-koldinghus","name":"Koldinghus","country":"Danmark","region":"Syddjylland","type":"Slott","scary":4,"lat":55.4917,"lng":9.4744,"teaser":"Christian VII och dronning Dorothea vandrar genom de tomma salarna för att se att allt står rätt till — ett slott som brann 1808 och aldrig helt återhämtade sig.","description":"Koldinghus, det sista kungaslottet på Jylland, hade en dramatisk historia och förstördes i branden 1808. Idag hemsöks slottet av figurer från dess storhetstid — Christian VII och dronning Dorothea sägs vandra genom de delvis restaurerade salarna på natten. Slottet är nu ett museum med medeltida murar och en fascinerande blandning av historiska epoker.","img":"","bookable":false,"bookingUrl":"","status":"published","free":false,"points":80,"new":true,"featured":false,"date":"2026","categories":["Danmark","Slott","Jylland"],"slug":"koldinghus"},{"id":"dk-gurre-slotsruin","name":"Gurre Slotsruin","country":"Danmark","region":"Nordsjælland","type":"Ruin","scary":4,"lat":56.0197,"lng":12.505,"teaser":"Valdemar Atterdag jagas av Hin Onde nattetid för att han satte jakten före Gud — hans vilda jakt och kärleken till Tove lever kvar i ruinen.","description":"Gurre Slotsruin i Nordsjælland kopplas till Valdemar Atterdag och den tragiska kärlekshistorien om Tove, kungens älskarinna. Legenden säger att Valdemar satte jakten framför Gud och straffades med att jagas av Hin Onde varje natt i evighet. Den nattliga jakten hörs fortfarande enligt lokala berättelser. Ruinen är ett av de äldsta kungliga residenserna i Danmark.","img":"","bookable":false,"bookingUrl":"","status":"published","free":false,"points":80,"new":true,"featured":false,"date":"2026","categories":["Danmark","Ruin","Nordsjælland"],"slug":"gurre-slotsruin"},{"id":"dk-clausholm-slot","name":"Clausholm Slot","country":"Danmark","region":"Midtjylland","type":"Slott","scary":4,"lat":56.385,"lng":10.17,"teaser":"Anna Sophie Reventlow — den kidnappade drottningen — och de 8 barnen vandrar i Clausholms barockkorridorer.","description":"Clausholm Slot förknippas med Anna Sophie Reventlow, som kidnappades och tvingades gifta sig med Fredrik IV av Danmark. Efter kungens död hölls hon i husarrest på Clausholm i decennier. Hennes ande och de åtta barnens närvaro rapporteras i slottets barockkorridorer. Slottet är ett praktfullt exempel på dansk barock och ett av de få slotten som bevarats nästan intakta sedan 1700-talet.","img":"","bookable":false,"bookingUrl":"","status":"published","free":false,"points":80,"new":true,"featured":false,"date":"2026","categories":["Danmark","Slott","Jylland"],"slug":"clausholm-slot"},{"id":"dk-nyhavn-15","name":"Nyhavn 15","country":"Danmark","region":"Köpenhamn","type":"Spökhus","scary":3,"lat":55.6806,"lng":12.5897,"teaser":"En bedragen möllare hängde sig på vinden och hemsöker huset — aktiviteten upphör bara om man nämner flickvännens namn: Ane.","description":"Nyhavn 15, ett historiskt borgerhus från 1600-talets slut, bär på historien om en bedragen möllare. Han förlorade allt — inklusive sin flickvän Ane — i ett tärningsspel mot husets ägare Jørgen Alsing. I förtvivlan hängde han sig på vinden. Hemsökelseaktiviteten sägs endast upphöra om man nämner flickans namn, Ane. Ett av Köpenhamns mest specifika och välberättade spöksagn.","img":"","bookable":false,"bookingUrl":"","status":"published","free":false,"points":60,"new":true,"featured":false,"date":"2026","categories":["Danmark","Spökhus","Köpenhamn"],"slug":"nyhavn-15"},{"id":"dk-sønderskov-slot","name":"Sønderskov Slot","country":"Danmark","region":"Syddjylland","type":"Slott","scary":4,"lat":55.4472,"lng":9.025,"teaser":"Den vita jungfrun och spädbarnet — ett barnskelett hittades faktiskt under stenläggningen i kostalen, precis som sagnet berättar.","description":"Sønderskov Slot förknippas med Den vita jungfrun och ett gömt spädbarn. Sagnets trovärdighet befästes när ett barnskelett faktiskt hittades under stenläggningen i kostalen under renovering — ett av de klaraste arkeologiska bekräftelserna av ett danskt spöksagn. Platsen berättar om de dolda tragedier som präglade 1600- och 1700-talens danska bondesamhälle.","img":"","bookable":false,"bookingUrl":"","status":"published","free":false,"points":80,"new":true,"featured":false,"date":"2026","categories":["Danmark","Slott","Jylland"],"slug":"sønderskov-slot"},{"id":"dk-engelsholm-slot","name":"Engelsholm Slot","country":"Danmark","region":"Midtjylland","type":"Slott","scary":3,"lat":55.7125,"lng":9.244,"teaser":"En mörk gestalt i skötefrock och Knud Brahe — herresätets hemliga besökare som rör sig i de gamla salarna efter midnatt.","description":"Engelsholm Slot i Midtjylland hemsöks av en mörk gestalt i skötefrock — en klädsel som för tankarna till 1600-talets adel — identifierad av vissa som Knud Brahe. Slottet är ett välbevarat herresäte med anor från 1500-talet och omges av en pittoresk sjö och park.","img":"","bookable":false,"bookingUrl":"","status":"published","free":false,"points":60,"new":true,"featured":false,"date":"2026","categories":["Danmark","Slott","Jylland"],"slug":"engelsholm-slot"},{"id":"dk-cisternerne","name":"Cisternerne","country":"Danmark","region":"Frederiksberg","type":"Urban","scary":3,"lat":55.6697,"lng":12.5238,"teaser":"Under Frederiksberg — gamla vattenreservoarer med oförklarliga ekon och skepnader som lockar paranormala utredare och turister.","description":"Cisternerne under Frederiksberg är gamla underjordiska vattenreservoarer som nu fungerar som konstrum och upplevelserum. I de mörka välvda utrymmena rapporteras oförklarliga ljud, ekon utan källa och skepnader som rör sig i periferin. Platsen drar till sig både konstnärer och paranormala utredare och erbjuder ett unikt underjordiskt Köpenhamn.","img":"","bookable":true,"bookingUrl":"https://cisternerne.dk/","status":"published","free":false,"points":60,"new":true,"featured":false,"date":"2026","categories":["Danmark","Urban","Köpenhamn"],"slug":"cisternerne"},{"id":"dk-sæbygaard","name":"Sæbygaard Slot","country":"Danmark","region":"Nordjylland","type":"Slott","scary":4,"lat":57.3306,"lng":10.4814,"teaser":"Karen Skeel — den 'falska' häxan — dömdes och avrättades trots sin oskuld. Hennes ande söker fortfarande den rättvisa hon aldrig fick.","description":"Sæbygaard Slot förknippas med Karen Skeel, anklagad för häxeri på 1600-talet och dömd trots sin oskuld. Hennes ande söker fortfarande den rättvisa hon aldrig fick i livet. Häxprocessernas epok lämnade djupa spår i det nordjyska samhället, och Sæbygaard är ett av de platser där detta trauma är som mest kännbart.","img":"","bookable":false,"bookingUrl":"","status":"published","free":false,"points":80,"new":true,"featured":false,"date":"2026","categories":["Danmark","Slott","Nordjylland"],"slug":"sæbygaard-slot"},{"id":"dk-broholm-slot","name":"Broholm Slot","country":"Danmark","region":"Fyn","type":"Slott","scary":3,"lat":55.1333,"lng":10.725,"teaser":"Grå Damen — en beskyddande tjänsteflicka — vaktar fortfarande Broholm och ser till att gästerna har det bra.","description":"Broholm Slot på Fyn hemsöks av Grå Damen — inte en hotfull gestalt utan en beskyddande tjänsteflicka som i döden fortsätter sitt arbete. Hennes presence upplevs som välgörande snarare än skrämmande, vilket gör Broholm till ett av de mer ovanliga danska spökslotten. Slottet har anor från medeltiden och är omgivet av vacker natur.","img":"","bookable":false,"bookingUrl":"","status":"published","free":false,"points":60,"new":true,"featured":false,"date":"2026","categories":["Danmark","Slott","Fyn"],"slug":"broholm-slot"},{"id":"dk-gammel-estrup","name":"Gammel Estrup","country":"Danmark","region":"Midtjylland","type":"Herrgård","scary":3,"lat":56.4381,"lng":10.3444,"teaser":"Historiska herrgårdsspöken från en av Jyllands mest välbevarade renässansherrgårdar — nu Danmarks Herregårdsmuseum.","description":"Gammel Estrup i Midtjylland är en av de bäst bevarade renässansherrgårdarna i Danmark och huserar nu Danmarks Herregårdsmuseum. Bakom de vackra fasaderna döljer sig historiska spökberättelser kopplade till herrskapets komplexa historia. Personalen vittnar om oförklarliga ljud och en känsla av närvaro i de äldsta delarna av byggnaden.","img":"","bookable":false,"bookingUrl":"","status":"published","free":false,"points":60,"new":true,"featured":false,"date":"2026","categories":["Danmark","Herrgård","Jylland"],"slug":"gammel-estrup"},{"id":"dk-lykkesholm-slot","name":"Lykkesholm Slot","country":"Danmark","region":"Fyn","type":"Slott","scary":3,"lat":55.2456,"lng":10.6071,"teaser":"Spökkaret och H.C. Andersens tornvärelse — den store sagoberättaren besökte Lykkesholm och lämnade mer än ord bakom sig.","description":"Lykkesholm Slot på Fyn förknippas med H.C. Andersen, som besökte slottet och bodde i tornvärelsen. Spökkaret — en mystisk vagn som hörs om nätterna — är platsens mest kända paranormala fenomen. Slottet är ett pittoreskt renässanssäte omgivet av bokskog och spegeldammar.","img":"","bookable":false,"bookingUrl":"","status":"published","free":false,"points":60,"new":true,"featured":false,"date":"2026","categories":["Danmark","Slott","Fyn"],"slug":"lykkesholm-slot"}]);

  // ── Hämta platser från Supabase vid uppstart ──────────────
  useEffect(() => {
    let mounted = true;
    fetchPlaces({ includeDrafts: false }).then(places => {
      if (mounted && places.length > 0) {
        console.log('[Spokkartan] Hämtade ' + places.length + ' platser från Supabase');
        setAllPlaces(places);
      }
    });
    const unsubscribe = subscribeToPlaces((payload) => {
      if (!mounted) return;
      if (payload.eventType === 'INSERT') setAllPlaces(prev => [...prev, payload.new]);
      else if (payload.eventType === 'UPDATE') setAllPlaces(prev => prev.map(p => p.id === payload.new.id ? payload.new : p));
      else if (payload.eventType === 'DELETE') setAllPlaces(prev => prev.filter(p => p.id !== payload.old.id));
    });
    return () => { mounted = false; unsubscribe(); };
  }, []);

  // ── Hantera ?welcome=pro return från Stripe ───────────────
  useEffect(() => {
    const params = new URLSearchParams(window.location.search);
    if (params.get('welcome') === 'pro') {
      setIsPro(true);
      // Optional: show a thank-you toast/modal here
      console.log('[Spokkartan] Välkommen som PRO!');
      // Clean URL
      window.history.replaceState({}, '', window.location.pathname);
    }
  }, []);

  // ── Supabase Auth state — sync user när Google-login slutförs ───
  useEffect(() => {
    let mounted = true;
    
    async function loadUserFromSession(session) {
      if (!session?.user) return null;
      const profile = await getProfile(session.user.id);
      const u = {
        id: session.user.id,
        email: session.user.email,
        name: profile?.full_name || session.user.user_metadata?.full_name || session.user.email?.split('@')[0],
        avatar: profile?.avatar_url || session.user.user_metadata?.avatar_url || '',
        role: profile?.role || 'user',
        pro: profile?.is_pro || false,
        bio: profile?.bio || '',
        verified: false,
      };
      return u;
    }

    // Initial session check
    getSession().then(async (session) => {
      if (!mounted || !session) return;
      const u = await loadUserFromSession(session);
      if (u && mounted) {
        setUser(u);
        setIsPro(u.pro || false);
        if (u.role === 'admin') console.log('[Spokkartan] Admin-läge tillgängligt');
      }
    });

    // Listen for changes (Google login, signOut, etc.)
    const unsub = onAuthChange(async (event, session) => {
      if (!mounted) return;
      if (event === 'SIGNED_IN' || event === 'TOKEN_REFRESHED') {
        const u = await loadUserFromSession(session);
        if (u && mounted) {
          setUser(u);
          setIsPro(u.pro || false);
        }
      } else if (event === 'SIGNED_OUT') {
        setUser(null);
        setIsPro(false);
      }
    });

    return () => { mounted = false; unsub(); };
  }, []);

  const [user,setUser]=useState(null);
  const [isPro,setIsPro]=useState(false);
  const [reading,setReading]=useState(null);
  const [mapSel,setMapSel]=useState(null);
  const [roadtrip,setRoadtrip]=useState([]);
  const [visited,setVisited]=useState([]);
  const [auth,setAuth]=useState(null);
  const [showPro,setShowPro]=useState(false);
  const [showBecomePartner,setShowBecomePartner]=useState(false);
  const [showNotif,setShowNotif]=useState(false);
  const [notifPrefs,setNotifPrefs]=useState({enabled:false,types:["new_place","new_hotel"],countries:["Sverige","Norge"],placeTypes:["Alla typer"],minScary:0,frequency:"weekly"});

  const [shareData,setShareData]=useState(null);
  const [showCancel,setShowCancel]=useState(false);

  const upgrade=useCallback(()=>{user?setShowPro(true):setAuth("login");},[user]);

  // If reading — fullscreen reader
  if(reading){
    return(<>
      <style>{CSS}</style>
      <Reader
        place={reading}
        allPlaces={allPlacesMut}
        isPro={isPro}
        onClose={()=>setReading(null)}
        onNavigate={p=>setReading(p)}
        upgrade={()=>{setReading(null);setShowPro(true);}}
        roadtrip={roadtrip}
        setRoadtrip={setRoadtrip}
        visited={visited}
        setVisited={setVisited}
        user={user}
        onShare={(title,url)=>setShareData({title,url})}
      />
      {showPro&&<ProModal onClose={()=>setShowPro(false)} onSuccess={()=>setIsPro(true)} isPro={isPro}/>}
    </>);
  }

  const NAV=[
    {id:"home",icon:"🏠",label:t("nav_home")},
    {id:"map",icon:"👻",label:t("nav_map")},
    {id:"stories",icon:"📖",label:t("nav_stories")},
    {id:"ebook",icon:"✨",label:t("nav_ebook")},
    {id:"partners",icon:"🌟",label:"Partners"},
    {id:"shop",icon:"🛒",label:t("nav_shop")},
    {id:"about",icon:"💜",label:"Om oss"},
    ...(user?.role==="ghosthunter"||user?.role==="admin"?[{id:"board",icon:"📋",label:"Anslagstavla"}]:[]),
    ...(user?.role==="admin"?[{id:"admin",icon:"⚙️",label:"Admin"}]:[]),
  ];

  return(
    <div style={{height:"100dvh",display:"flex",flexDirection:"column",background:"var(--bg)",overflow:"hidden"}}>
      <style>{CSS}</style>

      {/* HEADER */}
      <div style={{background:"rgba(7,6,15,0.97)",backdropFilter:"blur(18px)",WebkitBackdropFilter:"blur(18px)",borderBottom:"1px solid var(--b)",padding:"10px 14px",display:"flex",alignItems:"center",gap:9,flexShrink:0,zIndex:60}}>
        <button onClick={()=>setView("home")} style={{background:"none",border:"none",cursor:"pointer",display:"flex",alignItems:"center",gap:5,flexShrink:0}}>
          <span style={{fontSize:18}} className="af">👻</span>
          <span style={{fontSize:14,fontWeight:800,color:"var(--tx)"}}>Spökkartan</span>
        </button>
        <div style={{flex:1}}/>
        {user?(
          <div style={{display:"flex",gap:6,alignItems:"center"}}>
            <button onClick={()=>setShowNotif(true)} style={{background:notifPrefs.enabled?"rgba(124,58,237,0.15)":"var(--bg3)",border:`1px solid ${notifPrefs.enabled?"var(--acc)":"var(--b)"}`,borderRadius:9,padding:"6px 9px",cursor:"pointer",fontSize:14,position:"relative"}}>
              🔔{notifPrefs.enabled&&<span style={{position:"absolute",top:3,right:3,width:6,height:6,borderRadius:"50%",background:"var(--acc)",border:"1px solid var(--bg)"}}/>}
            </button>
            {isPro&&<Tag ch="PRO ✓" c="var(--acc)"/>}
            {!isPro&&<Btn ch="PRO" v="p" sz="sm" onClick={upgrade}/>}
            {isPro&&<button onClick={()=>setShowCancel(true)} style={{background:"none",border:"none",fontSize:10,color:"var(--tx4)",cursor:"pointer",padding:"4px"}}>Avsluta PRO</button>}
            <button onClick={async()=>{await supabaseSignOut().catch(()=>{});setUser(null);setIsPro(false);setView("home");}} style={{background:"var(--bg3)",border:"1px solid var(--b)",borderRadius:20,padding:"5px 10px",fontSize:11,fontWeight:500,color:"var(--tx3)",cursor:"pointer"}}>{user.name?.split(" ")[0]} ✕</button>
          </div>
        ):(
          <div style={{display:"flex",gap:5}}>
            <button onClick={()=>setShowNotif(true)} style={{background:"var(--bg3)",border:"1px solid var(--b)",borderRadius:9,padding:"6px 9px",cursor:"pointer",fontSize:14}}>🔔</button>
            <LanguagePicker lang={lang} setLang={setLang} langs={langs} t={t}/>
            <Btn ch={t("login_title")} v="ghost" sz="sm" onClick={()=>setAuth("login")}/>
            <Btn ch="PRO" v="p" sz="sm" onClick={upgrade}/>
            <Btn ch="⚙️" v="ghost" sz="sm" onClick={()=>setAuth("admin")} style={{padding:"8px 10px"}}/>
          </div>
        )}
      </div>

      {/* MAIN */}
      <div style={{flex:1,display:"flex",overflow:"hidden",minHeight:0}}>

        {/* HOME */}
        {view==="home"&&(
          <div style={{flex:1,overflowY:"auto"}}>
            <div style={{background:"linear-gradient(160deg,#110c26,#08070e)",padding:"24px 16px 18px",borderBottom:"1px solid var(--b)"}}>
              <div style={{fontSize:10,fontWeight:700,color:"#a78bfa",letterSpacing:3,textTransform:"uppercase",marginBottom:7}}>👻 Spökkartan</div>
              <h1 style={{fontSize:"clamp(22px,6vw,32px)",fontWeight:800,color:"var(--tx)",lineHeight:1.15,marginBottom:7}}>{(()=>{const w=t("hero_title").split(" "); return <>{w.slice(0,-2).join(" ")} <span className="gt">{w.slice(-2).join(" ")}</span></>;})()}</h1>
              <p style={{fontSize:13,color:"var(--tx2)",lineHeight:1.7,marginBottom:14}}>{t("hero_subtitle_template",{country:"Sverige",n:allPlacesMut.length,countries:new Set(allPlacesMut.map(p=>p.country)).size})}</p>
              <div style={{display:"flex",gap:6,flexWrap:"wrap",marginBottom:16}}>
                <Tag ch={`👻 ${allPlacesMut.length} platser`} c="var(--acc)"/>
                <Tag ch="🌍 9 länder" c="#60a5fa"/>
                <Tag ch={`🏨 ${allPlacesMut.filter(p=>p.bookable).length} bokningsbara`} c="#34d399"/>
              </div>
              {!isPro&&(
                <div style={{background:"rgba(212,175,55,0.08)",border:"1px solid rgba(212,175,55,0.3)",borderRadius:12,padding:"12px 14px",marginBottom:16}}>
                  <div style={{fontSize:12,fontWeight:700,color:"#d4af37",marginBottom:2}}>🎉 Prova PRO för 19 kr — första månaden</div>
                  <div style={{fontSize:11,color:"var(--tx3)",marginBottom:10}}>Alla platser · GPS · Roadtrip · E-bok-builder</div>
                  <Btn ch={"👻 " + t("btn_try_pro") + " →"} v="gold" full onClick={upgrade}/>
                </div>
              )}
            </div>
            <div style={{padding:"14px 16px",display:"grid",gridTemplateColumns:"1fr 1fr",gap:10}}>
              {[["👻",t("card_map_title"),t("card_map_desc"),"map"],["📖",t("card_stories_title"),t("card_stories_desc"),"stories"],["✨",t("card_ebook_title"),t("card_ebook_desc"),"ebook"],["🔍",t("card_hunters_title"),t("card_hunters_desc"),"hunters"]].map(([icon,label,desc,target])=>(
                <div key={target} className="card card-tap" style={{padding:"14px"}} onClick={()=>setView(target)}>
                  <div style={{fontSize:24,marginBottom:6}}>{icon}</div>
                  <div style={{fontSize:13,fontWeight:700,color:"var(--tx)",marginBottom:2}}>{label}</div>
                  <div style={{fontSize:10,color:"var(--tx3)",lineHeight:1.4}}>{desc}</div>
                </div>
              ))}
            </div>
            {/* Haunted hotels */}
            <div style={{padding:"0 16px 80px"}}>
              <div style={{fontSize:13,fontWeight:700,color:"var(--tx)",marginBottom:10}}>🏨 Hemsökta Hotell</div>
              <div style={{display:"flex",gap:10,overflowX:"auto",paddingBottom:4}}>
                {HAUNTED_HOTELS.map((h,i)=>(
                  <a key={i} href={h.url} target="_blank" rel="noreferrer" style={{minWidth:150,flex:"0 0 150px",background:"var(--card)",border:"1px solid var(--b)",borderRadius:12,padding:"11px",display:"block"}}>
                    <div style={{fontSize:11,color:"var(--tx3)",marginBottom:3}}>{FLAG[h.country]||"🌍"} {h.region}</div>
                    <div style={{fontSize:12,fontWeight:700,color:"var(--tx)",marginBottom:4,lineHeight:1.3}}>{h.name}</div>
                    <div style={{fontSize:11,fontWeight:700,color:"#d4af37",marginBottom:6}}>{h.price}</div>
                    <div style={{fontSize:10,fontWeight:600,color:"#34d399"}}>Boka →</div>
                  </a>
                ))}
              </div>
            </div>
          </div>
        )}

        {/* MAP / SPÖKKARTAN */}
        {view==="map"&&(
          <div style={{flex:1,position:"relative",overflow:"hidden"}}>
            <SpokMap places={allPlacesMut} onSelect={setMapSel}/>
            {/* Stats bar */}
            <div style={{position:"absolute",bottom:16,left:12,zIndex:400,background:"rgba(13,11,27,0.93)",border:"1px solid var(--b2)",borderRadius:10,padding:"6px 12px",display:"flex",gap:10,backdropFilter:"blur(10px)"}}>
              <span style={{fontSize:10,color:"#34d399"}}>👻 {allPlacesMut.length} platser</span>
              <span style={{fontSize:10,color:"#a78bfa"}}>🌍 9 länder</span>
            </div>
          </div>
        )}

        {/* STORIES */}
        {view==="stories"&&(
          <StoriesView places={allPlacesMut} isPro={isPro} onRead={setReading}/>
        )}

        {/* EBOOK */}
        {view==="ebook"&&(
          <div style={{flex:1,display:"flex",flexDirection:"column",overflow:"hidden"}}>
            <div style={{padding:"11px 14px 9px",borderBottom:"1px solid var(--b)",flexShrink:0}}>
              <div style={{fontSize:15,fontWeight:800,color:"var(--tx)",marginBottom:1}}>✨ Bygg din e-bok</div>
              <div style={{fontSize:11,color:"var(--tx3)"}}>Välj platser · <span style={{color:"#d4af37",fontWeight:600}}>1-10 = 29 kr · 11-20 = 39 kr</span></div>
            </div>
            <EbookBuilder allPlaces={allPlacesMut}/>
          </div>
        )}

        {/* SHOP */}
        {view==="shop"&&(
          <div style={{flex:1,overflowY:"auto",padding:"14px 16px",paddingBottom:80}}>
            <h2 style={{fontSize:15,fontWeight:800,color:"var(--tx)",marginBottom:4}}>🛒 Shop</h2>
            <p style={{fontSize:11,color:"var(--tx3)",marginBottom:14}}>Ghost Tours & hemsökta hotell via affiliate · Spökjaktutrustning via Amazon Associates</p>
            <div style={{fontSize:12,fontWeight:700,color:"var(--tx)",marginBottom:8}}>🎃 Ghost Tours</div>
            {GHOST_TOURS.map((t,i)=>(
              <div key={i} style={{background:"var(--card)",border:"1px solid var(--b)",borderRadius:12,padding:"13px",marginBottom:9}}>
                <div style={{display:"flex",justifyContent:"space-between",marginBottom:5}}>
                  <span style={{fontSize:12,fontWeight:700,color:"var(--tx)"}}>{t.name}</span>
                  <Tag ch={t.partner} c="var(--tx3)"/>
                </div>
                <div style={{fontSize:10,color:"var(--tx3)",marginBottom:8}}>{t.city} · {t.duration} · {"★".repeat(Math.round(t.rating))} {t.rating} ({t.reviews.toLocaleString()})</div>
                <div style={{display:"flex",justifyContent:"space-between",alignItems:"center"}}>
                  <span style={{fontSize:14,fontWeight:800,color:"var(--tx)"}}>{t.price}</span>
                  <a href={t.url} target="_blank" rel="noreferrer" style={{background:"linear-gradient(135deg,var(--acc),var(--acc3))",borderRadius:8,padding:"7px 14px",fontSize:11,fontWeight:700,color:"#fff"}}>Boka →</a>
                </div>
              </div>
            ))}
            <div style={{fontSize:12,fontWeight:700,color:"var(--tx)",marginTop:16,marginBottom:8}}>🔦 Spökjaktutrustning (Amazon)</div>
            <div style={{display:"grid",gridTemplateColumns:"1fr 1fr",gap:9}}>
              {[["📡","EMF-mätare","emf+detektor"],["📷","IR-kameror","infraröd+kamera+nattseende"],["🎙️","Röstinspelare","digital+röstinspelare+EVP"],["🔦","UV-ficklampor","uv+ficklampa+395nm"],["🌡️","Termometrar","infraröd+termometer"],["📚","Spöklitteratur","hemsökta+platser+Sverige+bok"]].map(([icon,name,q])=>(
                <a key={name} href={`https://www.amazon.se/s?k=${q}&tag=${AMAZON_TAG}`} target="_blank" rel="noreferrer" style={{background:"var(--card)",border:"1px solid var(--b)",borderRadius:11,padding:"13px",display:"block",textDecoration:"none"}}>
                  <div style={{fontSize:26,marginBottom:6}}>{icon}</div>
                  <div style={{fontSize:11,fontWeight:700,color:"var(--tx)",marginBottom:4}}>{name}</div>
                  <div style={{fontSize:10,fontWeight:600,color:"#ff9900"}}>Amazon.se →</div>
                </a>
              ))}
            </div>
          </div>
        )}

        {/* HUNTERS */}
        {view==="hunters"&&<HuntersPage user={user} setAuth={setAuth} setView={setView}/>}
        {view==="partners"&&<PartnersView user={user} onAuth={setAuth} onCreate={()=>user?setShowBecomePartner(true):setAuth("login")}/>}
        {view==="about"&&<AboutPage setView={setView}/>}

        {/* BOARD */}
        {view==="board"&&(
          (user?.role==="ghosthunter"||user?.role==="admin")
            ?<BulletinBoard user={user}/>
            :(
              <div style={{flex:1,display:"flex",flexDirection:"column",alignItems:"center",justifyContent:"center",padding:32,textAlign:"center"}}>
                <div style={{fontSize:48,marginBottom:14}}>📋</div>
                <div style={{fontSize:16,fontWeight:800,color:"var(--tx)",marginBottom:6}}>Anslagstavlan</div>
                <div style={{fontSize:13,color:"var(--tx3)",lineHeight:1.7,marginBottom:18,maxWidth:300}}>
                  {!user?"Logga in som verifierad spökjägare för att komma åt anslagstavlan.":"Din ansökan väntar på verifiering av Fredrik."}
                </div>
                {!user&&<Btn ch="Logga in" v="p" onClick={()=>setAuth("login")}/>}
              </div>
            )
        )}

        {/* ADMIN */}
        {view==="admin"&&(
          user?.role==="admin"
            ?<AdminDash allPlaces={allPlacesMut} setAllPlaces={setAllPlaces} user={user} onLogout={()=>{setUser(null);setIsPro(false);setView("home");}}/>
            :<div style={{flex:1,display:"flex",flexDirection:"column",alignItems:"center",justifyContent:"center",padding:32,textAlign:"center"}}>
              <div style={{fontSize:48,marginBottom:14}}>⚙️</div>
              <Btn ch="Logga in som admin" v="p" onClick={()=>setAuth("admin")}/>
            </div>
        )}

      </div>

      {/* BOTTOM NAV */}
      <div className="bottom-nav">
        {NAV.map(item=>(
          <button key={item.id} className={`nav-btn${view===item.id?" active":""}`} onClick={()=>setView(item.id)}>
            <span>{item.icon}</span>
            <span>{item.label}</span>
          </button>
        ))}
      </div>

      {/* MAP PLACE POPUP */}
      {mapSel&&<PlacePopup place={mapSel} isPro={isPro} onRead={p=>{setMapSel(null);setReading(p);}} onClose={()=>setMapSel(null)} onAddRoadtrip={id=>setRoadtrip(r=>r.includes(id)?r.filter(x=>x!==id):[...r,id])} inRoadtrip={roadtrip.includes(mapSel?.id)}/>}

      {/* NOTIFICATION MODAL */}
      {showNotif&&<NotificationModal user={user} prefs={notifPrefs} setPrefs={setNotifPrefs} onClose={()=>setShowNotif(false)}/>}

      {/* AUTH MODAL */}
      {auth&&<AuthModal initMode={auth} onClose={()=>setAuth(null)} onSuccess={u=>{setUser(u);setIsPro(u.pro||false);setAuth(null);if(u.role==="admin")setView("admin");}}/>}

      {/* PRO MODAL */}
      {showPro&&<ProModal onClose={()=>setShowPro(false)} onSuccess={()=>setIsPro(true)} isPro={isPro}/>}
      {showBecomePartner&&<BecomePartnerModal user={user} onClose={()=>setShowBecomePartner(false)} onSuccess={()=>{setShowBecomePartner(false); alert("✅ Tack! Din ansökan är inskickad. Vi godkänner inom 24h och skickar bokstavligen e-post.");}}/>}

      {/* SHARE MODAL */}
      {shareData&&<ShareMenu title={shareData.title} url={shareData.url} onClose={()=>setShareData(null)}/>}

      {/* CANCEL SUBSCRIPTION */}
      {showCancel&&<CancelSubModal onClose={()=>setShowCancel(false)} onConfirm={()=>{setIsPro(false);}}/>}
    </div>
  );
}
