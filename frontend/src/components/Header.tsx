import styles from './Header.module.css';
import type { HeaderProps } from '../types';

export function Header(_props: HeaderProps) {
  return (
    <header className={styles.header}>
      <h1 className={styles.title}>AI Transcript</h1>
      <p className={styles.subtitle}>
        Speech-to-text transcription with local AI cleaning
      </p>
    </header>
  );
}
