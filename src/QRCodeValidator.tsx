import { useRef, useState } from 'react';

export default function QRCodeValidator() {
  const [result, setResult] = useState<string | null>(null);
  const inputRef = useRef<HTMLInputElement>(null);

  // Simulate QR code validation (replace with real logic or API call)
  function handleValidate() {
    const value = inputRef.current?.value?.trim();
    if (!value) {
      setResult('Please enter or scan a QR code value.');
      return;
    }
    // Example: Accept only a specific UCC-1 code for demo
    if (value === 'UCC1-20242029991') {
      setResult('✅ Valid UCC-1 Filing: 20242029991 (Colorado Secretary of State)');
    } else {
      setResult('❌ Invalid or unrecognized QR code.');
    }
  }

  return (
    <div style={{ padding: 16, maxWidth: 400 }}>
      <h3>QR Code Validation</h3>
      <input
        ref={inputRef}
        type="text"
        placeholder="Scan or enter QR code value"
        style={{ width: '100%', marginBottom: 8 }}
      />
      <button onClick={handleValidate} style={{ width: '100%' }}>
        Validate
      </button>
      {result && <div style={{ marginTop: 12 }}>{result}</div>}
      <p style={{ fontSize: 12, color: '#888', marginTop: 16 }}>
        (For demo: enter <code>UCC1-20242029991</code> to simulate a valid code)
      </p>
    </div>
  );
}
