

import { useState } from 'react';
import QRCodeValidator from './QRCodeValidator';
import './App.css';

const docs = {
  en: [
    { name: 'Cover Letter', file: 'cover-letter-en.html' },
    { name: 'Affidavit', file: 'affidavit-en.html' },
    { name: 'Annex A: GRU Legal Framework', file: 'annex-a-en.html' },
    { name: 'Annex B: Asset Collateral Table', file: 'annex-b-en.html' },
    { name: 'Annex C: Treaties & Precedents', file: 'annex-c-en.html' },
    { name: 'Executive Abstract', file: 'executive-abstract-en.html' },
    { name: 'Board Escalation Memo', file: 'board-memo-en.html' },
    { name: 'Chain of Custody Certificate', file: 'chain-of-custody-en.html' },
    { name: 'Acknowledgment Postcard', file: 'acknowledgment-en.html' },
    { name: 'Courier Dispatch Register', file: 'register-en.html' },
  ],
  fr: [
    { name: 'Lettre de Couverture', file: 'cover-letter-fr.html' },
    { name: 'Affidavit', file: 'affidavit-fr.html' },
  ],
  ar: [
    { name: 'خطاب التغطية', file: 'cover-letter-ar.html' },
    { name: 'إفادة إبراء الذمة', file: 'affidavit-ar.html' },
  ],
  pt: [
    { name: 'Carta de Apresentação', file: 'cover-letter-pt.html' },
    { name: 'Affidavit', file: 'affidavit-pt.html' },
  ],
};

const langNames = {
  en: 'English',
  fr: 'Français',
  ar: 'العربية',
  pt: 'Português',
};


function App() {
  const [lang, setLang] = useState<'en' | 'fr' | 'ar' | 'pt'>('en');
  const [doc, setDoc] = useState<string | null>(null);
  const [showQR, setShowQR] = useState(false);

  return (
    <div className="App">
      <header>
        <h1>Absolute Realms Document Portal</h1>
        <div style={{ marginBottom: 16 }}>
          {Object.entries(langNames).map(([code, label]) => (
            <button
              key={code}
              onClick={() => { setLang(code as any); setDoc(null); }}
              style={{ marginRight: 8, fontWeight: lang === code ? 'bold' : 'normal' }}
            >
              {label}
            </button>
          ))}
        </div>
      </header>
      <main>
        {!doc ? (
          <div>
            <h2>Available Documents ({langNames[lang]})</h2>
            <ul>
              {docs[lang].map((d) => (
                <li key={d.file}>
                  <button onClick={() => setDoc(d.file)}>{d.name}</button>
                </li>
              ))}
            </ul>
          </div>
        ) : (
          <div>
            <button onClick={() => setDoc(null)} style={{ marginBottom: 12 }}>&larr; Back to list</button>
            <button onClick={() => setShowQR(true)} style={{ float: 'right', marginBottom: 12 }}>
              Validate QR Code
            </button>
            <iframe
              src={`/documents/${doc}`}
              title={doc}
              style={{ width: '100%', height: '80vh', border: '1px solid #ccc' }}
            />
            {showQR && (
              <div style={{
                position: 'fixed', top: 0, left: 0, width: '100vw', height: '100vh',
                background: 'rgba(0,0,0,0.4)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000
              }}>
                <div style={{ background: '#fff', borderRadius: 8, boxShadow: '0 2px 12px #0003', padding: 24, minWidth: 320 }}>
                  <button onClick={() => setShowQR(false)} style={{ float: 'right' }}>✕</button>
                  <QRCodeValidator />
                </div>
              </div>
            )}
          </div>
        )}
      </main>
      <footer style={{ marginTop: 32, fontSize: 12, color: '#888' }}>
        &copy; 2025 Absolute Realms | Organisation Mondiale du Numérique, LPBCA
      </footer>
    </div>
  );
}

export default App;
