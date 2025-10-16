// Browser language detection FFI for Gleam
import { Ok, Error } from "./gleam.mjs";

/**
 * Get the browser's preferred language
 * @returns {Result} Gleam Result type with language string or error
 */
export function getBrowserLanguage() {
  try {
    // Check if we're in a browser environment
    if (typeof window === 'undefined') {
      return new Error("Not running in browser environment");
    }

    // Check if navigator exists
    if (!window.navigator) {
      return new Error("Navigator not available");
    }

    // Try to get language from navigator.language
    if (window.navigator.language) {
      return new Ok(window.navigator.language);
    }

    // Fallback: try navigator.languages[0]
    if (window.navigator.languages && window.navigator.languages.length > 0) {
      return new Ok(window.navigator.languages[0]);
    }

    // Fallback: try navigator.userLanguage (older IE)
    if (window.navigator.userLanguage) {
      return new Ok(window.navigator.userLanguage);
    }

    // No language information available
    return new Error("No language information available");

  } catch (error) {
    return new Error(`JavaScript error: ${error.toString()}`);
  }
}

/**
 * Set the theme attribute on the HTML element for DaisyUI
 * @param {string} theme - The theme name ("light" or "dark")
 */
export function setThemeAttribute(theme) {
  try {
    // Check if we're in a browser environment
    if (typeof document === 'undefined') {
      return;
    }

    // Set data-theme attribute on html element
    const htmlElement = document.documentElement;
    if (htmlElement) {
      htmlElement.setAttribute('data-theme', theme);
    }
  } catch (error) {
    console.error('Failed to set theme attribute:', error);
  }
}