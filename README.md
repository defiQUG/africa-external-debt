
# Absolute Realms Document Portal

This portal hosts legal documents for the Absolute Realms Sovereign Discharge package, with multilingual support and QR code validation.

## Features
- Multilingual navigation (English, French, Arabic, Portuguese)
- All documents available in HTML format
- QR code validation modal integrated into each document view
- Downloadable couriered copies
- Ready for Azure Static Web Apps or App Service deployment

## Usage

### Local Development
```bash
npm install
npm run dev
```
Visit http://localhost:5173

### Build for Production
```bash
npm run build
```
The output will be in the `dist/` folder.

### QR Code Validation
- Click "Validate QR Code" in any document view to open the validation modal.
- For demo, enter `UCC1-20242029991` to simulate a valid code.

### Multilingual Support
- Use the language buttons at the top to switch between English, French, Arabic, and Portuguese.

## Azure Deployment

### Azure Static Web Apps (Recommended)
1. Push your code to GitHub.
2. In the Azure Portal, create a new Static Web App and link your repo.
3. Set the build output folder to `dist`.
4. The included `staticwebapp.config.json` handles routing and security.

### Azure App Service
1. Build the app (`npm run build`).
2. Deploy the `dist/` folder as your web root.
3. Ensure your App Service serves static files from `dist`.

## Security & Compliance
- No personal data is collected.
- See `privacy.html` and `terms.html` for details.

## Contact
For questions, contact worlddebt@mondialenumerique.org
