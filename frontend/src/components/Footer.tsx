import styles from './Footer.module.css';

export function Footer() {
  return (
    <footer className={styles.footer}>
      <p className={styles.text}>
        Created & Developed by <span className={styles.author}>Hugo Sanabria</span>
      </p>
      <p className={styles.subtext}>
        Local AI-Powered Voice Transcription & LLM Processing
      </p>
    </footer>
  );
}

