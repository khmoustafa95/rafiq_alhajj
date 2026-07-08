/**
 * Canonical legal page URLs for staging and production hosting.
 * Used by CI, bootstrap, and verify scripts.
 */

/** Staging Firebase Hosting site */
export const STAGING_HOST = "https://rafiq-alhajj-staging.web.app";

/** Replace when production hosting is live */
export const PRODUCTION_HOST = "https://YOUR_HOSTING_DOMAIN";

/**
 * @param {string} host Base URL without trailing slash
 * @returns {Record<string, string>}
 */
export function legalUrlsForHost(host) {
  const base = host.replace(/\/$/, "");
  return {
    PRIVACY_POLICY_URL: `${base}/legal/privacy.html`,
    TERMS_OF_SERVICE_URL: `${base}/legal/terms.html`,
    ACCOUNT_DELETION_INFO_URL: `${base}/legal/account-deletion.html`,
  };
}

export const STAGING_LEGAL_URLS = legalUrlsForHost(STAGING_HOST);
export const PRODUCTION_LEGAL_URLS = legalUrlsForHost(PRODUCTION_HOST);

/** Edge functions required for store-readiness on staging/production */
export const STORE_EDGE_FUNCTIONS = [
  "create-pilgrim",
  "manage-operator",
  "import-pilgrims",
  "reset-pilgrim-password",
  "send-push-notification",
  "delete-my-account",
  "promote-to-admin",
];
